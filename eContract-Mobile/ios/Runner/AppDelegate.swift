import UIKit
import SwiftUI
import Flutter
import LocalAuthentication
import BkavEkycSDK

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
     
  var flutterResult : FlutterResult?
     
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      let controller :FlutterViewController = window?.rootViewController as! FlutterViewController
          let channel = FlutterMethodChannel(name: "com.bkav.econtract.dev/bkav_channel",
                                                          binaryMessenger: controller.binaryMessenger)
      
      //chanel
       channel.setMethodCallHandler({ [self]
           (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
           switch call.method {
                          case "getBiometricType":
                            result("\(self.biometricType)")
                               break
                          case "getStatusBiometric":
                           let context = LAContext()
                              context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,error: nil)
                           if let domainState = context.evaluatedPolicyDomainState {
                                  let bData = domainState.base64EncodedData()
                                  if let decodedString = String(data: bData, encoding: .utf8) {
                                      result("\(decodedString)")
                                  }
                                   }else{
                                       result("")
                                   }
                                break
                          case "dateCallBackIOSEKYC":
                     
                          self.flutterResult = result
                     
                          let argument = call.arguments as? [String: AnyObject]
                          let accessToken:String = argument!["accessToken"] as? String ?? ""
                          let typeID:String = argument!["typeId"] as? String ?? "8"
                    
                        let swiftUIView = ContentView(
                               typeID: Int(typeID) ?? 8 ,
                               accessToken: accessToken,
                               backgroundColor:0xdee9f3,
                               textColor: 0x000000,
                               sizeText: 14,
                               sizeTitle: 20,
                               dismissAction: {dataResultCallBack in
                                                          
                               self.window?.rootViewController?.dismiss(animated: true)
                                                     
                              // xử lý datacallback nhận được khi thực hiện xác thực xong
                          
                              // let jsonString = String(data: dataResultCallBack, encoding: .utf8)
                                    
                                //var transactionId: String = convertDataResultCallBack(dataResultCallBack: dataResultCallBack)
                                self.flutterResult!(dataResultCallBack)
                            }
                        )
                     
                     let controler = UIHostingController(rootView: swiftUIView)
                     controler.modalPresentationStyle = .fullScreen
                     self.window?.rootViewController?.present(controler, animated: true, completion: nil)
          
                     break
                               break
                                    
                          default : result("86")
                               
                     }
       })
      
      GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    enum BiometricType: String {
        case none = ""
        case touchID = "Touch ID"
        case faceID = "Face ID"
    }

    var biometricType: BiometricType {
        var error: NSError?

        let context = LAContext()

        _ = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)

        if error?.code == LAError.Code.touchIDNotAvailable.rawValue {
            return .none
        }

        if #available(iOS 11.0, *) {
            switch context.biometryType {
            case .none:
                return .none
            case .touchID:
                return .touchID
            case .faceID:
                return .faceID
            }
        } else {
            return  context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) ? .touchID : .none
        }
}
}
