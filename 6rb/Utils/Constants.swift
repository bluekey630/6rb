//
//  Constants.swift
//  6rb
//
//  Created by PCH-37 on 2019/8/20.
//  Copyright © 2019 6rb. All rights reserved.
//

import Foundation
class Constants {
    static let BASE_URL =                   "http://www.6rb.com/6rb/api/"
    static let RESOURCE_BASE_URL =          "http://www.6rb.com/6rb/assets/"
    static let GET_BANNER_MUSIC_LIST =      BASE_URL + "song/getBannerSongList"
    static let GET_RANDOM_MUSIC_LIST =      BASE_URL + "song/getSongListByBlock"
    static let GET_PLAYLIST =               BASE_URL + "playList/getPlayList"
    static let GET_DETAIL_PLAYLIST =        BASE_URL + "playList/getSongList"
    static let GET_BEST_SONGS =             BASE_URL + "song/getBestSongs"
    static let GET_BEST_PLAYLIST =          BASE_URL + "playList/getBestPlayLists"
    static let GET_BEST_LIKE_USERS =        BASE_URL + "user/getBestUsers"
    static let GET_BEST_FOLLOWER_USERS =    BASE_URL + "user/getBestFollowers"
    static let GET_ALL_SONGS =              BASE_URL + "song/getSongList"
    static let GET_SEARCHED_SONGS =         BASE_URL + "song/searchSong"
    static let LOGIN =                      BASE_URL + "user/login"
    static let GET_HISTORY_SONGS =          BASE_URL + "song/history"
    static let PLAY_SONG =                  BASE_URL + "song/play"
    static let GET_MYSONGS =                BASE_URL + "song/mySong"
    static let GET_MY_PLAYLISTS =           BASE_URL + "playList/myPlayList"
    static let CREATE_PLAYLIST =            BASE_URL + "playList/create"
    static let UPDATE_PLAYLIST =            BASE_URL + "playList/updatePlayList"
    static let DELETE_PLAYLIST =            BASE_URL + "playList/delete"
    static let ADD_MUSICS_TO_PLAYLIST =     BASE_URL + "playList/addSongs"
    static let GET_USER_INFO =              BASE_URL + "user/getUserInfo"
    static let GET_CHAT_CONTENT =           BASE_URL + "membership/getChatDescription"
    static let GET_PRO_CHAT_CONTENT =       BASE_URL + "membership/getProDescription"
    static let GET_SUPER_CHAT_CONTENT =     BASE_URL + "membership/getSuperProDescription"
}
