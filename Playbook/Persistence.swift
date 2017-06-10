//
//  Persistency.swift
//  Playbook
//
//  Created by Jeremy Spence on 6/3/17.
//  Copyright © 2017 Jeremy Spence. All rights reserved.
//

import Foundation

class PersistenceManager {
    
    //MARK: - Private Helper Variables
    
    private let user = User.sharedInstance
    private let defaults = UserDefaults.standard
    
    //MARK: - Private Helper Methods
    
    private func archiveUser(user: User) -> Data {
        return NSKeyedArchiver.archivedData(withRootObject: user)
    }
    
    private func unarchiveUser(data: Data) -> User {
        return NSKeyedUnarchiver.unarchiveObject(with: data) as! User
    }
    
    //MARK: - Persistency Methods
    
    func loadUser() {
        guard let data = defaults.data(forKey: "user") else { return }
        
        let storedUser = unarchiveUser(data: data)
            user.didSeeOnboarding = storedUser.didSeeOnboarding
            user.email = storedUser.email
            user.followedAuthors = storedUser.followedAuthors
            user.password = storedUser.password
    }
    
    func saveUser() {
        let data = archiveUser(user: user)
        defaults.set(data, forKey: "user")
        
        defaults.synchronize()
    }
    
    func saveEmail(email: String) {
        FirebaseManager().saveEmail(email: email)
    }
    
}








