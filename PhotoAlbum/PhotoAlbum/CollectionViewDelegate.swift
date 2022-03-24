//
//  CollectionViewDelegate.swift
//  PhotoAlbum
//
//  Created by Jihee hwang on 2022/03/22.
//

import Foundation
import UIKit
import Photos

class CollectionViewDelegate: NSObject {
    private let colorFactory: ColorRGBMakeable
    private lazy var imageManager = PHCachingImageManager()
    private var photoManager: PhotoManager?
    private let customSize: CGSize = CGSize(width: 100, height: 100)
    
    private var collectionView: UICollectionView?
    
    private var photoResult: PHFetchResult<PHAsset>? {
        didSet{
            photoAssets = []
            guard let photosCount = photoResult?.count else { return }
            for i in 0 ..< photosCount{
                guard let photoResult = photoResult else {
                    return
                }
                photoAssets.append(photoResult.object(at: i))
            }
        }
    }
    private var photoAssets: [PHAsset] = []
    private let options = PHImageRequestOptions()
    
    init(colorFactory: ColorRGBMakeable) {
        self.colorFactory = colorFactory
        super.init()
        photoManager = PhotoManager(delegate: self)
        options.isSynchronous = true
    }
    
    func setImageManager(imageManager: PHCachingImageManager){
        self.imageManager = imageManager
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
        return photoAssets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellId = "imageViewCell"
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? ImageViewCell else {
            return UICollectionViewCell()
        }
        cell.awakeFromNib()
        imageManager.requestImage(for: photoAssets[indexPath.item], targetSize: customSize, contentMode: .aspectFit, options: options) { image, _ in
            cell.imageView.image = image
        }
        cell.setImageViewSize(size: customSize)
        cell.backgroundColor = randomBackgroundColor()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        self.collectionView = collectionView
        return customSize
    }
}

extension CollectionViewDelegate: PhotoManagerDelegate{
    func sendPhotoChange(change: PHFetchResult<PHAsset>) {
        self.photoResult = change
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    func sendAssets(allPhotos: PHFetchResult<PHAsset>) {
        self.photoResult = allPhotos
        imageManager.startCachingImages(for: photoAssets, targetSize: customSize, contentMode: .aspectFill, options: options)
    }
}
