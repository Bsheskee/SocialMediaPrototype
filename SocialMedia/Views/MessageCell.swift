//
//  MessageCell.swift
//  SocialMedia
//
//  Created by bartek on 17/12/2023.
//
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code to what happens in the Xfiletable
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 5
    }
    
}
