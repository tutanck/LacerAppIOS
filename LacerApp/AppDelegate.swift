//
//  AppDelegate.swift
//  LacerApp
//
//  Created by Joan Angb on 14/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //Searchbars shared global style
        UISearchBar.appearance().barTintColor = UIColor(white: 0.99, alpha: 1)
        UISearchBar.appearance().tintColor = UIColor(red: 0, green: 137/255, blue: 249/255, alpha: 1)
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = UIColor(white: 0.99, alpha: 1)

        
        //MARK : - Firebasee config
        FirebaseApp.configure()
        
        
        let fakeEmail = "angb@lace.com"//"joan@lace.com"
        let fakePass = "angb12"//"Joan1234"
        
        Auth.auth().signIn(withEmail: fakeEmail,password: fakePass){ user, error in
            if error != nil {
                print("\n\n\n\n\n"+String(describing: error)+"\n\n\n\n")
            }
        }
        
        Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                self.window!.rootViewController = Gatekeeper.getGate()
                self.window!.makeKeyAndVisible()
            }
        }
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

