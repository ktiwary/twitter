//
//  ComposeTweetViewController.swift
//  twitter
//
//  Created by Kushagra Kumar Tiwary on 9/29/14.
//  Copyright (c) 2014 myorg. All rights reserved.
//

import UIKit

class ComposeTweetViewController: UIViewController {

    @IBOutlet weak var composeImage: UIImageView!
    @IBOutlet weak var composeName: UILabel!
    @IBOutlet weak var composeText: UITextView!
    
    var userName :String?
    var imageUrl :String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        composeName.text = userName?
        composeImage.setImageWithURL(NSURL(string: imageUrl!))

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTweet(sender: AnyObject) {
        println("user:\(composeName.text) tweeted:\(composeText.text)")
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
