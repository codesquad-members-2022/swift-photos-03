//
//  DoodleCell.swift
//  PhotoAlbum
//
//  Created by Jihee hwang on 2022/03/25.
//

import Foundation
import UIKit

class DoodleCell: UICollectionViewCell{
    
    @IBOutlet weak var imageView: UIImageView!
    
    static let cellId = "DoodleCell"
    
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
