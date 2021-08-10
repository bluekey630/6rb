//
//  AdminChatModel.swift
//  6rb
//
//  Created by Admin on 11/12/19.
//  Copyright © 2019 6rb. All rights reserved.
//

import Foundation
class AdminChatModel: NSObject {
    
    var id = ""
    var content = ""
    var created = 0
    var photo_url = ""
    var user_id = ""
    
    override init() {
        super.init()
    }
    
    init(dict: [String: Any]) {
        if let val = dict["id"] as? String                  { id = val }
        if let val = dict["content"] as? String             { content = val }
        if let val = dict["created"] as? Int                { created = val }
        if let val = dict["photo_url"] as? String           { photo_url = val }
        if let val = dict["user_id"] as? String             { user_id = val }
    }
}
