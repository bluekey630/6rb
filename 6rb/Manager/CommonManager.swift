//
//  CommonManager.swift
//  6rb
//
//  Created by PCH-37 on 2019/9/15.
//  Copyright © 2019 6rb. All rights reserved.
//
import Foundation
import UIKit
class CommonManager {
    static let shared = CommonManager()
    private init() {
        print("NavManager Initialized")
    }
    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func showAlert(viewCtrl: UIViewController, title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .`default`, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        viewCtrl.present(alert, animated: true, completion: nil)
    }
    
    func secToTime(sec: Int) -> String {
        let h = sec / 3600
        let min = (sec % 3600) / 60
        let s = sec % 60
        return String(format: "%02d:%02d", min, s)
    }
    
//    func sharePlace(id: String, vc: UIViewController, state: @escaping (_ result: Bool)->()) {
//
//        let string = "Take a look at this awesone place \nhttps://qualimoments.com/share/place/\(id)"
//        let objectsToShare = [string]
//        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
//        activityVC.popoverPresentationController?.sourceView = vc.view
//        vc.present(activityVC, animated: true, completion: nil)
//    }
//
    public func getTime(timestamp: Int64) -> String {
        let date = Date(timeIntervalSince1970: Double(timestamp))
        let dateFormatter = DateFormatter()

        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "hh:mm:ss aa" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)

        return strDate
    }
//
//    public func getFullDate(timestamp: Int64) -> String {
//        let date = Date(timeIntervalSince1970: Double(timestamp)/1000)
//        let dateFormatter = DateFormatter()
//
//        dateFormatter.locale = NSLocale.current
//        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss" //Specify your format that you want
//        let strDate = dateFormatter.string(from: date)
//
//        return strDate
//    }
}

