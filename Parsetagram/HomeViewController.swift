//
//  HomeViewController.swift
//  Parsetagram
//
//  Created by Avinash Singh on 07/12/17.
//  Copyright © 2017 Avinash Singh. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var posts : [PFObject]?
    
    @IBOutlet weak var photosTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        photosTableView.delegate = self
        photosTableView.dataSource = self
        photosTableView.rowHeight = UITableViewAutomaticDimension
        photosTableView.estimatedRowHeight = 100
        
         let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        photosTableView.insertSubview(refreshControl, at: 0)
            
        makeNetworkRequest()
        // Do any additional setup after loading the view.
    }
    
    
    func makeNetworkRequest(){
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let posts = posts {
                self.posts = posts
                self.photosTableView.reloadData()
//                print(self.posts)
                
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        
        makeNetworkRequest()
        refreshControl.endRefreshing()
        // Do any additional setup after loading the view.
     
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let posts = posts {
            return posts.count
        } else {
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotosTableViewCell
        if posts != nil{
        let post = posts![indexPath.row]
        
        
            
        cell.post = post
//            print("caption labels")
        print(cell.captionLabel)
        }
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let posts = posts {
                self.posts = posts
                self.photosTableView.reloadData()
//                print(self.posts)
            } else {
                print(error!.localizedDescription)
            }
        }
        //self.photosTableView.reloadData()

    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
