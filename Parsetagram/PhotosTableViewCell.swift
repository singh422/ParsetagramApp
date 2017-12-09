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
    
    
    var post: PFObject! {
        willSet {
            if post != nil{
            self.photoView.file = newValue["media"] as? PFFile
            self.photoView.loadInBackground()
            self.captionLabel.text = newValue["caption"] as? String
            
            print("caption labels text")
            print(captionLabel.text!)
            }
        }
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
