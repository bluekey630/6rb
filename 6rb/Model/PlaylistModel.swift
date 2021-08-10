//
//  PlaylistModel.swift
//  6rb
//
//  Created by PCH-37 on 2019/9/17.
//  Copyright © 2019 6rb. All rights reserved.
//

import Foundation
class PlaylistModel: NSObject {
    
    var id = ""
    var title = ""
    var thumbnail_url = ""
    var length = 0
    var like_cnt = 0
    var id_user = ""
    var play_cnt = 0
    var added_cnt = 0
    var name = ""
    var avatar = ""
    
    override init() {
        super.init()
    }
    
    init(dict: [String: Any]) {
        if let val = dict["id"] as? String                   { id = val }
        if let val = dict["title"] as? String                { title = val }
        if let val = dict["length"] as? String               { length = Int(val)! }
        if let val = dict["thumbnail"] as? String            { thumbnail_url = Constants.RESOURCE_BASE_URL + "playlist_thumb/" + val }
        if let val = dict["like_cnt"] as? String             { like_cnt = Int(val)! }
        if let val = dict["id_user"] as? String              { id_user = val }
        if let val = dict["play_cnt"] as? String             { play_cnt = Int(val)! }
        if let val = dict["added_cnt"] as? String            { added_cnt = Int(val)! }
        if let val = dict["name"] as? String                 { name = val }
        if let val = dict["avatar"] as? String               { avatar = Constants.RESOURCE_BASE_URL + "img/profile/avatar/" + val }
    }
}

