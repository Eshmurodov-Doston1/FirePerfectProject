//
//  FirePerfectProjectApp.swift
//  FirePerfectProject
//
//  Created by macbro on 16/05/22.
//

import SwiftUI
import Firebase
@main
struct FirePerfectProjectApp: App {
    let persistenceController = PersistenceController.shared
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            StartScreen()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(SessionStore())
        }
    }
}

class AppDelegate: NSObject,UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
