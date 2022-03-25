//
//  DoodleViewDelegate.swift
//  PhotoAlbum
//
//  Created by Jihee hwang on 2022/03/25.
//

import Foundation
import UIKit

protocol DoodleCellDelegate {
    func cellLongPressedGesture()
}

class DoodleViewDelegate: NSObject {
    
    private let doodleCustomSize: CGSize = CGSize(width: 110, height: 50)
    private var doodleImages: [Data] = []
    private var delegate: DoodleNetworkDelegate?
    
    override init() {
        super.init()
    }
    
    func setDelegate(delegate: DoodleNetworkDelegate) {
        self.delegate = delegate
    }
    
    func setImageData(doodleImage: Data) {
        DispatchQueue.main.async {
            self.doodleImages.append(doodleImage)
        }
    }

}

extension DoodleViewDelegate: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return doodleImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DoodleCell.cellId, for: indexPath) as? DoodleCell else {
            return UICollectionViewCell()
        }
        
        cell.setImage(imageData: self.doodleImages[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return doodleCustomSize
    }
    
}
