//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by John Minimo on 2/15/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    
    var tweetArray = [NSDictionary]()
    
 //   var requestsArray = [NSDictionary]()
    
    var numberOfTweet: Int!
    
    let myRefreshControl = UIRefreshControl()
    
    
    @objc func pullTweets(){
        numberOfTweet = 25;
        let timelineURL:String = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myParams = ["count": numberOfTweet]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: timelineURL, parameters: myParams, success: { (tweets: [NSDictionary]) in
            
            self.tweetArray.removeAll()
            for tweet in tweets {
                self.tweetArray.append(tweet)
            }
            self.tableView.reloadData() // reload table view with content
           // self.checkRequestsLeft()
            self.myRefreshControl.endRefreshing() // stops circle thingy from spinning and stops refresh
            
        }, failure: { Error in
            print("Oops! Tweets could not be loaded.")
        })
        
        
    }
    
    
   /* func checkRequestsLeft(){
        let URL:String = "https://api.twitter.com/1.1/application/rate_limit_status.json"
        TwitterAPICaller.client?.getDictionariesRequest(url: URL, parameters: ["resources" : "users"], success: { (statuses:[NSDictionary]) in
            
            self.requestsArray.removeAll()// Clears entries
            
            for status in statuses {
                self.requestsArray.append(status)
            }
            
            
            
            
        }, failure: { Error in
            print("Couldn't retrieve requests")
        })
        
        print()
        
        
    } */
    
    func loadMoreTweets(){
        numberOfTweet = numberOfTweet + 25;
        pullTweets()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweetArray.count {
            loadMoreTweets()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pullTweets()
        myRefreshControl.addTarget(self, action: #selector(pullTweets), for: .valueChanged)
        
        tableView.refreshControl = myRefreshControl

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func userLogOut(_ sender: Any) {
        TwitterAPICaller.client?.logout() // Calls logout method
        UserDefaults.standard.set(false, forKey: "UserLoggedIn") // set to false if logged out
        self.dismiss(animated: true, completion: nil) // dismiss controller after logout
        
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetInTimelineCell", for: indexPath) as! TweetTableViewCell
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        var userName = user["screen_name"] as! String
        cell.screenNameUILabel.text = user["name"] as! String
        cell.userNameUILabel.text = "@\(userName)"
        cell.tweetContentLabel.numberOfLines = 0
        
        cell.tweetContentLabel.text = (tweetArray[indexPath.row]["text"] as! String)
        cell.tweetContentLabel.sizeToFit()
        
        let imageUrl = URL(string: ((user["profile_image_url_https"] as? String)!))
        let data = try? Data(contentsOf: imageUrl!)
        
        if let imageData = data {
            cell.profileImageView.image = UIImage(data: imageData)
        }
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
