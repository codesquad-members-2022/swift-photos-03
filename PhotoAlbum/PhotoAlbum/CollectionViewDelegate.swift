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
}

extension CollectionViewDelegate: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let r = CGFloat(colorFactory.randomR())
        let g = CGFloat(colorFactory.randomG())
        let b = CGFloat(colorFactory.randomB())
        
        cell.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: 80, height: 80)
    }
    
}
