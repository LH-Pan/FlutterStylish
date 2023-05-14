import UIKit
import Flutter
//import TPDirect
import GoogleMaps

@UIApplicationMain

@objc class AppDelegate: FlutterAppDelegate {
    
    private let appID: Int32 = 12348
    
    private let appKey: String = "app_pa1pQcKoY22IlnSXq5m5WP5jFKzoRG58VEXpT7wU62ud7mMbDOGzCYIlzzLF"
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let testChannel = FlutterMethodChannel(name: "TestMethodChannel",
                                               binaryMessenger: controller.binaryMessenger)
        testChannel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            
            self?.handle(call, result: result)
        })
        
        GeneratedPluginRegistrant.register(with: self)

        GMSServices.provideAPIKey("AIzaSyBHO5ilHDSOUN4A8TcKG6Di3bSNcB9SQzc")

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func getTestPlatformString(result: @escaping FlutterResult) {
        
        result("This is「iOS」Test Method Channel String")
    }
    
//    private func setupTappay(result: @escaping FlutterResult) {
//
//        TPDSetup.setWithAppId(appID, withAppKey: appKey, with: .sandBox)
//
//        result("Tap Pay setup succeed")
//    }
    
//    private func getPrime(args: [String:Any]?, prime: @escaping(String) -> Void, failCallBack: @escaping(String) -> Void) {
//
//        let cardNumber = (args?["cardNumber"] as? String ?? "")
//        let dueMonth = (args?["dueMonth"] as? String ?? "")
//        let dueYear = (args?["dueYear"] as? String ?? "")
//        let ccv = (args?["ccv"] as? String ?? "")
//
//        let card = TPDCard.setWithCardNumber(cardNumber, withDueMonth: dueMonth, withDueYear: dueYear, withCCV: ccv)
//
//        card.onSuccessCallback { (tpPrime, cardInfo, cardIdentifier, merchantReferenceInfo) in
//
//            if let tpPrime = tpPrime {
//
//                prime("{\"status\":\"\", \"message\":\"\", \"prime\":\"\(tpPrime)\"}")
//            }
//
//        }.onFailureCallback { (status, message) in
//
//            failCallBack("{\"status\":\"\(status)\", \"message\":\"\(message)\", \"prime\":\"\"}")
//
//        }.createToken(withGeoLocation: "UNKNOWN")
//    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        let method = call.method
        
        switch method {
            
        case "getTestPlatformString":
            
            getTestPlatformString(result: result)
            
//        case "setupTappay":
            
//            setupTappay(result: result)
            
//        case "getPrime":
//            
//            getPrime(args: call.arguments as? [String : Any] ?? [:]) { prime in
//                
//                result(prime)
//                
//            } failCallBack: { message in
//                
//                result(message)
//            }
            
        default:
            
            result("iOS " + UIDevice.current.systemVersion)
        }
    }
}
