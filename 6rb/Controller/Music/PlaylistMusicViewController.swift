//
//  PlaylistMusicViewController.swift
//  6rb
//
//  Created by PCH-37 on 2019/9/11.
//  Copyright © 2019 6rb. All rights reserved.
//

import UIKit

class PlaylistMusicViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    var playlist: [PlaylistModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        
        getPlaylist()
    }
    

    func configureView() {
        
    }
    
    func getPlaylist() {
        ProgressHud.shared.show(view: view, msg: "")
        APIManager.shared.getPlayList(completion: {
            error, response in
            ProgressHud.shared.dismiss()
            if error != nil {
                CommonManager.shared.showAlert(viewCtrl: self, title: "Error", msg: error!.localizedDescription)
            } else {
                let res = response as! [String: Any]
                let code = res["status"] as! Int
                if code == 200 {
                    let list = res["data"] as! [Any]
                    for l in list {
                        let p = PlaylistModel(dict: l as! [String: Any])
                        self.playlist.append(p)
                    }
                    
                    self.tableView.reloadData()
                } else {
                    let message = res["message"] as! String
                    CommonManager.shared.showAlert(viewCtrl: self, title: "Error", msg: message)
                }
            }
        })
    }

    @objc func btnMainTapped(sender: UIButton) {
        let index = sender.tag
        GlobalData.selectedPlaylist = playlist[index]
        NotificationCenter.default.post(name: Notification.Name(rawValue: "goto_playlist"), object: nil)
    }
}

extension PlaylistMusicViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension PlaylistMusicViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistTableViewCell", for: indexPath) as! PlaylistTableViewCell
        
        let p = playlist[indexPath.row]
        
        cell.lblTitle.text = p.title
        cell.lblTime.text = CommonManager.shared.secToTime(sec: p.length)
        cell.imgThumbnail.kf.setImage(with: URL(string: p.thumbnail_url)!, placeholder: UIImage(named: "picture_placeholder"))
        
        cell.btnMain.tag = indexPath.row
        cell.btnMain.addTarget(self, action: #selector(btnMainTapped(sender:)), for: .touchUpInside)
        
    
        cell.lblLikeCnt.text = "\(p.like_cnt)"
        cell.lblAddedCnt.text = "\(p.added_cnt)"
        cell.btnPlayedCnt.text = "\(p.play_cnt)"
        cell.btnUserName.text = "\(p.name)"

        return cell
    }
}
