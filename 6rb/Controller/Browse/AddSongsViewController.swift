//
//  AddSongsViewController.swift
//  6rb
//
//  Created by Admin on 10/28/19.
//  Copyright © 2019 6rb. All rights reserved.
//

import UIKit

protocol AddSongsToPlaylistDelegate {
    func addedSongsToPlaylist()
}
class AddSongsViewController: UIViewController {

    @IBOutlet weak var searchConView: UIView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var musicList: [MusicModel] = []
    var searchedMusicList: [MusicModel] = []
    var selectedMusics: [String] = []
    
    var playlist: PlaylistModel!
    var delegate: AddSongsToPlaylistDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        congfigureView()
        getAllSongs()
    }
    

    func congfigureView() {
        searchConView.layer.borderColor = UIColor.lightGray.cgColor
        
        txtSearch.addTarget(self, action: #selector(changedSearchText), for: .editingChanged)
    }
    
    func getAllSongs() {
        ProgressHud.shared.show(view: view, msg: "")
        APIManager.shared.getAllSongs(completion: {
            error, response in
            ProgressHud.shared.dismiss()
            if error != nil {
                //                print(error!.localizedDescription)//
                CommonManager.shared.showAlert(viewCtrl: self, title: "Error", msg: error!.localizedDescription)
            } else {
                let res = response as! [String: Any]
                let code = res["status"] as! Int
                if code == 200 {
                    let list = res["data"] as! [Any]
                    for l in list {
                        let music = MusicModel(dict: l as! [String: Any])
                        self.musicList.append(music)
                        self.searchedMusicList.append(music)
                    }
                    
                    self.tableView.reloadData()
                    
                } else {
                    let message = res["message"] as! String
                    CommonManager.shared.showAlert(viewCtrl: self, title: "Error", msg: message)
                }
            }
        })
    }
    
    @objc func changedSearchText() {
//        print(txtSearch.text)
    }
    
    @IBAction func onSearch(_ sender: Any) {
        let key = txtSearch.text!
        if key.count == 0 {
            searchedMusicList = musicList
            tableView.reloadData()
            
        } else {
            searchedMusicList = []
            self.tableView.reloadData()
            
            APIManager.shared.getSearchedSongs(key: key, completion: {
                error, response in
                if error != nil {
                    //                print(error!.localizedDescription)//
                    CommonManager.shared.showAlert(viewCtrl: self, title: "Error", msg: error!.localizedDescription)
                } else {
                    let res = response as! [String: Any]
                    let code = res["status"] as! Int
                    if code == 200 {
                        let list = res["data"] as! [Any]
                        for l in list {
                            let music = MusicModel(dict: l as! [String: Any])
                            self.searchedMusicList.append(music)
                        }
                        
                        self.tableView.reloadData()
                        
                    } else {
                        let message = res["message"] as! String
                        CommonManager.shared.showAlert(viewCtrl: self, title: "Error", msg: message)
                    }
                }
            })
        }
    }
    
    
    @objc func btnMainTapped(sender: UIButton) {
        let index = sender.tag
        let music = searchedMusicList[index]
        
        music.isSelected = !music.isSelected
        tableView.reloadData()
//            GlobalData.selectedMusics = [music]
//            GlobalData.isRandom = false
//            NotificationCenter.default.post(name: Notification.Name(rawValue: "open-playerview"), object: nil)
    }
    
    @IBAction func addSongs(_ sender: Any) {
        selectedMusics = []
        for music in searchedMusicList{
            if music.isSelected {
                selectedMusics.append(music.id)
            }
        }
        
        if selectedMusics.count == 0 {
            CommonManager.shared.showAlert(viewCtrl: self, title: "Warning", msg: "Please select musics to add.")
            return
        }
        
        ProgressHud.shared.show(view: view, msg: "")
        let body = [
            "id_play_list" : playlist.id,
            "songs": selectedMusics
            ] as [String : Any]

        
        APIManager.shared.addMusicToPlaylist(body: body, completion: {
            error, response in
            ProgressHud.shared.dismiss()
            self.dismiss(animated: true, completion: {
                self.delegate.addedSongsToPlaylist()
            })
        })
    }
    
    @IBAction func onClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension AddSongsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedMusicList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongTableViewCell", for: indexPath) as! SongTableViewCell
        let music = searchedMusicList[indexPath.row]
        cell.imgThumbnail.kf.setImage(with: URL(string: music.thumbnail_url)!, placeholder: UIImage(named: "picture_placeholder"))
        cell.lblTitle.text = music.title
        cell.lblLikeCnt.text = "\(music.like_cnt)"
        cell.lblTime.text = CommonManager.shared.secToTime(sec: music.length)
        cell.lblPlayCnt.text = "\(music.play_cnt)"
        cell.lblUserName.text = "\(music.name)"
        cell.lblAddedCnt.text = "\(music.added_cnt)"
        cell.btnMain.tag = indexPath.row
        cell.btnMain.addTarget(self, action: #selector(btnMainTapped(sender:)), for: .touchUpInside)
        
        cell.imgCheck.image = music.isSelected ? UIImage(named: "ic_checked") : UIImage(named: "ic_unchecked")
        return cell
    }
    
    
}

extension AddSongsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadData()
    }
}

