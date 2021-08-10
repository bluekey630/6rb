//
//  EditPlaylistViewController.swift
//  6rb
//
//  Created by Admin on 10/28/19.
//  Copyright © 2019 6rb. All rights reserved.
//

import UIKit
import CropViewController

protocol PlaylistUpdatedDelegate {
    func updatedPlaylist()
}

class EditPlaylistViewController: UIViewController {

    @IBOutlet weak var imgThumbnail: UIImageView!
    @IBOutlet weak var btnThumbEdit: UIButton!
    @IBOutlet weak var nameConView: UIView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var lblLeft: UILabel!
    
    
    let imagePickerController = UIImagePickerController()
    var selectedImgData: Data!
    var delegate: PlaylistUpdatedDelegate!
    
    var playlist:  PlaylistModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    
    func configureView() {
        btnThumbEdit.layer.borderColor = UIColor.lightGray.cgColor
        nameConView.layer.borderColor = UIColor.lightGray.cgColor
        imgThumbnail.layer.borderWidth = 0.5
        imgThumbnail.layer.borderColor = UIColor.lightGray.cgColor
        
        txtName.text = playlist.title
        imgThumbnail.kf.setImage(with: URL(string: playlist.thumbnail_url)!, placeholder: UIImage(named: "picture_placeholder"))
    }
    
    @IBAction func onEdit(_ sender: Any) {
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = ["public.image"]
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func onAdd(_ sender: Any) {
        let title = txtName.text!
        if title.count == 0 {
            CommonManager.shared.showAlert(viewCtrl: self, title: "Warning", msg: "Please enter playlist name.")
            return
        }
        
//        if selectedImgData == nil {
//            CommonManager.shared.showAlert(viewCtrl: self, title: "Warning", msg: "Please playlist thumbnail.")
//            return
//        }
        
        let filename = getDocumentsDirectory().appendingPathComponent("avatar.jpg")
        do {
            if selectedImgData != nil {
                try selectedImgData.write(to: filename)
            }
            
        } catch {
            print(error.localizedDescription)
        }
        
        let url = selectedImgData == nil ? nil : filename
        
        ProgressHud.shared.show(view: view, msg: "")
        APIManager.shared.updatePlaylist(id: playlist.id, filename: url, title: title, completion: {
            error, response in
            ProgressHud.shared.dismiss()
            
            self.dismiss(animated: true, completion: {
                self.delegate.updatedPlaylist()
            })
        })
//        dismiss(animated: true, completion: nil)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    @IBAction func onClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension EditPlaylistViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.originalImage] as! UIImage
        imagePickerController.dismiss(animated: true, completion: nil)
        
        let cropViewController = CropViewController(image: image)
        cropViewController.delegate = self
        present(cropViewController, animated: true, completion: nil)
    }
}

extension EditPlaylistViewController: CropViewControllerDelegate {
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
//        cropViewController.dismiss(animated: true, completion: nil)
        let viewController = cropViewController.children.first!
        viewController.modalTransitionStyle = .coverVertical
        viewController.presentingViewController?.dismiss(animated: true, completion: nil)
        //        img = image
        let img = image.resizeImage(targetSize: CGSize(width: 150, height: 150))
        selectedImgData = img.jpegData(compressionQuality: 1)
//        btnAvatar.setBackgroundImage(image, for: .normal)
        imgThumbnail.image = img
    }
    
    func cropViewController(_ cropViewController: CropViewController, didFinishCancelled cancelled: Bool) {
//        cropViewController.dismiss(animated: true, completion: nil)
        let viewController = cropViewController.children.first!
        viewController.modalTransitionStyle = .coverVertical
        viewController.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
