//
//  PhotosTableViewCell.swift
//  Parsetagram
//
//  Created by Avinash Singh on 07/12/17.
//  Copyright © 2017 Avinash Singh. All rights reserved.
//

import UIKit
import Parse
import ParseUI


class PhotosTableViewCell: UITableViewCell {

    
    @IBOutlet weak var photoView: PFImageView!
    
    
    @IBOutlet weak var captionLabel: UILabel!
    
    @IBOutlet weak var timestampLabel: UILabel!
    
    var post: PFObject! {
        willSet {
            if post != nil{
            self.photoView.file = newValue["media"] as? PFFile
            self.photoView.loadInBackground()
            self.captionLabel.text = newValue["caption"] as? String
            let secondsBetween = Int(Date().timeIntervalSince(post.createdAt!))
            timestampLabel.text = computeTimeLabel(seconds: secondsBetween)
            photoView.layer.cornerRadius = 8.0
            photoView.clipsToBounds = true
            
            }
        }
    }
    
    func computeTimeLabel(seconds: Int!) -> String{
        var date : String = ""
        
        if seconds < 60 {
            date = "1m"
        }
        else if seconds < 3600 {
            date = "\(seconds / 60)m"
        }
        else if seconds < 86400 {
            date = "\(seconds / 3600)h"
        }
        else {
            date = "\(seconds / 86400)d"
        }
        
        return date
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
