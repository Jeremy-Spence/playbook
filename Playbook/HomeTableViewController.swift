//
//  HomeTableViewController.swift
//  Playbook
//
//  Created by Jeremy Spence on 5/7/17.
//  Copyright © 2017 Jeremy Spence. All rights reserved.
//

import UIKit
import SafariServices
import SimpleAlert
import Firebase

class HomeTableViewController: UITableViewController, SFSafariViewControllerDelegate, AddAuthorViewControllerDelegate {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var authorCollectionView: UICollectionView!
    @IBOutlet weak var filterIcon: UIBarButtonItem!
    
    //MARK: - Stored Variables
    
    let user = User.sharedInstance
    let tagHelper = TagHelper()
    let persistenceManager = PersistenceManager()
    let analyticsManager = AnalyticsManager()
    let api = API.sharedInstance
    let ref = Database.database().reference(withPath: "--all-posts")
    
    var followedAuthors: [String] = []
    var allPosts: [Post] = []
    var selectedAuthor = "All"
    var activeTags: [String] = []
    
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
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //api.loadFirebasePosts(for: user.followedAuthors)
        
        /*
        for post in api.JSONPosts {
            let title = removeIllegalCharacters(for: post.title)
            
            let titleRef = ref.child(title)
            
            titleRef.setValue(post.postInfoToAnyObject())
        }*/
        
        self.tableView.separatorStyle = .none
 
        DispatchQueue.main.async {
            self.ref.observe(.value, with: { snapshot in
                var posts: [Post] = []
                
                for child in snapshot.children {
                    let childSnapshot = child as! DataSnapshot
                    
                    if self.isSnapshotFollowed(snapshot: childSnapshot) {
                        let post = Post(snapshot: childSnapshot)
                        posts.append(post)
                    }
                    
                }
                
                self.api.allPosts = posts
                self.populatePosts()
            })
        }
        
    }
    
    func isSnapshotFollowed(snapshot: DataSnapshot) -> Bool {
        let snapshotValue = snapshot.value as! [String: String]
        let author = snapshotValue["author"]!
        return user.followedAuthors.contains(author)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if activeTags.count == 0 {
            setFilterButton(on: false)
        }
    }
    
    //MARK: - Update Post Methods
    
    func populatePosts() {
        followedAuthors = getAuthorsWithActiveTags(authors: user.followedAuthors)
        allPosts = []
        allPosts = api.getPostsFrom(author: selectedAuthor)
        
        filterPosts()
    }
    
    func getAuthorsWithActiveTags(authors: [String]) -> [String] {
        if activeTags.count == 0 {
            return authors
        } else {
            var filteredAuthors: [String] = []
            for author in authors {
                for tag in tagHelper.getTagsFrom(author: author) {
                    for activeTag in activeTags {
                        if tag == activeTag {
                            if !filteredAuthors.contains(author) {
                                filteredAuthors.append(author)
                            }
                        }
                    }
                }
            }
            return filteredAuthors
        }
    }
    
    func filterPosts() {
        if activeTags.count > 0 {
            allPosts = filterPostsWith(tags: activeTags, posts: allPosts)
        }
        self.authorCollectionView.reloadData()
        self.tableView.reloadData()
    }
    
    // get all posts that have a specific tag
    func filterPostsWith(tags: [String], posts: [Post]) -> [Post] {
        var filteredPosts: [Post] = []
        
        for post in posts {
            for tag in tags {
                if post.tags.contains(tag) {
                    if !filteredPosts.contains(post) {
                        filteredPosts.append(post)
                    }
                    
                }
            }
        }
        
        return filteredPosts
    }
    
    //MARK: - Filter Methods
    
    @IBAction func filter(_ sender: Any) {
        
        let authorDupTags = tagHelper.getDupTagsFrom(author: selectedAuthor)
        let tagDict = dupArrToDict(array: authorDupTags)
        
        let vc = TagViewController()
        vc.setupTagData(activeTags: activeTags, tagDict: tagDict)
        
        let alert = AlertController(view: vc.view, style: .actionSheet)
        
        alert.addAction(AlertAction(title: "Reset", style: .destructive) { action in
            self.activeTags = []
            self.populatePosts()
            
            self.setFilterButton(on: false)
        })
        
        alert.addAction(AlertAction(title: "Done", style: .cancel) { action in
            self.activeTags = vc.selectedTags
            self.populatePosts()
            
            if self.activeTags.count > 0 {
                self.analyticsManager.logChoseTagsEvent()
                self.setFilterButton(on: true)
            } else {
                self.setFilterButton(on: false)
            }
        })
        
        self.navigationController!.present(alert, animated: true, completion: nil)
    }
    
    func dupArrToDict(array: [String]) -> [String: Int] {
        // convert array with duplicates into single dict with duplicate counts
        var dict: [String: Int] = [:]
        
        for item in array {
            if dict.keys.contains(item) {
                dict[item] = dict[item]! + 1
            } else {
                dict[item] = 1
            }
        }
        
        return dict
    }
    
    func setFilterButton(on: Bool) {
        let button = UIButton.init(type: .custom)
        
        if !on {
            button.setImage(#imageLiteral(resourceName: "filterOn"), for: UIControlState.normal)
        } else {
            button.setImage(#imageLiteral(resourceName: "filterOff"), for: UIControlState.normal)
        }
        
        button.addTarget(self, action: #selector(self.filter), for: UIControlEvents.touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        self.filterIcon.customView = button
    }
    
    // MARK: - Table View Data Source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPosts.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.selectionStyle = .none
        
        let chronologicalPosts: [Post] = allPosts.sorted().reversed()
        let post = chronologicalPosts[indexPath.row]
        
        let cellTitleTag: CellTag = .tvHomeTitle
        let cellPicTag: CellTag = .tvHomePic
        let cellAuthorTag: CellTag = .tvHomeAuthor
        let cellDateTag: CellTag = .tvHomeDate
        let cellTag1Tag: CellTag = .tvHomeTag1
        let cellTag2Tag: CellTag = .tvHomeTag2
        let cellTag3Tag: CellTag = .tvHomeTag3
        
        let cellTitle = cellTitleTag.tvGetView(cell: cell) as! UILabel
        let cellPic = cellPicTag.tvGetView(cell: cell) as! UIImageView
        let cellAuthor = cellAuthorTag.tvGetView(cell: cell) as! UILabel
        let cellDate = cellDateTag.tvGetView(cell: cell) as! UILabel
        let cellTag1 = cellTag1Tag.tvGetView(cell: cell) as! UILabel
        let cellTag2 = cellTag2Tag.tvGetView(cell: cell) as! UILabel
        let cellTag3 = cellTag3Tag.tvGetView(cell: cell) as! UILabel
        
        let tagViewArr = [cellTag1, cellTag2, cellTag3]
        
        styleTags(tags: tagViewArr)
        stylePic(pic: cellPic)
        
        cellPic.image = getAuthorPicture(name: post.author)
        cellTitle.text = post.title
        cellAuthor.text = post.author
        cellTag1.text = post.format
        cellDate.text = formatDate(date: post.date)
        
        setupTags(tags: post.tags, tagViewArr: tagViewArr)
        
        return cell
    }
    
    
    
    //MARK: - Table View Delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        let cellLabelTag: CellTag = .tvHomeTitle
        let cellLabel = cellLabelTag.tvGetView(cell: cell) as! UILabel
        
        var postURL = ""
        for post in allPosts {
            if post.title == cellLabel.text {
                postURL = post.url
            }
        }
        
        let svc = SFSafariViewController(url: URL(string: postURL)!, entersReaderIfAvailable: true)
        svc.delegate = self
        
        analyticsManager.logReadPostEvent()
        
        self.present(svc, animated: true, completion: nil)
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController)  {
        controller.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - TableView Helper Methods
    
    func getAuthorPicture(name: String) -> UIImage {
        for author in authors {
            if author.name == name {
                return author.picture
            }
        }
        return UIImage()
    }
    
    func styleTags(tags: [UILabel]) {
        for tagView in tags {
            tagView.isHidden = false
            tagView.layer.cornerRadius = 5
            tagView.clipsToBounds = true
            tagView.text = ""
        }
    }
    
    func stylePic(pic: UIImageView) {
        pic.layer.cornerRadius = 22
        pic.clipsToBounds = true
        pic.layer.borderWidth = 1
        pic.layer.borderColor = UIColor.black.cgColor
    }
    
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    func setupTags(tags: [String], tagViewArr: [UILabel]) {
        var tagCount = 1
        for tag in tags {
            tagViewArr[tagCount].text = tag
            tagViewArr[tagCount].backgroundColor = tagColors[tag]
            tagCount += 1
        }
        
        for tag in tagViewArr {
            if tag.text == "" || tag.text == nil {
                tag.isHidden = true
            }
        }
    }

    
    //MARK: - Add Author Methods
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addAuthor" {
            let vc = segue.destination as! AddAuthorViewController
            vc.delegate = self
        }
    }
    
    func addItemViewController(_ controller: AddAuthorViewController, didFinishAdding authors: [String]) {
        user.followedAuthors = authors
        persistenceManager.saveUser()
        
        analyticsManager.logAddedAuthorEvent()
        reset()
        
        dismiss(animated: true, completion: nil)
    }
    
    func reset() {
        selectedAuthor = "All"
        activeTags = []
        setFilterButton(on: false)
        authorCollectionView.reloadData()
        
        DispatchQueue.main.async {
            self.ref.observe(.value, with: { snapshot in
                var posts: [Post] = []
                
                for child in snapshot.children {
                    let childSnapshot = child as! DataSnapshot
                    
                    if self.isSnapshotFollowed(snapshot: childSnapshot) {
                        let post = Post(snapshot: childSnapshot)
                        posts.append(post)
                    }
                    
                }
                
                self.api.allPosts = posts
                self.populatePosts()
            })
        }
    }

}

