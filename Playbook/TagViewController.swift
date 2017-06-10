//
//  TagViewController.swift
//  Playbook
//
//  Created by Jeremy Spence on 5/11/17.
//  Copyright © 2017 Jeremy Spence. All rights reserved.
//

import UIKit

class TagViewController: UIViewController {
    
    //MARK: - Tag Outlets
    
    @IBOutlet weak var tag1: UIButton!
    @IBOutlet weak var tag2: UIButton!
    @IBOutlet weak var tag3: UIButton!
    @IBOutlet weak var tag4: UIButton!
    @IBOutlet weak var tag5: UIButton!
    @IBOutlet weak var tag6: UIButton!
    @IBOutlet weak var tag7: UIButton!
    @IBOutlet weak var tag8: UIButton!
    @IBOutlet weak var tag9: UIButton!
    @IBOutlet weak var tag10: UIButton!
    @IBOutlet weak var tag11: UIButton!
    @IBOutlet weak var tag12: UIButton!
    @IBOutlet weak var tag13: UIButton!
    @IBOutlet weak var tag14: UIButton!
    @IBOutlet weak var tag15: UIButton!
    @IBOutlet weak var tag16: UIButton!
    @IBOutlet weak var tag17: UIButton!
    @IBOutlet weak var tag18: UIButton!
    @IBOutlet weak var tag19: UIButton!
    @IBOutlet weak var tag20: UIButton!
    @IBOutlet weak var tag21: UIButton!
    @IBOutlet weak var tag22: UIButton!
    @IBOutlet weak var tag23: UIButton!
    @IBOutlet weak var tag24: UIButton!
    
    //MARK: - Stored Variables
    
    var authors: [String] = []
    var tagArr: [UIButton] = []
    var selectedTags: [String] = []
    var usableTags: [String] = []
    var availableTags: [String: Int] = [:]
    
    //MARK: - Setup Tags
    
    func setupTagData(activeTags: [String], tagDict: [String: Int]) {
        selectedTags = activeTags
        availableTags = tagDict
        populateTagData()
    }
    
    func populateTagData() {
        let sortedTags: [String: Int] = flatMapToDict(flatMap: availableTags.flatMap({$0}).sorted { $0.0.1 > $0.1.1 })
        let sortedKeys: [String] = Array(sortedTags.keys)
        
        if sortedTags.count < 25 {
            usableTags = sortedKeys
        } else {
            usableTags = Array(sortedKeys[0...23])
        }
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // will run after setup tags
        
        tagArr = [
            tag1,
            tag2,
            tag3,
            tag4,
            tag5,
            tag6,
            tag7,
            tag8,
            tag9,
            tag10,
            tag11,
            tag12,
            tag13,
            tag14,
            tag15,
            tag16,
            tag17,
            tag18,
            tag19,
            tag20,
            tag21,
            tag22,
            tag23,
            tag24
        ]
        
        setupTagButtons()
    }
    
    func setupTagButtons() {
        for tag in tagArr {
            tag.layer.cornerRadius = 5
            tag.clipsToBounds = true
        }
        
        for tag in usableTags {
            let k = usableTags.index(of: tag)!
            tagArr[k].setTitle(tag, for: .normal)
            tagArr[k].backgroundColor = tagColors[tag]
        }
        
        setActiveTags()
        addActions()
    }
    
    func setActiveTags() {
        for tag in selectedTags {
            for buttonTag in tagArr {
                if tag == buttonTag.titleLabel!.text! {
                    setTag(active: true, tag: buttonTag)
                }
            }
        }
        hideEmptyTags()
    }
    
    func addActions() {
        for tag in self.tagArr {
            tag.addTarget(self, action: #selector(configureButtons(sender:)), for: .touchUpInside)
        }
    }
    
    func configureButtons(sender: UIButton) {
        let selectedButton = sender.titleLabel!.text!
        
        if selectedTags.contains(selectedButton) {
            selectedTags.remove(at: selectedTags.index(of: selectedButton)!)
            setTag(active: false, tag: sender)
        } else {
            selectedTags.append(selectedButton)
            setTag(active: true, tag: sender)
        }
    }
    
    func setTag(active: Bool, tag: UIButton) {
        if active {
            tag.layer.borderWidth = 2
            tag.layer.borderColor = UIColor.black.cgColor
        } else {
            tag.layer.borderWidth = 0
        }
    }
    
    func hideEmptyTags() {
        for tag in tagArr {
            if tag.titleLabel?.text == "Tag" {
                tag.isHidden = true
            }
        }
    }
    
    func flatMapToDict(flatMap: [(String, Int)]) -> [String: Int] {
        // helper method to convery flat map (array of tuples) to dictionary
        
        var dict: [String: Int] = [:]
        for element in flatMap {
            dict[element.0] = element.1
        }
        return dict
    }
    
}

