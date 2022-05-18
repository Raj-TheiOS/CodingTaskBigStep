//
//  ContactTableViewCell.swift
//  CodingExercise
//
//  Created by Bigstep Technologies on 6/8/20.
//  Copyright © 2020 Bigstep Technologies. All rights reserved.
//

import UIKit
import Kingfisher

class ContactTableViewCell: UITableViewCell, ReusableCell {
    
    // MARK: Outlets
    @IBOutlet weak var imgContact: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTag: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgContact.layer.cornerRadius = 20.0
        imgContact.contentMode = .scaleAspectFill
    }
    
    /*
     TODO
     */
    // MARK:- Loading passed data from ViewController
    var object: ContactDetails? {
        didSet {
            
            // Adding name
            self.lblName.text = "\(object?.first_name ?? "")" + " \(object?.last_name ?? "")"
            
            // Adding tag
            self.lblTag.text = object?.tag_handle ?? ""
            
            // Setting image
            self.imgContact.kf.indicatorType = .activity
            self.imgContact.kf.setImage(with: URL(string: object?.image_url ?? ""))

        }
    }
}
