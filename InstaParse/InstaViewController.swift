//
//  InstaViewController.swift
//  InstaParse
//
//  Created by Kwaku Owusu on 3/10/16.
//  Copyright © 2016 Kwaku Owusu. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import MBProgressHUD
class InstaViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var posts:[PFObject]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120

        loadData()
        }

    func loadData(){
        let query = PFQuery(className: "Post")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        let loadingNotification = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.Indeterminate
        loadingNotification.labelText = "Fetching Posts!"
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            if let posts = posts {
                
                // do something with the data fetched
                self.posts = posts
                self.tableView.reloadData()
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)

            } else {
                print(error?.localizedDescription)
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)

            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        loadData()
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("instaCell", forIndexPath: indexPath) as! InstaCell
        cell.selectionStyle = .None
        
        
        cell.getPosts = posts[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if posts != nil{
            return  posts.count
        } else {
            return 0
        }
    }

 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
