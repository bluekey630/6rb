//
//  Extensions.swift
//  6rb
//
//  Created by PCH-37 on 2019/8/20.
//  Copyright © 2019 6rb. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    func scrollToBottom(){
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection:  self.numberOfSections - 1) - 1,
                section: self.numberOfSections - 1)
            self.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
}

extension UIImage {
    convenience init(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        let cgImage = image?.cgImage// else { return nil }
        self.init(cgImage: cgImage!)
    }
    
    func resizeImage(targetSize: CGSize) -> UIImage {
        let width = targetSize.width
        let height = targetSize.height
        
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        let newSize = CGSize(width: width, height: height)
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
