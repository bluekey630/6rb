//
//  GlobalData.swift
//  6rb
//
//  Created by PCH-37 on 2019/8/20.
//  Copyright © 2019 6rb. All rights reserved.
//

import Foundation
import AVKit
import SwiftAudio

class GlobalData {
    static var isLogin = false
    static var from = ""
    static var player: AVPlayer!
    static var isPlayingBanner = false
    static var selectedPlaylist = PlaylistModel()
    static var selectedMusics: [MusicModel] = []
    static var isRandom = false
    static var selectedMusic = MusicModel()
    static var playerState: AudioPlayerState!
    static var sliderValue: Float = 0
    static var myAccount = UserModel()
    static var bannerMusics: [MusicModel] = []
}
