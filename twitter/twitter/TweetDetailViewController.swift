//
//  TweetDetailViewController.swift
//  twitter
//
//  Created by Kushagra Kumar Tiwary on 9/28/14.
//  Copyright (c) 2014 myorg. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tweetDetailTableView: UITableView!
    var userName :String?
    var userText :String?
    var userImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetDetailTableView.delegate = self
        tweetDetailTableView.dataSource = self
//        tweetDetailTableView.rowHeight = UITableViewAutomaticDimension
//        tweetDetailTableView.estimatedRowHeight = UITableViewAutomaticDimension

        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("TweetDetailCell") as TweetsTableViewCell
        cell.tweetsUserName.text = userName
        cell.tweetsComment.text = userText
        cell.tweetsImageView.image = userImage
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if sender .isKindOfClass(UIBarButtonItem) {
            var senderBarButton = sender as UIBarButtonItem
            if senderBarButton.title == "Reply" {
                var nav = segue.destinationViewController as UINavigationController
                var composeTweetViewController = nav.viewControllers[0] as ComposeTweetViewController
                composeTweetViewController.userName = User.currentUser?.userName
                composeTweetViewController.imageUrl = User.currentUser?.userImage
            }
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
