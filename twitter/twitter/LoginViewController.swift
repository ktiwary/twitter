//
//  LoginViewController.swift
//  twitter
//
//  Created by Kushagra Kumar Tiwary on 9/27/14.
//  Copyright (c) 2014 myorg. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onLogin(sender: AnyObject) {
        TwitterClient.sharedInstance.loginAndGetUser() {
            (user: User?, error: NSError?) in
            if user != nil {
                println("got user from closure: \(user?.userName)")
                User.login(user!)
//                self.performSegueWithIdentifier("TweetListViewSegue", sender: self)
                //perform segue
            } else {
                println(error?)
            }
        }
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
