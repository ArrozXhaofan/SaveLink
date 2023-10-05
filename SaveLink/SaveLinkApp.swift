//
//  SaveLinkApp.swift
//  SaveLink
//
//  Created by Jean L2 on 22/08/23.
//

import SwiftUI
import Firebase
import FacebookLogin

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                       didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        FirebaseApp.configure()
        return true
      }
}


@main
struct SaveLinkApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authenticationViewModel = AuthenticationViewModel()
    
    var body: some Scene {
        WindowGroup {
            
            if authenticationViewModel.user != nil {
                HomeView(authenticationViewModel: authenticationViewModel)
            }else {
                AuthenticationView(autenticationViewModel: authenticationViewModel)
            }
            
            
        }
    }
}
