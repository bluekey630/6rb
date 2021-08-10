//
//  ProChatViewController.swift
//  6rb
//
//  Created by PCH-37 on 2019/8/26.
//  Copyright © 2019 6rb. All rights reserved.
//

import UIKit

class ProChatViewController: UIViewController {

    @IBOutlet weak var btnEnglish: UIButton!
    @IBOutlet weak var selEngView: UIView!
    
    @IBOutlet weak var btnArabic: UIButton!
    @IBOutlet weak var selAraView: UIView!
    
    @IBOutlet weak var engConView: UIScrollView!
    @IBOutlet weak var proEnglishTableView: UITableView!
    @IBOutlet weak var proEnglishTableHeight: NSLayoutConstraint!
    
    @IBOutlet weak var superProEnglishTableView: UITableView!
    @IBOutlet weak var superProEnglishTableHeight: NSLayoutConstraint!
    
    @IBOutlet weak var araConView: UIScrollView!
    @IBOutlet weak var proArabicTableView: UITableView!
    @IBOutlet weak var proArabicTableHeight: NSLayoutConstraint!
    
    @IBOutlet weak var superProArabicTableView: UITableView!
    @IBOutlet weak var superProArabicTableHeight: NSLayoutConstraint!
    
    
    var englishProContent: [String] = []
    var englishSuperContent: [String] = []
    
    var arabicProContent: [String] = []
    var arabicSuperContent: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        getProContent()
        getSuperProContent()
    }
    

    func configureView() {
        btnEnglish.setTitleColor(UIColor.black, for: .normal)
        selEngView.isHidden = false
        
        btnArabic.setTitleColor(UIColor.lightGray, for: .normal)
        selAraView.isHidden = true
        
        engConView.isHidden = false
        araConView.isHidden = true
        
        proEnglishTableView.estimatedRowHeight = 20
        proEnglishTableView.rowHeight = UITableView.automaticDimension
        
        superProEnglishTableView.estimatedRowHeight = 20
        superProEnglishTableView.rowHeight = UITableView.automaticDimension
        
        proArabicTableView.estimatedRowHeight = 20
        proArabicTableView.rowHeight = UITableView.automaticDimension
        
        superProArabicTableView.estimatedRowHeight = 20
        superProArabicTableView.rowHeight = UITableView.automaticDimension
    }
    
    func getProContent() {
        ProgressHud.shared.show(view: view, msg: "")
        APIManager.shared.getProChatContent(completion: {
            error, response in
            ProgressHud.shared.dismiss()
            if error != nil {
                CommonManager.shared.showAlert(viewCtrl: self, title: "Error", msg: error!.localizedDescription)
            } else {
                let res = response as! [String: Any]
                let status = res["status"] as! Int
                if status == 200 {
                    let data = res["data"] as! [String: Any]
                    self.arabicProContent = data["arabic"] as! [String]
                    self.proArabicTableView.reloadData()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.proArabicTableHeight.constant = self.proArabicTableView.contentSize.height
                    }
                    
                    
                    self.englishProContent = data["english"] as! [String]
                    self.proEnglishTableView.reloadData()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.proEnglishTableHeight.constant = self.proEnglishTableView.contentSize.height
                    }
                    
                    
                } else {
                    let message = res["message"] as! String
                    CommonManager.shared.showAlert(viewCtrl: self, title: "Error", msg: message)
                }
            }
        })
    }
    
    func getSuperProContent() {
        ProgressHud.shared.show(view: view, msg: "")
        APIManager.shared.getSuperChatContent(completion: {
            error, response in
            ProgressHud.shared.dismiss()
            
            if error != nil {
                CommonManager.shared.showAlert(viewCtrl: self, title: "Error", msg: error!.localizedDescription)
            } else {
                let res = response as! [String: Any]
                let status = res["status"] as! Int
                if status == 200 {
                    let data = res["data"] as! [String: Any]
                    self.arabicSuperContent = data["arabic"] as! [String]
                    self.superProArabicTableView.reloadData()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.superProArabicTableHeight.constant = self.superProArabicTableView.contentSize.height
                    }
                    
                    
                    self.englishSuperContent = data["english"] as! [String]
                    self.superProEnglishTableView.reloadData()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.superProEnglishTableHeight.constant = self.superProEnglishTableView.contentSize.height
                    }
                    
                    
                } else {
                    let message = res["message"] as! String
                    CommonManager.shared.showAlert(viewCtrl: self, title: "Error", msg: message)
                }
            }
        })
    }

    @IBAction func onEnglish(_ sender: Any) {
        btnEnglish.setTitleColor(UIColor.black, for: .normal)
        selEngView.isHidden = false
        
        btnArabic.setTitleColor(UIColor.lightGray, for: .normal)
        selAraView.isHidden = true
        
        engConView.isHidden = false
        araConView.isHidden = true
    }
    
    @IBAction func onArabic(_ sender: Any) {
        btnEnglish.setTitleColor(UIColor.lightGray, for: .normal)
        selEngView.isHidden = true
        
        btnArabic.setTitleColor(UIColor.black, for: .normal)
        selAraView.isHidden = false
        
        engConView.isHidden = true
        araConView.isHidden = false
    }
    
    @IBAction func upgradePro(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PaymentViewController") as! PaymentViewController
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func upgradeSuperPro(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PaymentViewController") as! PaymentViewController
        present(vc, animated: true, completion: nil)
    }
}

extension ProChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 100 {
            return englishProContent.count
        } else if tableView.tag == 200 {
            return englishSuperContent.count
        } else if tableView.tag == 300 {
            return arabicProContent.count
        } else {
            return arabicSuperContent.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 100 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProEnglishCell", for: indexPath) as! ChatContentTableViewCell
            cell.lblContent.text = "- \(englishProContent[indexPath.row])"
            return cell
        } else if tableView.tag == 200 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SuperProEnglishCell", for: indexPath) as! ChatContentTableViewCell
            cell.lblContent.text = "- \(englishSuperContent[indexPath.row])"
            return cell
        } else if tableView.tag == 300 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProArabicCell", for: indexPath) as! ChatContentTableViewCell
            cell.lblContent.text = "- \(arabicProContent[indexPath.row])"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SuperProArabicCell", for: indexPath) as! ChatContentTableViewCell
            cell.lblContent.text = "- \(arabicSuperContent[indexPath.row])"
            return cell
        }
    }
    
    
}
