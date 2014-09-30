//
//  TwitterClient.swift
//  twitter
//
//  Created by Kushagra Kumar Tiwary on 9/27/14.
//  Copyright (c) 2014 myorg. All rights reserved.
//

import UIKit

let twitterBaseURL = NSURL(string: "https://api.twitter.com")
let twitterConsumerKey = "0wSAkUAebXIhKqqpVToSaw83m"
let twitterConsumerSecret = "xqhZOM8S3tZpxoXLJyRTN7M10hikxMXC4FEO4OyIrZNw1nx2gX"

class TwitterClient: BDBOAuth1RequestOperationManager {
    
    var completion: ((user: User?, error: NSError?) -> Void)?
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
            return Static.instance
    }
    
    func loginAndGetUser(completion: (user: User?, error: NSError?) -> Void) {
        println("getting user info")
        self.completion = completion
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "traveangletwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuthToken!) -> Void in
            println("Got request token:\(requestToken.token)")
            var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL)
            }) { (error: NSError!) -> Void in
                self.completion?(user: nil, error: error)
                println("Failed to get request token")
        }
    }
    
    func openURL(url: NSURL) {
        TwitterClient.sharedInstance.fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuthToken(queryString: url.query), success: { (accessToken: BDBOAuthToken!) -> Void in
            println("Got the access token")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            println("accessToken:\(TwitterClient.sharedInstance.requestSerializer.accessToken)")
            
            
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (reqOperation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                //                println("user:\(response)")
                var user = User(dictionary: response as NSDictionary)
                println("userName:\(user.userScreenName)")
                self.completion?(user: user, error: nil)
                }) { (reqOp: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    self.completion?(user: nil, error: error)
                    println(error)
            }
            
            }) { (error: NSError!) -> Void in
                self.completion?(user: nil, error: error)
                println("Failed to get access token")
        }
    }

   
}
