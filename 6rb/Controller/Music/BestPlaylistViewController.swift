//
//  BestPlaylistViewController.swift
//  6rb
//
//  Created by PCH-37 on 2019/9/17.
//  Copyright © 2019 6rb. All rights reserved.
//

import UIKit
import AVKit

class BestPlaylistViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var dropDate: DropDown!
    
    var playlist: [PlaylistModel] = []
    var date: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        date = "week"
        getBestSongs()
    }
    
    func configureView() {
        dropDate.optionArray = ["WEEK", "MONTH", "YEAR"]
        dropDate.selectValue(index: 0)
        dropDate.didSelect(completion: {selectedText, index, id in
            print(selectedText, index, id)
        })
        
        dropDate.delegate = self
        
        tableView.isHidden = true
    }
    
    func getBestSongs() {
        APIManager.shared.getBestPlaylist(more: true, date: date, completion: {
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
                        let p = PlaylistModel(dict: l as! [String: Any])
                        self.playlist.append(p)
                    }
                    
                    self.tableViewHeight.constant = CGFloat(90 * self.playlist.count)
                    self.tableView.reloadData()
                    self.tableView.isHidden = false
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

extension BestPlaylistViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

extension BestPlaylistViewController: UITableViewDataSource {
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
        return cell
        
    }
}

extension BestPlaylistViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        dropDate.isSelected ?  dropDate.hideList() : dropDate.showList()
        return false
    }
}
