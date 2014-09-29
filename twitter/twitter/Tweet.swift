//
//  Tweet.swift
//  twitter
//
//  Created by Kushagra Kumar Tiwary on 9/28/14.
//  Copyright (c) 2014 myorg. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var tweetUser: User?
    var tweetText: String?
    var tweetCreatedAtString: String?
    var tweetCreatedAt: NSDate?
    let formatter = NSDateFormatter()

    
    init(dictionary: NSDictionary) {
        self.tweetUser = User(dictionary: dictionary["user"] as NSDictionary)
        self.tweetText = dictionary["text"] as? String
        self.tweetCreatedAtString = dictionary["created_at"] as? String
        
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        self.tweetCreatedAt = formatter.dateFromString(self.tweetCreatedAtString!)
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        return tweets
    }
    
    func forGettingArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        return tweets
    }
   
}
