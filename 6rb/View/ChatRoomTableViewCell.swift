//
//  ChatRoomTableViewCell.swift
//  6rb
//
//  Created by PCH-37 on 2019/8/23.
//  Copyright © 2019 6rb. All rights reserved.
//

import UIKit

class ChatRoomTableViewCell: UITableViewCell {

    @IBOutlet weak var onlineView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        onlineView.layer.borderColor = UIColor.white.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
