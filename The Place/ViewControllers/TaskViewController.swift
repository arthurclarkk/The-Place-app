//
//  TaskViewController.swift
//  The Place
//
//  Created by Arthur Daniyarov on 06.02.2020.
//  Copyright © 2020 Arthur Daniyarov. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDataSource, UITableViewDelegate {
   
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    let folders = ["Сегодня","Важные","Входящие","Блокнот"]
    
    let folderIcons: [UIImage] = [
    
        UIImage(named: "today")!,
        UIImage(named: "major")!,
        UIImage(named: "inbox")!,
        UIImage(named: "notes")!,
    ]
    
    var names = [String]()
    
    let idCell = "Cell"
    
    var refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 8, left: 22, bottom: 0, right: 22)
        layout.itemSize = CGSize(width: self.collectionView.frame.size.width/2, height: self.collectionView.frame.size.height/2)
        
        collectionView.collectionViewLayout = layout
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Do any additional setup after loading the view.
        
        // To do list
        tableView.tableFooterView = UIView.init(frame: .zero)
        tableView.separatorColor = UIColor(white: 0.95, alpha: 1)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: idCell)
        
    }
    
    // Collection
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
       return CGSize(width: 180.0, height: 90.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return folders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        cell.folderLabel.text = folders[indexPath.item]
        cell.folderImage.image = folderIcons[indexPath.item]
        
        // Configure the cell
        cell.layer.cornerRadius = 12.0
        cell.layer.borderWidth = 0.0
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 0.5
        cell.layer.masksToBounds = false //<-
        
        return cell
    }
    
    // To Do list
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return names.count
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell") as! TaskTableViewCell
        
        if let cardLabel = cell.cardView.viewWithTag(101) as? UILabel {
            
            cardLabel.text = names[indexPath.row]
        }
       
        return cell
        
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
           
           let swipeDelete = UIContextualAction(style: .normal, title: "Delete") { (action, view, success) in
               
                self.tableView.performBatchUpdates({
                     self.names.removeTask(indexPath: indexPath)
                     self.tableView.deleteRows(at: [indexPath], with: .automatic)
                     success(true)
                }, completion: nil)
           }
           
           swipeDelete.backgroundColor = #colorLiteral(red: 0.8196078431, green: 0.231372549, blue: 0.2509803922, alpha: 1)
           swipeDelete.image = #imageLiteral(resourceName: "cardIcon")
           
           return UISwipeActionsConfiguration(actions: [swipeDelete, swipeMore])
       }
       
    @IBAction func addRowButton(_ sender: Any) {
        
        names.insert("Новый Список", at: 0)
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .top)
        self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
    
    
}
