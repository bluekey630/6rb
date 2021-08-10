//
//  APIManager.swift
//  6rb
//
//  Created by PCH-37 on 2019/9/15.
//  Copyright © 2019 6rb. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    
    static let shared = APIManager()
    private init() {}
    
    func getBannerMusicList(completion: @escaping(Error?, Any?)->()) {
        
        let url = Constants.GET_BANNER_MUSIC_LIST
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { response in
            
            switch response.result {
            case .success(let JSON):
                completion(nil, JSON)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
    
    func getRandomMusicList(completion: @escaping(Error?, Any?)->()) {
        
        let url = Constants.GET_RANDOM_MUSIC_LIST
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { response in
            
            switch response.result {
            case .success(let JSON):
                completion(nil, JSON)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
    
    func getPlayList(completion: @escaping(Error?, Any?)->()) {
        
        let url = Constants.GET_PLAYLIST
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { response in
            
            switch response.result {
            case .success(let JSON):
                completion(nil, JSON)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
    
    func getDetailPlayListSongs(id: String, completion: @escaping(Error?, Any?)->()) {
        let data = [
            "id_play_list" : id
        ]
        
        let url = Constants.GET_DETAIL_PLAYLIST
        Alamofire.request(url, method: .post, parameters: data, encoding: JSONEncoding.default).responseJSON { response in
            
            switch response.result {
            case .success(let JSON):
                completion(nil, JSON)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
    
    func getBestSongs(more: Bool, date: String, completion: @escaping(Error?, Any?)->()) {
        let data = [
                "view_more" : more,
                "date": date
            ] as [String : Any]
        
        let url = Constants.GET_BEST_SONGS
        Alamofire.request(url, method: .post, parameters: data, encoding: JSONEncoding.default).responseJSON { response in
            
            switch response.result {
            case .success(let JSON):
                completion(nil, JSON)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }

    func getBestPlaylist(more: Bool, date: String, completion: @escaping(Error?, Any?)->()) {
        let data = [
            "view_more" : more,
            "date": date
        ] as [String : Any]
        
        let url = Constants.GET_BEST_PLAYLIST
        Alamofire.request(url, method: .post, parameters: data, encoding: JSONEncoding.default).responseJSON { response in
            
            switch response.result {
            case .success(let JSON):
                completion(nil, JSON)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
    
    func getBestLikeUsers(more: Bool, date: String, completion: @escaping(Error?, Any?)->()) {
        let data = [
            "view_more" : more,
            "date": date
        ] as [String : Any]
        
        let url = Constants.GET_BEST_LIKE_USERS
        Alamofire.request(url, method: .post, parameters: data, encoding: JSONEncoding.default).responseJSON { response in
            
            switch response.result {
            case .success(let JSON):
                completion(nil, JSON)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
    
    func getBestFollowers(more: Bool, date: String, completion: @escaping(Error?, Any?)->()) {
        let data = [
            "view_more" : more,
            "date": date
        ] as [String : Any]
        
        let url = Constants.GET_BEST_FOLLOWER_USERS
        Alamofire.request(url, method: .post, parameters: data, encoding: JSONEncoding.default).responseJSON { response in
            
            switch response.result {
            case .success(let JSON):
                completion(nil, JSON)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
    
    func getAllSongs(completion: @escaping(Error?, Any?)->()) {
        
        let url = Constants.GET_ALL_SONGS
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { response in
            
            switch response.result {
            case .success(let JSON):
                completion(nil, JSON)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
    
    func getSearchedSongs(key: String, completion: @escaping(Error?, Any?)->()) {
        
        let url = (Constants.GET_SEARCHED_SONGS + "?search=\(key)").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { response in
            
            switch response.result {
            case .success(let JSON):
                completion(nil, JSON)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
    
    func login(body: [String: Any], completion: @escaping(Error?, Any?)->()) {
        
        let url = Constants.LOGIN
        Alamofire.request(url, method: .post, parameters: body, encoding: JSONEncoding.default).responseJSON { response in
            
            switch response.result {
            case .success(let JSON):
                completion(nil, JSON)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
    
    func getHistorySongs(completion: @escaping(Error?, Any?)->()) {
        print(GlobalData.myAccount.token)
        let headers = [
            "Authorization": "Bearer \(GlobalData.myAccount.token)"
        ]
        
        let url = Constants.GET_HISTORY_SONGS
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            switch response.result {
            case .success(let JSON):
                completion(nil, JSON)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
    
    func playSong(body: [String: Any], completion: @escaping(Error?, Any?)->()) {
        print(GlobalData.myAccount.token)
        let headers = [
            "Authorization": "Bearer \(GlobalData.myAccount.token)"
        ]
        
        let url = Constants.PLAY_SONG
        Alamofire.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            switch response.result {
            case .success(let JSON):
                completion(nil, JSON)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
    
    func getMySongs(completion: @escaping(Error?, Any?)->()) {
        print(GlobalData.myAccount.token)
        let headers = [
            "Authorization": "Bearer \(GlobalData.myAccount.token)"
        ]
        
        let url = Constants.GET_MYSONGS
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            switch response.result {
            case .success(let JSON):
                completion(nil, JSON)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
    
    func getMyPlaylists(completion: @escaping(Error?, Any?)->()) {
        print(GlobalData.myAccount.token)
        let headers = [
            "Authorization": "Bearer \(GlobalData.myAccount.token)"
        ]
        
        let url = Constants.GET_MY_PLAYLISTS
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            switch response.result {
            case .success(let JSON):
                completion(nil, JSON)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
    
    func createPlaylist(filename: URL, title: String, completion: @escaping(Error?, Any?)->()) {
        print(GlobalData.myAccount.token)
        let headers = [
            "Authorization": "Bearer \(GlobalData.myAccount.token)"
        ]
        
        let url = Constants.CREATE_PLAYLIST
        Alamofire.upload(multipartFormData: {
            multipartFormData in
            multipartFormData.append(Data(title.utf8), withName: "title")
            multipartFormData.append(filename, withName: "thumbnail", fileName: "avatar.jpg", mimeType: "image/jpeg")
        }, to: url,
           method: .post,
           headers: headers,
           encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON(completionHandler: {
                    response in
                    switch response.result {
                    case .success(let JSON):
                        completion(nil, JSON)
                    case .failure(let error):
                        completion(error, nil)
                    }
                })
            case .failure(let error):
                completion(error, nil)
            }
        })
        
    }
    
    func updatePlaylist(id: String, filename: URL?, title: String, completion: @escaping(Error?, Any?)->()) {
        print(GlobalData.myAccount.token)
        let headers = [
            "Authorization": "Bearer \(GlobalData.myAccount.token)"
        ]
        
        let url = Constants.UPDATE_PLAYLIST
        Alamofire.upload(multipartFormData: {
            multipartFormData in
            multipartFormData.append(Data(title.utf8), withName: "title")
            if filename != nil {
                multipartFormData.append(filename!, withName: "thumbnail", fileName: "avatar.jpg", mimeType: "image/jpeg")
            }
            multipartFormData.append(Data(id.utf8), withName: "id")
            
        }, to: url,
           method: .post,
           headers: headers,
           encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: {
                    progress in
                    print(progress.totalUnitCount)
                    print(progress.completedUnitCount)
                    print(progress.fractionCompleted)
                })
                
                upload.responseJSON(completionHandler: {
                    response in
                    switch response.result {
                    case .success(let JSON):
                        completion(nil, JSON)
                    case .failure(let error):
                        completion(error, nil)
                    }
                })
            case .failure(let error):
                completion(error, nil)
            }
        })
        
    }
    
    func deletePlaylist(body: [String: Any], completion: @escaping(Error?, Any?)->()) {
        
        let headers = [
            "Authorization": "Bearer \(GlobalData.myAccount.token)"
        ]
        
        let url = Constants.DELETE_PLAYLIST
        Alamofire.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            switch response.result {
            case .success(let JSON):
                completion(nil, JSON)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
    
    func addMusicToPlaylist(body: [String: Any], completion: @escaping(Error?, Any?)->()) {
        
        let headers = [
            "Authorization": "Bearer \(GlobalData.myAccount.token)"
        ]
        
        let url = Constants.ADD_MUSICS_TO_PLAYLIST
        Alamofire.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            switch response.result {
            case .success(let JSON):
                completion(nil, JSON)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
    
    func getUserInfo(id: String, completion: @escaping(Error?, Any?)->()) {
        
        let body = [
            "id": id
        ]
        
        let url = Constants.GET_USER_INFO
        Alamofire.request(url, method: .post, parameters: body, encoding: JSONEncoding.default).responseJSON { response in
            
            switch response.result {
            case .success(let JSON):
                completion(nil, JSON)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
    
    func getChatContent(completion: @escaping(Error?, Any?)->()) {
        let url = Constants.GET_CHAT_CONTENT
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { response in
            
            switch response.result {
            case .success(let JSON):
                completion(nil, JSON)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
    
    func getProChatContent(completion: @escaping(Error?, Any?)->()) {
        let url = Constants.GET_PRO_CHAT_CONTENT
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { response in
            
            switch response.result {
            case .success(let JSON):
                completion(nil, JSON)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
    
    func getSuperChatContent(completion: @escaping(Error?, Any?)->()) {
        let url = Constants.GET_SUPER_CHAT_CONTENT
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { response in
            
            switch response.result {
            case .success(let JSON):
                completion(nil, JSON)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
}

