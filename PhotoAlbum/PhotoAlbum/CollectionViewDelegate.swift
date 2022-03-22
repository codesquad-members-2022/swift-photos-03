//
//  CollectionViewDelegate.swift
//  PhotoAlbum
//
//  Created by Jihee hwang on 2022/03/22.
//

import Foundation
import UIKit

class CollectionViewDelegate: NSObject {
    private let colorFactory: ColorRGBMakeable
    
    init(colorFactory: ColorRGBMakeable) {
        self.colorFactory = colorFactory
    }
    
    private func randomBackgroundColor() -> UIColor{
        let r = CGFloat(colorFactory.randomR())
        let g = CGFloat(colorFactory.randomG())
        let b = CGFloat(colorFactory.randomB())
        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }
}

extension CollectionViewDelegate: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let maxCellCount = 40
        return maxCellCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellId = "randomColorCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = randomBackgroundColor()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: 80, height: 80)
    }
    
}
