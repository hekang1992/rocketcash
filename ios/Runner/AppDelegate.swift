import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
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
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