extension HomeTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: - Collection View Data Source
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return followedAuthors.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)
        
        let cellViewTag: CellTag = .cvHomeView
        let cellPicTag: CellTag = .cvHomePic
        let cellLabelTag: CellTag = .cvHomeLabel
        
        let cellView = cellViewTag.cvGetView(cell: cell)
        let cellPic = cellPicTag.cvGetView(cell: cell) as! UIImageView
        let cellLabel = cellLabelTag.cvGetView(cell: cell) as! UILabel

        round(view: cellView)
        round(image: cellPic)
        
        var author = ""
        
        if indexPath.row == 0 {
            author = "All"
            cellPic.isHidden = true
        } else {
            author = followedAuthors[indexPath.row-1]
            cellPic.isHidden = false
            cellPic.image = getAuthorPicture(name: author)
        }
        
        cellLabel.text = author
        
        setSelected(selected: (cellLabel.text == selectedAuthor), view: cellView)
        
        return cell
    }
    
    func setSelected(selected: Bool, view: UIView) {
        if selected {
            view.layer.borderWidth = 2
            view.layer.borderColor = UIColor.black.cgColor
        } else {
            view.layer.borderWidth = 0
        }
    }
    
    //MARK: - Collection View Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)!
        
        let cellLabelTag: CellTag = .cvHomeLabel
        let cellLabel = cellLabelTag.cvGetView(cell: cell) as! UILabel
        
        selectedAuthor = cellLabel.text!
        
        populatePosts()
        collectionView.reloadData()
    }
}


