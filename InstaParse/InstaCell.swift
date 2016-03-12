//
//  InstaCell.swift
//  InstaParse
//
//  Created by Kwaku Owusu on 3/10/16.
//  Copyright © 2016 Kwaku Owusu. All rights reserved.
//

import UIKit
import Parse
import AFNetworking
import ParseUI
class InstaCell: UITableViewCell {
    
    
    @IBOutlet weak var captionLabel: UILabel!
    
    
    @IBOutlet weak var instaView: PFImageView!
    
    var author: String?
    var getPosts: PFObject! {
        didSet {
            self.captionLabel.text = ""
            self.captionLabel.text = getPosts["caption"] as? String
            if let userPicture = /*PFUser.currentUser()?*/getPosts["media"] as? PFFile {
                userPicture.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                    if (error == nil) {
                        self.instaView.image = UIImage(data:imageData!)
                    }
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
