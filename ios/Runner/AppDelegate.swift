import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        if let parameters = appRemote.authorizationParameters(from: url) {
            let access_token = parameters[SPTAppRemoteAccessTokenKey]
            appRemote.connectionParameters.accessToken = access_token
            sessionManager.application(app, open: url, options: options)
        } 
        return true
    }
}
