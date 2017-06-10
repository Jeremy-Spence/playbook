//
//  User.swift
//  Playbook
//
//  Created by Jeremy Spence on 5/27/17.
//  Copyright © 2017 Jeremy Spence. All rights reserved.
//

import Foundation

class User: NSObject, NSCoding {
    
    //MARK: - Class Variables
    
    var email: String = ""
    var password: String = ""
    var followedAuthors: [String] = []
    var didSeeOnboarding: Bool = false
    
    
    //MARK: - Class Inits
    
    static let sharedInstance = User()
    
    override init() { super.init() }
    
    
    //MARK: - Coding Methods
    
    required init?(coder aDecoder: NSCoder) {
        self.email = aDecoder.decodeObject(forKey: "email") as! String
        self.password = aDecoder.decodeObject(forKey: "password") as! String
        self.followedAuthors = aDecoder.decodeObject(forKey: "followedAuthors") as! [String]
        self.didSeeOnboarding = aDecoder.decodeBool(forKey: "didSeeOnboarding")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.email, forKey: "email")
        aCoder.encode(self.password, forKey: "password")
        aCoder.encode(self.followedAuthors, forKey: "followedAuthors")
        aCoder.encode(self.didSeeOnboarding, forKey: "didSeeOnboarding")
    }
    

}






