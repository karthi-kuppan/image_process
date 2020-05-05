import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let batteryChannel = FlutterMethodChannel(name: "com.mine.opencv/image",
                                              binaryMessenger: controller.binaryMessenger)
    batteryChannel.setMethodCallHandler({
      [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
      // Note: this method is invoked on the UI thread.
      switch call.method {
        case "getOpenCVVersion":
            self?.getOpenCVVersion(result: result)
        case "convertToGray":
            let imagePath = call.arguments as! String
            self?.convertToGray(result: result, imagePath: imagePath)
        default:
        result(FlutterMethodNotImplemented)
      }
      
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

    private func getOpenCVVersion(result: FlutterResult) {
        result(OpenCVWrapper.openCVVersionString())
    }

    private func convertToGray(result: FlutterResult, imagePath: String) {
        let url = URL(fileURLWithPath: imagePath)

        let imageData:NSData = NSData(contentsOf: url)!

        let image = UIImage(data: imageData as Data)
        
        let grayImage = OpenCVWrapper.makeGray(from: image)
        let fixedGrayImage = grayImage!.fixedOrientation()
        
        if let data = fixedGrayImage!.pngData() {
            try? data.write(to: url)
        }
        
        result("Gray image saved to " + imagePath)
    }
}
