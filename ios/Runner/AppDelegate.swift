import Flutter
import UIKit
import StoreKit
import FBSDKCoreKit
import Foundation

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
                    let screenSize = UIScreen.main.bounds.size
                    self.grayView.backgroundColor = .black
                    self.grayView.frame = CGRectMake(
                        screenSize.width - 70, screenSize.height - self.getBottomSafeAreaHeight() - 127, 80, 80)
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
        
        let channel7 = FlutterMethodChannel(
            name: "judge_fate", binaryMessenger: controller.binaryMessenger)
        channel7.setMethodCallHandler { (call, result) in
            if call.method == "judgefate" {
                if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                    SKStoreReviewController.requestReview(in: scene)
                }
            }
        }
        
        let channel8 = FlutterMethodChannel(
            name: "send_email", binaryMessenger: controller.binaryMessenger)
        channel8.setMethodCallHandler { (call, result) in
            if call.method == "sendemail" {
                if let args = call.arguments as? [String: Any],
                   let email = args["email"] as? String,
                   let phone = args["phone"] as? String {
                    if email.contains("email:"), let range = email.range(of: ":") {
                        let emailuRL = String(email[range.upperBound...])
                        let bodyContent = "RocketCash: \(phone)"
                        let mailtoURLString = "mailto:\(emailuRL)?body=\(bodyContent.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
                        if let mailtoURL = URL(string: mailtoURLString), UIApplication.shared.canOpenURL(mailtoURL) {
                            UIApplication.shared.open(mailtoURL, options: [:], completionHandler: nil)
                        }
                    }
                } else {
                    result(FlutterError(code: "INVALID_ARGUMENT", message: "Missing email or phone", details: nil))
                }
            }
        }
        
        let channel9 = FlutterMethodChannel(
            name: "face_book", binaryMessenger: controller.binaryMessenger)
        channel9.setMethodCallHandler { (call, result) in
            if call.method == "facebook" {
                if let jsonData = call.arguments as? [String: Any] {
                    Settings.shared.appID = jsonData["appid"] as? String ?? ""
                    Settings.shared.clientToken = jsonData["token"] as? String ?? ""
                    Settings.shared.displayName = jsonData["name"] as? String ?? ""
                    Settings.shared.appURLSchemeSuffix = jsonData["scheme"] as? String ?? ""
                    ApplicationDelegate.shared.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
                    result(nil)
                } else {
                    result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid JSON data", details: nil))
                }
            }
        }
        
        let channel10 = FlutterMethodChannel(
            name: "uptime_util", binaryMessenger: controller.binaryMessenger)
        channel10.setMethodCallHandler { (call, result) in
            if call.method == "isuptimeroxy" {
                let systemUptime = ProcessInfo.processInfo.systemUptime
                result(String(format: "%.0f", systemUptime * 1000))
            }
        }
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}

extension AppDelegate {
    
    private func getBottomSafeAreaHeight() -> Double {
        var bottomInset: CGFloat = 0
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.windows.first
            bottomInset = window?.safeAreaInsets.bottom ?? 0
        }
        return bottomInset
    }
    
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
