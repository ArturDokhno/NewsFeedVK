//
//  NewsFeedCell.swift
//  NewsFeedVK
//
//  Created by Артур Дохно on 11.11.2021.
//

import Foundation
import UIKit

class NewsFeedCell: UITableViewCell {
    
    static let reuseId = "NewsFeedCell"
    
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var postLabel: UILabel!
    @IBOutlet var likesLabel: UILabel!
    @IBOutlet var commentsLabel: UILabel!
    @IBOutlet var sharesLabel: UILabel!
    @IBOutlet var viewsLabel: UILabel!
    
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}
