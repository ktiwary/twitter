//
//  TweetListViewController.swift
//  twitter
//
//  Created by Kushagra Kumar Tiwary on 9/27/14.
//  Copyright (c) 2014 myorg. All rights reserved.
//

import UIKit

class TweetListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tweetListTableView: UITableView!
    var refreshControl = UIRefreshControl()
    var tweets: [Tweet] = [Tweet] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetListTableView.dataSource = self
        tweetListTableView.delegate = self
//        tweetListTableView.rowHeight = UITableViewAutomaticDimension
//        tweetListTableView.estimatedRowHeight = UITableViewAutomaticDimension
        println("populating tweets")
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "kushRefresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tweetListTableView.addSubview(refreshControl)
        populateTweets()
        // Do any additional setup after loading the view.
    }
    
    func kushRefresh(sender:AnyObject) {
        println("kush refresh called")
        populateTweets()
        self.refreshControl.endRefreshing()
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.logout()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets.count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("TweetCell") as TweetsTableViewCell
        var tweet = self.tweets[indexPath.row] as Tweet
        cell.tweetsUserName.text = tweet.tweetUser?.userScreenName
        cell.tweetsComment.text = tweet.tweetText
        let imageUrl = tweet.tweetUser?.userImage
        cell.tweetsImageView.setImageWithURL(NSURL(string: imageUrl!))
        return cell
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func populateTweets() {
        MMProgressHUD.showWithTitle("Loading", status: "25%")
        TwitterClient.sharedInstance.GET("1.1/statuses/user_timeline.json", parameters: nil, success: { (op: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            //                println("timeline:\(response)")
            self.tweets = Tweet.tweetsWithArray(response as [NSDictionary])
            self.tweetListTableView.reloadData()
            for tweet in self.tweets {
                println("timeof tweet: \(tweet.tweetCreatedAt)")
            }
            
            }) { (op: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("Failed to get timeline")
        }
        MMProgressHUD.dismiss()
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if sender .isKindOfClass(TweetsTableViewCell) {
            var nav = segue.destinationViewController as UINavigationController
            var tweetDetailViewController = nav.viewControllers[0] as TweetDetailViewController
            var cell = sender as TweetsTableViewCell
            tweetDetailViewController.userName = cell.tweetsUserName.text
            tweetDetailViewController.userText = cell.tweetsComment.text
            tweetDetailViewController.userImage = cell.tweetsImageView.image
        } else if sender .isKindOfClass(UIBarButtonItem) {
            var nav = segue.destinationViewController as UINavigationController
            var composeTweetViewController = nav.viewControllers[0] as ComposeTweetViewController
            composeTweetViewController.userName = User.currentUser?.userName
            composeTweetViewController.imageUrl = User.currentUser?.userImage
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
