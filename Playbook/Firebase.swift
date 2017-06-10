//
//  Firebase.swift
//  Playbook
//
//  Created by Jeremy Spence on 6/3/17.
//  Copyright © 2017 Jeremy Spence. All rights reserved.
//

import Foundation
import Firebase

class FirebaseManager {
    
    let api = API.sharedInstance
    var ref: DatabaseReference! = Database.database().reference()

    func saveEmail(email: String) {
        let formattedEmail = email.replacingOccurrences(of: ".", with: "(dot)")
        ref.child("emails").child(formattedEmail).setValue("1")
    }
    
    func saveJSONPosts() {
        
        let allAuthors = api.allAuthors
        
        for author in allAuthors {
            
            let posts = api.getPostsFrom(author: author)
            
            for post in posts {
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                let dateString = dateFormatter.string(from:post.date)
                let date = dateString
                
                let postDict: [String: String] = [
                    "author": post.author,
                    "tags": post.tags.joined(separator: "&"),
                    "format": post.format,
                    "url": post.url,
                    "date": date
                ]
                
                let finalTitle = removeIllegalCharacters(for: post.title)
                let finalAuthor = removeIllegalCharacters(for: author)
                
                ref.child("posts").child(finalAuthor).child(finalTitle).setValue(postDict)
            }
        }
    }
    
    func removeIllegalCharacters(for string: String) -> String {
        let period = string.replacingOccurrences(of: ".", with: "+(dot)+")
        let hashtag = period.replacingOccurrences(of: "#", with: "+(hashtag)+")
        let dollar = hashtag.replacingOccurrences(of: "$", with: "+(dollar)+")
        let lBracket = dollar.replacingOccurrences(of: "[", with: "+(l-bracket)+")
        let rBracket = lBracket.replacingOccurrences(of: "]", with: "+(r-bracket)+")
        let singleQuote = rBracket.replacingOccurrences(of: "\'", with: "+(single-quote)+")
        let quote = singleQuote.replacingOccurrences(of: "\"", with: "+(quote)+")
        return quote.replacingOccurrences(of: "\\", with: "+(backslash)+")
    }
    
    func addIllegalCharacters(for string: String) -> String {
        let period = string.replacingOccurrences(of: "+(dot)+", with: ".")
        let hashtag = period.replacingOccurrences(of: "+(hashtag)+", with: "#")
        let dollar = hashtag.replacingOccurrences(of: "+(dollar)+", with: "$")
        let lBracket = dollar.replacingOccurrences(of: "+(l-bracket)+", with: "[")
        let rBracket = lBracket.replacingOccurrences(of: "+(r-bracket)+", with: "]")
        let singleQuote = rBracket.replacingOccurrences(of: "+(single-quote)+", with: "\'")
        let quote = singleQuote.replacingOccurrences(of: "+(quote)+", with: "\"")
        return quote.replacingOccurrences(of: "+(backslash)+", with: "\\")
    }
    
//    func loadFirebasePosts(author: String) -> (authors: [String], posts: [Post]) {
//        var loadedPosts: [Post] = []
//        var loadedAuthors: [String] = []
//        
//        ref.child("posts").observe(.value, with: { (snapshot) in
//            let dict = snapshot.value as? [String : AnyObject] ?? [:]
//            
//            for (key,val) in dict {
//                if key == author {
//
//                    var post: Post = Post()
//                    post.author = self.addIllegalCharacters(for: key)
//                    loadedAuthors.append(post.author)
//                    
//                    let posts: [String : AnyObject] = val as! [String: AnyObject]
//                    
//                    for firebasePost in posts {
//                        post.title = self.addIllegalCharacters(for: firebasePost.key)
//                        
//                        print(post.title + " by " + post.author)
//                        
//                        let postInfo = firebasePost.value as! [String: String]
//                        
//                        post.format = postInfo["format"]!
//                        let tags = postInfo["tags"]!
//                        let splitTags: [String] = tags.components(separatedBy: "&")
//                        post.tags = splitTags
//                        post.url = postInfo["url"]!
//                        let dateString = postInfo["date"]!
//                        
//                        let dateFormatter = DateFormatter()
//                        dateFormatter.dateStyle = .medium
//                        post.date = dateFormatter.date(from: dateString)!
//                        
//                        loadedPosts.append(post)
//                    }
//                }
//                
//            }
//        })
//        
//        
//        for post in loadedPosts {
//            if !loadedAuthors.contains(post.author) {
//                loadedAuthors.append(post.author)
//            }
//        }
//        
//        return (authors: loadedAuthors, posts: loadedPosts)
//    }
    
    
    
    //    private func loadPosts() -> [Post] {
    //    }

}




