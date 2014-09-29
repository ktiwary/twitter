//
//  TweetsTableViewCell.swift
//  twitter
//
//  Created by Kushagra Kumar Tiwary on 9/27/14.
//  Copyright (c) 2014 myorg. All rights reserved.
//

import UIKit

class TweetsTableViewCell: UITableViewCell {

    @IBOutlet weak var tweetsImageView: UIImageView!
    @IBOutlet weak var tweetsUserName: UILabel!
    @IBOutlet weak var tweetsComment: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
