//
//  DoodleCell.swift
//  PhotoAlbum
//
//  Created by Jihee hwang on 2022/03/25.
//

import Foundation
import UIKit

protocol CellSaveMenuDelegate{
    func tappedSavedToCell()
}

class DoodleCell: UICollectionViewCell{
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    static let cellId = "DoodleCell"
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(tapEdit))
        longPressGesture.minimumPressDuration = 0.5
        addGestureRecognizer(longPressGesture)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @objc func tapEdit(sender: UITapGestureRecognizer) {
        let saveMenuItem = UIMenuItem(title: "Save", action: #selector(saveImage))
        UIMenuController.shared.menuItems = [saveMenuItem]
        guard let superView = self.superview else { return }
        UIMenuController.shared.showMenu(from: superView, rect: self.frame)
        self.becomeFirstResponder()
    }
    
    @objc func saveImage(_ sender: UILongPressGestureRecognizer){
        guard let image = imageView.image else { return }
        NotificationCenter.default.post(name: Notification.Event.tappedSaveImage, object: self, userInfo: [Notification.Key.imageData : image])
    }
    
    func setImage(imageData: Data){
        imageView.contentMode = .scaleAspectFill
        guard let image = UIImage(data: imageData) else { return }
        imageView.image = image
    }
    
    enum Notification{
        enum Event{
            static let tappedSaveImage = Foundation.Notification.Name("tappedSaveImage")
        }
        enum Key{
            case imageData
        }
    }
}
