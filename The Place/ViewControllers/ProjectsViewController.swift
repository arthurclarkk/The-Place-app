//
//  ProjectsViewController.swift
//  The Place
//
//  Created by Arthur Daniyarov on 17.02.2020.
//  Copyright © 2020 Arthur Daniyarov. All rights reserved.
//

import UIKit

class ProjectsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {
    
    
    let idCell = "pCell"
    
    var model = ProjectModel()
    
    var refreshControl = UIRefreshControl()
    
    var search = UISearchController()
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "ProjectsTableViewCell", bundle: nil), forCellReuseIdentifier: idCell)
        
        search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        self.navigationItem.searchController = search
        
        refreshControl.attributedTitle = NSAttributedString(string: "Update")
        refreshControl.tintColor = #colorLiteral(red: 0.337254902, green: 0.3647058824, blue: 0.2784313725, alpha: 1)
        refreshControl.addTarget(self, action: #selector(updateTable), for: .valueChanged)
        tableView.refreshControl = refreshControl

        // Do any additional setup after loading the view.
    }
    
    @objc func updateTable() {
        
        print("UPDATE")
        refreshControl.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearch() {
            return model.modelsFiltered.count
        }
        return model.models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: idCell) as! ProjectsTableViewCell
        
        var message: Model
        
        if isSearch() {
            message = model.modelsFiltered[indexPath.row]
        }else {
            message = model.models[indexPath.row]
        }
        
        cell.titleLabel.text = message.title
        cell.detailsLabel.text = message.text
        cell.statusLabel.text = message.status
        cell.hashtagLabel.text = message.hashtag
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 160
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let swipeRead = UIContextualAction(style: .normal, title: "Edit") { (action, view, success) in
            
            print("no need swipe")
        }
        
        swipeRead.image = #imageLiteral(resourceName: "cardIcon")
        swipeRead.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.8549019608, blue: 0.6431372549, alpha: 1)
        return UISwipeActionsConfiguration(actions: [swipeRead])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let swipeMore = UIContextualAction(style: .normal, title: "More") { (action, view, success) in
            
            print("More")
        }
        
        swipeMore.backgroundColor = #colorLiteral(red: 0.2609139681, green: 0.4145109355, blue: 0.6149280071, alpha: 1)
        swipeMore.image = #imageLiteral(resourceName: "notes")
        
        let swipeArch = UIContextualAction(style: .normal, title: "Archive") { (action, view, success) in
            
            print("Archive")
        }
        
        swipeArch.backgroundColor = #colorLiteral(red: 0.6352941176, green: 0.3333333333, blue: 0.2274509804, alpha: 1)
        swipeArch.image = #imageLiteral(resourceName: "cardIcon")
        
        let swipeDelete = UIContextualAction(style: .normal, title: "Delete") { (action, view, success) in
            
            self.tableView.performBatchUpdates({
                self.model.removeTask(indexPath: indexPath)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                success(true)
            }, completion: nil)
        }
        
        swipeDelete.backgroundColor = #colorLiteral(red: 0.8196078431, green: 0.231372549, blue: 0.2509803922, alpha: 1)
        swipeDelete.image = #imageLiteral(resourceName: "cardIcon")
        
        return UISwipeActionsConfiguration(actions: [swipeDelete, swipeArch, swipeMore])
    }
    
    func searchBarIsEmpty() -> Bool {
        
        return search.searchBar.text?.isEmpty ?? true
    }
    
    func isSearch() -> Bool {
    
        return search.isActive && !searchBarIsEmpty()
    }
    
    func filterSearchMessage(text: String) {
           
           model.filterModels(text: text)
           tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        filterSearchMessage(text: searchController.searchBar.text!)
    }
    
}




