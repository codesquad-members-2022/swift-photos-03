//
//  ImageViewCell.swift
//  PhotoAlbum
//
//  Created by 김동준 on 2022/03/22.
//

import Foundation
import UIKit

class ImageViewCell: UICollectionViewCell{
    lazy var imageView = UIImageView()
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.contentMode = .scaleAspectFill
        contentView.addSubview(imageView)
    }
    
    func setImageViewSize(size: CGSize){
        imageView.frame.size = size
    }
}
