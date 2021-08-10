//
//  ReceivedTextChatTableViewCell.swift
//  6rb
//
//  Created by PCH-37 on 2019/8/23.
//  Copyright © 2019 6rb. All rights reserved.
//

import UIKit

class ReceivedTextChatTableViewCell: UITableViewCell {

    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var imgBubble: UIImageView!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        changeImage("bubble_received")
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func changeImage(_ name: String) {
        guard let image = UIImage(named: name) else { return }
        imgBubble.image = image
            .resizableImage(withCapInsets:
                UIEdgeInsets(top: 17, left: 21, bottom: 17, right: 21),
                            resizingMode: .stretch)
            .withRenderingMode(.alwaysTemplate)
        imgBubble.tintColor = UIColor.white
    }
}
