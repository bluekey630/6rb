//
//  UserModel.swift
//  6rb
//
//  Created by PCH-37 on 2019/9/17.
//  Copyright © 2019 6rb. All rights reserved.
//

import Foundation
class UserModel: NSObject {
    
    var id = ""
    var name = ""
    var email = ""
    var nickname = ""
    var avatar = ""
    var banner = ""
    var like_cnt = 0
    var followings = 0
    var followers = 0
    var token = ""
    var song_cnt = 0
    
    override init() {
        super.init()
    }
    
    init(dict: [String: Any]) {
        if let val = dict["id"] as? String                  { id = val }
        if let val = dict["name"] as? String                { name = val }
        if let val = dict["email"] as? String               { email = val }
        if let val = dict["nickname"] as? String            { nickname = val }
        if let val = dict["avatar"] as? String              { avatar = Constants.RESOURCE_BASE_URL + "img/profile/avatar/" + val }
        if let val = dict["banner"] as? String              { banner = Constants.RESOURCE_BASE_URL + "img/profile/banner/" + val }
        if let val = dict["like_cnt"] as? String            { like_cnt = Int(val)! }
        if let val = dict["followings"] as? String          { followings = Int(val)! }
        if let val = dict["followers"] as? String           { followers = Int(val)! }
        if let val = dict["token"] as? String               { token = val }
        if let val = dict["song_cnt"] as? String           { song_cnt = Int(val)! }
    }
}
