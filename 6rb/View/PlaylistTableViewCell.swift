//
//  PlaylistTableViewCell.swift
//  6rb
//
//  Created by PCH-37 on 2019/8/21.
//  Copyright © 2019 6rb. All rights reserved.
//

import UIKit
import MGSwipeTableCell

class PlaylistTableViewCell: MGSwipeTableCell {

    @IBOutlet weak var btnMain: UIButton!
    @IBOutlet weak var imgThumbnail: UIImageView!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var lblLikeCnt: UILabel!
    
    @IBOutlet weak var btnAdded: UIButton!
    @IBOutlet weak var lblAddedCnt: UILabel!
    
    @IBOutlet weak var btnPlayed: UIButton!
    @IBOutlet weak var btnPlayedCnt: UILabel!
    
    @IBOutlet weak var btnUser: UIButton!
    @IBOutlet weak var btnUserName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
