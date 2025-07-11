import Flutter
import UIKit

let screen_width = UIScreen.main.bounds.size.width
let screen_height = UIScreen.main.bounds.size.height

@main
@objc class AppDelegate: FlutterAppDelegate {

    lazy var grayView: UIView = {
        let grayView = UIView()
        grayView.backgroundColor = .black
        return grayView
    }()

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        let controller = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(
            name: "contact_service",
            binaryMessenger: controller.binaryMessenger
        )

        let contactHandler = ContactHandler()

        channel.setMethodCallHandler { call, result in
            switch call.method {
            case "getAllContacts":
                contactHandler.getAllContacts(result: result)
            case "pickSingleContact":
                contactHandler.pickSingleContact(result: result)
            default:
                result(FlutterMethodNotImplemented)
            }
        }

        let channel1 = FlutterMethodChannel(
            name: "device/memory", binaryMessenger: controller.binaryMessenger)

        channel1.setMethodCallHandler { (call, result) in
            if call.method == "getMemoryInfo" {
                let totalMemory = ProcessInfo.processInfo.physicalMemory

                var vmStats = vm_statistics64()
                var count = mach_msg_type_number_t(
                    MemoryLayout<vm_statistics64_data_t>.stride / MemoryLayout<integer_t>.stride)

                let HOST_VM_INFO64_COUNT = mach_msg_type_number_t(
                    MemoryLayout<vm_statistics64_data_t>.size / MemoryLayout<integer_t>.size)
                let resultCode = withUnsafeMutablePointer(to: &vmStats) {
                    $0.withMemoryRebound(to: integer_t.self, capacity: Int(count)) {
                        host_statistics64(mach_host_self(), HOST_VM_INFO64, $0, &count)
                    }
                }

                var freeMemory: UInt64 = 0
                if resultCode == KERN_SUCCESS {
                    let pageSize = UInt64(vm_kernel_page_size)
                    freeMemory =
                        (UInt64(vmStats.free_count) + UInt64(vmStats.inactive_count)) * pageSize
                }

                result([
                    "totalMemory": Int(totalMemory),
                    "freeMemory": Int(freeMemory),
                ])
            } else {
                result(FlutterMethodNotImplemented)
            }
        }

        let channel2 = FlutterMethodChannel(
            name: "proxy_util", binaryMessenger: controller.binaryMessenger)
        channel2.setMethodCallHandler { (call, result) in
            if call.method == "isUsingProxy" {
                result(self.isProxyEnabled())
            }
        }

        let channel3 = FlutterMethodChannel(
            name: "vpn_util", binaryMessenger: controller.binaryMessenger)
        channel3.setMethodCallHandler { (call, result) in
            if call.method == "isUsingVPN" {
                result(self.isVPNConnected() ? 1 : 0)
            }
        }

        let channel4 = FlutterMethodChannel(
            name: "en_us", binaryMessenger: controller.binaryMessenger)
        channel4.setMethodCallHandler { (call, result) in
            if call.method == "language" {
                result(Locale.preferredLanguages.first)
            }
        }

        let channel5 = FlutterMethodChannel(
            name: "get_window", binaryMessenger: controller.binaryMessenger)
        channel5.setMethodCallHandler { (call, result) in
            if call.method == "getwindow" {
                if let window = UIApplication.shared.windows.first {
                    print("window=========\(window)")
                    self.grayView.backgroundColor = .black
                    self.grayView.frame = CGRectMake(
                        screen_width - 100, screen_height - 150, 120, 120)
                    window.addSubview(self.grayView)
                } else {
                    result(
                        FlutterError(code: "NO_WINDOW", message: "No window found", details: nil))
                }
            }
        }

        let channel6 = FlutterMethodChannel(
            name: "hide_window", binaryMessenger: controller.binaryMessenger)
        channel6.setMethodCallHandler { (call, result) in
            if call.method == "hidewindow" {
                self.grayView.backgroundColor = UIColor.clear
                self.grayView.removeFromSuperview()
            }
        }

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}

extension AppDelegate {

    func isProxyEnabled() -> Int {
        guard
            let proxySettings = CFNetworkCopySystemProxySettings()?.takeRetainedValue()
                as? [String: Any]
        else {
            return 0
        }

        if let httpEnable = proxySettings["HTTPEnable"] as? Int, httpEnable == 1 {
            return 1
        }
        if let httpsEnable = proxySettings["HTTPSEnable"] as? Int, httpsEnable == 1 {
            return 1
        }

        return 0
    }

    func isVPNConnected() -> Bool {
        guard let cfDict = CFNetworkCopySystemProxySettings(),
            let nsDict = cfDict.takeRetainedValue() as? [String: Any],
            let scopes = nsDict["__SCOPED__"] as? [String: Any]
        else {
            return false
        }

        for key in scopes.keys {
            if key.contains("tap") || key.contains("tun") || key.contains("ppp")
                || key.contains("ipsec") || key.contains("ipsec0") || key.contains("utun")
            {
                return true
            }
        }

        return false
    }

}
