//
//  Chat6rbLoginViewController.swift
//  6rb
//
//  Created by PCH-37 on 2019/8/26.
//  Copyright © 2019 6rb. All rights reserved.
//

import UIKit

class Chat6rbLoginViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var arabicTableView: UITableView!
    @IBOutlet weak var arabicTableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var englishTableView: UITableView!
    @IBOutlet weak var englishTableViewHeight: NSLayoutConstraint!
    
    var arabicContents: [String] = []
    var englishContents: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        getContent()
    }
    

    func configureView() {
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 2
        contentView.layer.shadowOpacity = 0.5
        
        arabicTableView.estimatedRowHeight = 20
        arabicTableView.rowHeight = UITableView.automaticDimension
        
        englishTableView.estimatedRowHeight = 20
        englishTableView.rowHeight = UITableView.automaticDimension
    }
    
    func getContent() {
        ProgressHud.shared.show(view: view, msg: "")
        APIManager.shared.getChatContent(completion: {
            error, resonse in
            ProgressHud.shared.dismiss()
            if error != nil {
                CommonManager.shared.showAlert(viewCtrl: self, title: "Error", msg: error!.localizedDescription)
            } else {
                let res = resonse as! [String: Any]
                let status = res["status"] as! Int
                if status == 200 {
                    let data = res["data"] as! [String: Any]
                    self.arabicContents = data["arabic"] as! [String]
                    self.arabicTableView.reloadData()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.arabicTableViewHeight.constant = self.arabicTableView.contentSize.height
                    }
                    
                    
                    self.englishContents = data["english"] as! [String]
                    self.englishTableView.reloadData()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.englishTableViewHeight.constant = self.englishTableView.contentSize.height
                    }
                    
                    
                } else {
                    let message = res["message"] as! String
                    CommonManager.shared.showAlert(viewCtrl: self, title: "Error", msg: message)
                }
            }
        })
    }

    @IBAction func onLoginChat(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        present(vc, animated: true, completion: nil)
    }
}

extension Chat6rbLoginViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tableView.tag == 100 ? arabicContents.count : englishContents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 100 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatContentArabic", for: indexPath) as! ChatContentTableViewCell
            cell.lblContent.text = "- \(arabicContents[indexPath.row])"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatContentEnglish", for: indexPath) as! ChatContentTableViewCell
            cell.lblContent.text = "- \(englishContents[indexPath.row])"
            return cell
        }
        
    }
}

extension Chat6rbLoginViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 20
//    }
}
