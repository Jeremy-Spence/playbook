//
//  AppDelegate.swift
//  Playbook
//
//  Created by Jeremy Spence on 5/7/17.
//  Copyright © 2017 Jeremy Spence. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    // Initialize firebase database
    override init() {
        FirebaseApp.configure()
        Database.database().isPersistenceEnabled = true
    }

    // Executes on application's first launch
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let persistenceManager = PersistenceManager()
        let _ = API.sharedInstance
        let user = User.sharedInstance
        
        persistenceManager.loadUser() // setup user shared instance
        //api.parseJSON() // load data from local json file
        
        // set root view controller
        var initialStoryboard = "Main"
        if !user.didSeeOnboarding { initialStoryboard = "Onboarding" }
        self.window?.rootViewController = UIStoryboard(name: initialStoryboard, bundle: nil).instantiateInitialViewController()
        
        return true
    }
    
    func didSeeOnboarding() -> Bool {
        return UserDefaults.standard.bool(forKey: "didSeeOnboarding")
    }
    
}












