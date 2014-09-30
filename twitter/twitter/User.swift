//
//  File.swift
//  twitter
//
//  Created by Kushagra Kumar Tiwary on 9/28/14.
//  Copyright (c) 2014 myorg. All rights reserved.
//

import Foundation

var _currentUser: User?
let userDatabasePersistentKey = "userDatabasePersistentKey"
let userLogoutNotification = "userLoggedOut"
let userLogInNotification = "userLoggedIn"

class User: NSObject {
    
    var userName: String?
    var userImage: String?
    var userScreenName: String?
    var userTagLine: String?
    var dictionary: NSDictionary
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        self.userName = dictionary["name"] as? String
        self.userScreenName = dictionary["screen_name"] as? String
        self.userImage = dictionary["profile_image_url"] as? String
        self.userTagLine = dictionary["description"] as? String
    }
    
    class func logout() {
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        NSNotificationCenter.defaultCenter().postNotificationName(userLogoutNotification, object: nil)
    }
    
    class func login(user: User) {
        User.currentUser = user
        NSNotificationCenter.defaultCenter().postNotificationName(userLogInNotification, object: nil)
    }
    
    class var currentUser: User? {
        
        set(user) {
        _currentUser = user
        if user != nil {
            var dataToPersist = NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: nil, error: nil)
            NSUserDefaults.standardUserDefaults().setObject(dataToPersist, forKey: userDatabasePersistentKey)
        } else {
            NSUserDefaults.standardUserDefaults().setObject(nil, forKey: userDatabasePersistentKey)
        }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        
        get {
            if _currentUser == nil {
                var dataFromDB: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey(userDatabasePersistentKey)
                if dataFromDB != nil {
                    var dataAsJson = NSJSONSerialization.JSONObjectWithData(dataFromDB as NSData, options: nil, error: nil) as? NSDictionary
                    if dataAsJson != nil {
                        _currentUser = User(dictionary: dataAsJson!)
                    }
                }
            }
            return _currentUser
        }
    }
}
