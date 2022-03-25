//
//  ImageViewCell.swift
//  PhotoAlbum
//
//  Created by 김동준 on 2022/03/22.
//

import Foundation
import UIKit

class ImageViewCell: UICollectionViewCell{
    
    @IBOutlet weak var imageView: UIImageView!
    
    static let cellId = "imageViewCell"
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setImage(imageData: Data){
        imageView.contentMode = .scaleAspectFill
        guard let image = UIImage(data: imageData) else { return }
        imageView.image = image
    }
}
