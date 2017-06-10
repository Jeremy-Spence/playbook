//
//  API.swift
//  Playbook
//
//  Created by Jeremy Spence on 5/7/17.
//  Copyright © 2017 Jeremy Spence. All rights reserved.
//

import Foundation
import UIKit
import Firebase

public class API {
    
    static let sharedInstance = API()
    
    var allAuthors: [String] = []
    var allPosts: [Post] = [] {
        didSet {
            for post in allPosts {
                if !allAuthors.contains(post.author) {
                    allAuthors.append(post.author)
                }
            }
            self.setTagColors()
        }
    }
    var JSONPosts: [Post] = []
    var user = User.sharedInstance
    
    private init() {}
    
    
    func getDate(datetime: String) -> Date {
        let dashDate = datetime.characters.split(separator: "T").map(String.init)[0]
        let dateArr = dashDate.characters.split(separator: "-").map(String.init)
        var dateComponents = DateComponents()
        dateComponents.year = Int(dateArr[0])
        dateComponents.month = Int(dateArr[1])
        dateComponents.day = Int(dateArr[2])
        let userCalendar = Calendar.current // user calendar
        return userCalendar.date(from: dateComponents)!
    }
    
    func parseJSON() {
        
        guard let path = Bundle.main.path(forResource: "AllPosts", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            
            guard let array = json as? [Any] else { return }
            
            for post in array {
                guard let postDict = post as? [String: String] else { return }
                var post: Post = Post()
                post.author = postDict["author"]!
                post.title = postDict["name"]!
                post.format = postDict["format"]!
                
                post.tags.append(postDict["tag1"]!)
                if let tag2 = postDict["tag2"] {
                    if tag2 != postDict["tag1"]! {
                        post.tags.append(tag2)
                    }
                }
                post.url = postDict["url"]!
                post.date = getDate(datetime: postDict["date"]!)

                JSONPosts.append(post)
            }
        } catch { print(error) }
        
        for post in JSONPosts {
            if !allAuthors.contains(post.author) {
                allAuthors.append(post.author)
            }
        }
        
        for author in user.followedAuthors {
            for post in JSONPosts {
                if post.author == author {
                    allPosts.append(post)
                }
            }
        }
        
        //FirebaseManager().saveJSONPosts()
    }
    
//    func loadFirebasePosts(for authors: [String]) {
//        for author in authors {
//            let firebaseData = FirebaseManager().loadFirebasePosts(author: author)
//            
//            for firebaseAuthor in firebaseData.authors {
//                allAuthors.append(firebaseAuthor)
//            }
//            for firebasePost in firebaseData.posts {
//                allPosts.append(firebasePost)
//            }
//        }
//        
//        setTagColors()
//    }
    
    func setTagColors() {
        var tags: [String] = []
        
        for post in allPosts {
            for tag in post.tags {
                if !tags.contains(tag) {
                    tags.append(tag)
                }
            }
        }
        
        let green = UIColor(red: 112, green: 193, blue: 179)
        let blue = UIColor(red: 36, green: 123, blue: 160)
        let red = UIColor(red: 242, green: 95, blue: 92)
        let purple = UIColor(red: 142, green: 164, blue: 210)
        
        let colors = [green, blue, red, purple]
        
        let shuffledTags = tags.shuffled()
        
        var counter = 0 {
            didSet {
                if counter == 4 {
                    counter = 0
                }
            }
        }
        
        for tag in shuffledTags {
            tagColors[tag] = colors[counter]
            counter += 1
        }
    }
    
    
    // get posts from a specific author
    func getPostsFrom(author: String) -> [Post] {
        if author == "All" {
            return allPosts
        }
        
        var postsFromAuthor: [Post] = []
        
        for post in allPosts {
            if post.author == author {
                postsFromAuthor.append(post)
            }
        }
        
        return postsFromAuthor
    }

}









