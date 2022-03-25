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
    private let customSize: CGSize = CGSize(width: 100, height: 100)
    private(set) var photoData: [Data] = []
    
    init(colorFactory: ColorRGBMakeable) {
        self.colorFactory = colorFactory
        super.init()
    }
    
    func setPhotoData(photoData: [Data]){
        self.photoData = photoData
    }
    
    func deleteUpdate(deletedIndex: IndexSet){
        for index in deletedIndex{
            photoData.remove(at: index)
        }
    }
    
    func insertedUpdate(updateData: [Data]){
        for imageData in updateData{
            photoData.append(imageData)
        }
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
        return photoData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageViewCell.cellId, for: indexPath) as? ImageViewCell else {
            return UICollectionViewCell()
        }
        cell.setImage(imageData: photoData[indexPath.item])
        cell.backgroundColor = randomBackgroundColor()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return customSize
    }
}
