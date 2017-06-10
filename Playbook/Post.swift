//
//  Post.swift
//  Playbook
//
//  Created by Jeremy Spence on 6/3/17.
//  Copyright © 2017 Jeremy Spence. All rights reserved.
//

import Foundation
import Firebase

public struct Post {
    
    var title: String = ""
    var url: String = ""
    var tags: [String] = []
    var author: String = ""
    var format: String = ""
    var date: Date = Date()
    
    func removeIllegalCharacters(for string: String) -> String {
        let period = string.replacingOccurrences(of: ".", with: "+(dot)+")
        let hashtag = period.replacingOccurrences(of: "#", with: "+(hashtag)+")
        let dollar = hashtag.replacingOccurrences(of: "$", with: "+(dollar)+")
        let lBracket = dollar.replacingOccurrences(of: "[", with: "+(l-bracket)+")
        let rBracket = lBracket.replacingOccurrences(of: "]", with: "+(r-bracket)+")
        let singleQuote = rBracket.replacingOccurrences(of: "\'", with: "+(single-quote)+")
        let quote = singleQuote.replacingOccurrences(of: "\"", with: "+(quote)+")
        let backslash = quote.replacingOccurrences(of: "\\", with: "+(backslash)+")
        return backslash.replacingOccurrences(of: "/", with: "+(forwardslash)+")
    }
    
    func addIllegalCharacters(for string: String) -> String {
        let period = string.replacingOccurrences(of: "+(dot)+", with: ".")
        let hashtag = period.replacingOccurrences(of: "+(hashtag)+", with: "#")
        let dollar = hashtag.replacingOccurrences(of: "+(dollar)+", with: "$")
        let lBracket = dollar.replacingOccurrences(of: "+(l-bracket)+", with: "[")
        let rBracket = lBracket.replacingOccurrences(of: "+(r-bracket)+", with: "]")
        let singleQuote = rBracket.replacingOccurrences(of: "+(single-quote)+", with: "\'")
        let quote = singleQuote.replacingOccurrences(of: "+(quote)+", with: "\"")
        let backslash = quote.replacingOccurrences(of: "+(backslash)+", with: "\\")
        return backslash.replacingOccurrences(of: "+(forwardslash)+", with: "/")
    }

    
    init(snapshot: DataSnapshot) {
        let key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        
        self.title = addIllegalCharacters(for: key)
        self.url = snapshotValue["url"] as! String
        let tagStr = snapshotValue["tags"] as! String
        self.tags = tagStr.components(separatedBy: "&")
        self.author = snapshotValue["author"] as! String
        let dateStr = snapshotValue["date"] as! String
        self.date = stringToDate(string: dateStr)
        self.format = snapshotValue["format"] as! String
    }
    
    init() {
        
    }
    
    private func dateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
    
    private func stringToDate(string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.date(from: string)!
    }
    
    func postInfoToAnyObject() -> Any {
        return [
            "url": url,
            "tags": tags.joined(separator: "&"),
            "format": format,
            "date": dateToString(date: self.date),
            "author": author
        ]
    }
    
}

extension Post: Equatable {
    public static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.title == rhs.title
    }
}

extension Post: Comparable {
    public static func < (lhs: Post, rhs: Post) -> Bool {
        
        let lhsYear = Calendar.current.component(.year, from: lhs.date)
        let lhsMonth = Calendar.current.component(.month, from: lhs.date)
        let lhsDay = Calendar.current.component(.day, from: lhs.date)
        let rhsYear = Calendar.current.component(.year, from: rhs.date)
        let rhsMonth = Calendar.current.component(.month, from: rhs.date)
        let rhsDay = Calendar.current.component(.day, from: rhs.date)
        
        if lhsYear != rhsYear {
            return lhsYear < rhsYear
        } else if lhsMonth != rhsMonth {
            return lhsMonth < rhsMonth
        } else {
            return lhsDay < rhsDay
        }
    }
}
