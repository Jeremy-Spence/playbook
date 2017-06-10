//
//  AddAuthorOnboardingViewController.swift
//  Playbook
//
//  Created by Jeremy Spence on 5/11/17.
//  Copyright © 2017 Jeremy Spence. All rights reserved.
//

import UIKit
import Firebase

class AddAuthorOnboardingViewController: UIViewController {
    
    @IBOutlet weak var omainTableView: UITableView!
    @IBOutlet weak var instructions: UILabel!
    @IBOutlet weak var popularLabel: UILabel!
    @IBOutlet weak var oselectedCollectionView: UICollectionView!
    @IBOutlet weak var osearchBar: UISearchBar!
    @IBOutlet weak var continueButton: UIButton!
    
    var authorNames: [String] = []
    var filteredAuthors: [String] = []
    
    var isSearching = false
    let user = User.sharedInstance
    let persistenceManager = PersistenceManager()
    let analyticsManager = AnalyticsManager()
    
    var followedAuthors: [String] = [] {
        didSet {
            if followedAuthors.count < 3 {
                continueButton.setTitleColor(UIColor.lightGray, for: .normal)
            } else {
                continueButton.setTitleColor(UIColor.black, for: .normal)
            }
        }
    }
    
    func getAuthorNames() {
        var names: [String] = []
        for author in authors {
            names.append(author.name)
        }
        authorNames = names
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAuthorNames()
        
        self.hideKeyboardWhenTappedAround()
        
        osearchBar.delegate = self
        osearchBar.returnKeyType = .done
        
        omainTableView.separatorStyle = .none
        omainTableView.allowsSelection = false
    }
    
    
    @IBAction func addAuthorAction(_ sender: Any) {
        let button = sender as! UIButton
        let cell = button.superview!
        
        let cellLabelTag: CellTag = .tvAddAuthorOnboardingLabel
        let cellLabel = cell.viewWithTag(cellLabelTag.rawValue) as! UILabel
        
        let selectedAuthor = cellLabel.text!
        
        let wasSelected = followedAuthors.contains(selectedAuthor)
        
        if wasSelected {
            followedAuthors.remove(at: followedAuthors.index(of: selectedAuthor)!)
        } else {
            followedAuthors.append(selectedAuthor   )
        }
        
        omainTableView.reloadData()
        oselectedCollectionView.reloadData()
    }
    
    func highlightInstructions() {
        instructions.textColor = UIColor.red
        instructions.font = UIFont.boldSystemFont(ofSize: 13.0)
    }
    
    @IBAction func doneButton(_ sender: Any) {
        if self.followedAuthors.count < 3 {
            highlightInstructions()
        } else {
            user.followedAuthors = self.followedAuthors
            persistenceManager.saveUser()
            self.performSegue(withIdentifier: "signUpOnboarding", sender: nil)
        }
    }
}

extension AddAuthorOnboardingViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching { return filteredAuthors.count }
        return authors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recommendedCell", for: indexPath)
        
        let cellLabelTag: CellTag = .tvAddAuthorOnboardingLabel
        let cellPicTag: CellTag = .tvAddAuthorOnboardingImage
        let cellButtonTag: CellTag = .tvAddAuthorOnboardingButton
        let cellDescriptionTag: CellTag = .tvAddAuthorOnboardingDescription
        
        let cellLabel = cellLabelTag.tvGetView(cell: cell) as! UILabel
        let cellPic = cellPicTag.tvGetView(cell: cell) as! UIImageView
        let cellButton = cellButtonTag.tvGetView(cell: cell) as! UIButton
        let cellDescription = cellDescriptionTag.tvGetView(cell: cell) as! UILabel
        
        round(image: cellPic)
        
        var currentAuthor: String = ""
        
        if isSearching {
            currentAuthor = filteredAuthors[indexPath.row]
        } else {
            currentAuthor = authors[indexPath.row].name
        }
        
        for author in authors {
            if author.name == currentAuthor {
                cellPic.image = author.picture
                cellDescription.text = author.description
            }
        }
        
        cellLabel.text = currentAuthor
        
        let isSelected = followedAuthors.contains(currentAuthor)
        setButtonState(on: isSelected, button: cellButton)
        
        return cell
    }
    
    func setButtonState(on: Bool, button: UIButton) {
        if on {
            button.setBackgroundImage(#imageLiteral(resourceName: "Delete Suggest"), for: .normal)
        } else {
            button.setBackgroundImage(#imageLiteral(resourceName: "ADD"), for: .normal)
        }
    }
    
}

extension AddAuthorOnboardingViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return followedAuthors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "selectedCell", for: indexPath)
        
        let cellLabelTag: CellTag = .cvAddAuthorOnboardingLabel
        let cellViewTag: CellTag = .cvAddAuthorOnboardingView
        let cellPicTag: CellTag = .cvAddAuthorOnboardingPic
        
        let cellLabel = cellLabelTag.cvGetView(cell: cell) as! UILabel
        let cellView = cellViewTag.cvGetView(cell: cell)
        let cellPic = cellPicTag.cvGetView(cell: cell) as! UIImageView
        
        round(view: cellView)
        round(image: cellPic)
        
        let currentAuthor = followedAuthors[indexPath.row]
        cellLabel.text = currentAuthor
        
        for author in authors {
            if author.name == currentAuthor {
                cellPic.image = author.picture
            }
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)!
        
        let cellLabelTag: CellTag = .cvAddAuthorOnboardingLabel
        let cellLabel = cellLabelTag.cvGetView(cell: cell) as! UILabel
        
        let selectedAuthor = cellLabel.text
        
        followedAuthors.remove(at: followedAuthors.index(of: selectedAuthor!)!)
        
        oselectedCollectionView.reloadData()
        omainTableView.reloadData()
    }
    
}

extension AddAuthorOnboardingViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        self.osearchBar.endEditing(true)
    }
    
    func resetSearching() {
        popularLabel.text = "Authors"
        isSearching = false
        view.endEditing(true)
        filteredAuthors = []
        omainTableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            resetSearching()
        } else {
            isSearching = true
            popularLabel.text = "Results for: " + searchBar.text!
            
            for author in authorNames {
                if author.lowercased().hasPrefix(searchBar.text!.lowercased()) {
                    let isAuthorInArr = filteredAuthors.contains(author)
                    if !isAuthorInArr {
                        filteredAuthors.append(author)
                    }
                } else {
                    let isAuthorInArr = filteredAuthors.contains(author)
                    if isAuthorInArr {
                        filteredAuthors.remove(at: filteredAuthors.index(of: author)!)
                    }
                }
            }
            
            omainTableView.reloadData()
        }
    }
    
}











