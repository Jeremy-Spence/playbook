//
//  AddAuthorViewController.swift
//  Playbook
//
//  Created by Jeremy Spence on 5/9/17.
//  Copyright © 2017 Jeremy Spence. All rights reserved.
//

import UIKit

protocol AddAuthorViewControllerDelegate: class {
    func addItemViewController(_ controller: AddAuthorViewController, didFinishAdding authors: [String])
}

class AddAuthorViewController: UIViewController {
    
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var popularLabel: UILabel!
    @IBOutlet weak var selectedCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var backendButton: UIButton!
    
    var authorNames: [String] = []
    var filteredAuthors: [String] = []
    var followedAuthors: [String] = []
    var isSearching = false
    
    weak var delegate: AddAuthorViewControllerDelegate?
    
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
        
        if User.sharedInstance.email == "js7745@nyu.edu" || User.sharedInstance.email == "mrjc627@gmail.com" {
            backendButton.isHidden = false
        } else {
            backendButton.isHidden = true
        }
        
        self.hideKeyboardWhenTappedAround()
        
        followedAuthors = User.sharedInstance.followedAuthors
        
        searchBar.delegate = self
        searchBar.returnKeyType = .done
        
        mainTableView.separatorStyle = .none
        mainTableView.allowsSelection = false
    }
    
    @IBAction func addAuthorAction(_ sender: Any) {
        let button = sender as! UIButton
        let cell = button.superview!
        
        let cellLabelTag: CellTag = .tvAddAuthorLabel
        let cellLabel = cell.viewWithTag(cellLabelTag.rawValue) as! UILabel
        
        let selectedAuthor = cellLabel.text!
        
        let wasSelected = followedAuthors.contains(selectedAuthor)
        
        if wasSelected {
            if followedAuthors.count == 1 {
                lastAuthorAlert()
            } else {
                followedAuthors.remove(at: followedAuthors.index(of: selectedAuthor)!)
            }
        } else {
            followedAuthors.append(selectedAuthor)
        }
        
        mainTableView.reloadData()
        selectedCollectionView.reloadData()
    }
    
    func lastAuthorAlert() {
        let alert = UIAlertController(title: "This Is Your Last Author!",
                                      message: "You must be following one author at all times.",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default) { (self) in
            alert.dismiss(animated: true, completion: nil)
        })
    
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func done(_ sender: Any) {
        delegate?.addItemViewController(self, didFinishAdding: followedAuthors)
    }

}

extension AddAuthorViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching { return filteredAuthors.count }
        return authors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recommendedCell", for: indexPath)
        
        let cellLabelTag: CellTag = .tvAddAuthorLabel
        let cellPicTag: CellTag = .tvAddAuthorImage
        let cellButtonTag: CellTag = .tvAddAuthorButton
        let cellDescriptionTag: CellTag = .tvAddAuthorDescription
        
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

extension AddAuthorViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return followedAuthors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "selectedCell", for: indexPath)
        
        let cellLabelTag: CellTag = .cvAddAuthorLabel
        let cellViewTag: CellTag = .cvAddAuthorView
        let cellPicTag: CellTag = .cvAddAuthorPic
        
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
        
        let cellLabelTag: CellTag = .cvAddAuthorLabel
        let cellLabel = cellLabelTag.cvGetView(cell: cell) as! UILabel
        
        if followedAuthors.count == 1 {
            lastAuthorAlert()
        } else {
            let selectedAuthor = cellLabel.text
            
            followedAuthors.remove(at: followedAuthors.index(of: selectedAuthor!)!)
            
            selectedCollectionView.reloadData()
            mainTableView.reloadData()
        }
    }
}

extension AddAuthorViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        self.searchBar.endEditing(true)
    }
    
    func resetSearching() {
        popularLabel.text = "Authors"
        isSearching = false
        view.endEditing(true)
        filteredAuthors = []
        mainTableView.reloadData()
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
            
            mainTableView.reloadData()
        }
    }
    
}










