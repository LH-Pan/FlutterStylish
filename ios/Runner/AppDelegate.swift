import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let testChannel = FlutterMethodChannel(name: "TestMethodChannel",
                                              binaryMessenger: controller.binaryMessenger)
    testChannel.setMethodCallHandler({
     [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      // This method is invoked on the UI thread.
      guard 
        call.method == "getTestPlatformString"
      else { 
        result(FlutterMethodNotImplemented) 
        return
      }

       self?.getTestPlatformString(result: result)
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func getTestPlatformString(result: @escaping FlutterResult) {
    
    result("This is「iOS」Test Method Channel String")
  }
}
