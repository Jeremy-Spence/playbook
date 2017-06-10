//
//  Analytics.swift
//  Playbook
//
//  Created by Jeremy Spence on 6/4/17.
//  Copyright © 2017 Jeremy Spence. All rights reserved.
//

import Foundation
import Firebase

class AnalyticsManager {
    
    func logAddedAuthorEvent() {
        Analytics.logEvent("addAuthor", parameters: nil)
    }
    
    func logReadPostEvent() {
        Analytics.logEvent("readPost", parameters: nil)
    }
    
    func logChoseTagsEvent() {
        Analytics.logEvent("choseTags", parameters: nil)
    }
}

























