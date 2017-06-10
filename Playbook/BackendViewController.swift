//
//  BackendViewController.swift
//  Playbook
//
//  Created by Jeremy Spence on 6/7/17.
//  Copyright © 2017 Jeremy Spence. All rights reserved.
//

import UIKit
import Firebase

class BackendViewController: UIViewController {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var authorField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var formatField: UITextField!
    @IBOutlet weak var tagField: UITextField!
    @IBOutlet weak var urlField: UITextField!
    
    let ref = Database.database().reference(withPath: "--all-posts")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func submit(_ sender: Any) {
        
        if let title = titleField.text {
            if let author = authorField.text {
                if let date = dateField.text {
                    if let format = formatField.text {
                        if let tags = tagField.text {
                            if let url = urlField.text {
                                
                                let data = [
                                    "url": url,
                                    "tags": tags,
                                    "format": format,
                                    "date": date,
                                    "author": author
                                ]
                                
                                let safeTitle = self.removeIllegalCharacters(for: title)
                                let titleRef = ref.child(safeTitle)
                                titleRef.setValue(data)
                                
                            }
                        }
                    }
                }
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


}
