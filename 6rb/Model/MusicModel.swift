//
//  MusicModel.swift
//  6rb
//
//  Created by PCH-37 on 2019/9/15.
//  Copyright © 2019 6rb. All rights reserved.
//

import Foundation
class MusicModel: NSObject {
    
    var id = ""
    var title = ""
    var length = 0
    var song_url = ""
    var thumbnail_url = ""
    var like_cnt = 0
    var user_id = ""
    var auther = ""
    var singer = ""
    var play_cnt = 0
    var name = ""
    var avatar = ""
    var added_cnt = 0
    var isSelected = false
    
    override init() {
        super.init()
    }
    
    init(dict: [String: Any]) {
        if let val = dict["id"] as? String                   { id = val }
        if let val = dict["title"] as? String                { title = val }
        if let val = dict["length"] as? String               { length = Int(val)! }
        if let val = dict["song_url"] as? String             { song_url = Constants.RESOURCE_BASE_URL + "song/" + val }
        if let val = dict["thumbnail_url"] as? String        { thumbnail_url = Constants.RESOURCE_BASE_URL + "thumbnail/" + val }
        if let val = dict["like_cnt"] as? String             { like_cnt = Int(val)! }
        if let val = dict["user_id"] as? String              { user_id = val }
        if let val = dict["auther"] as? String               { auther = val }
        if let val = dict["singer"] as? String               { singer = val }
        if let val = dict["play_cnt"] as? String             { play_cnt = Int(val)! }
        if let val = dict["name"] as? String                 { name = val }
        if let val = dict["avatar"] as? String               { avatar = Constants.RESOURCE_BASE_URL + "img/profile/avatar/" + val }
        if let val = dict["added_cnt"] as? String            { added_cnt = Int(val)! }
    }
}



