//
//  Tag.swift
//  Playbook
//
//  Created by Jeremy Spence on 6/4/17.
//  Copyright © 2017 Jeremy Spence. All rights reserved.
//

import Foundation
import UIKit

public var tagColors: [String: UIColor] = [:]

class TagHelper {
    
    private var api = API.sharedInstance
    private var allPosts: [Post] = API.sharedInstance.allPosts

    func getDupTagsFrom(author: String) -> [String] {
        var dupTags: [String] = []
        var posts: [Post] = []
        
        posts = api.getPostsFrom(author: author)
        
        for post in posts {
            for tag in post.tags {
                dupTags.append(tag)
            }
        }
        
        return dupTags
    }
    
    
    // get all tags with no duplicates from an author
    func getTagsFrom(author: String) -> [String] {
        var allTags: [String] = []
        let postsFromAuthor: [Post] = api.getPostsFrom(author: author)
        
        for post in postsFromAuthor {
            for tag in post.tags {
                if !allTags.contains(tag) {
                    allTags.append(tag)
                }
            }
        }
        return allTags
    }
    
}
