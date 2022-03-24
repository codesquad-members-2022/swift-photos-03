//
//  PhotoManager.swift
//  PhotoAlbum
//
//  Created by 김동준 on 2022/03/23.
//

import Foundation
import Photos

protocol PhotoManagerDelegate{
    func sendAssets(allPhotos: PHFetchResult<PHAsset>)
    func sendPhotoChange(change: PHFetchResult<PHAsset>)
}

class PhotoManager: NSObject{
    private let allPhotos: PHFetchResult<PHAsset>?
    private var assets: [PHAsset] = []
    private var delegate: PhotoManagerDelegate?
    init(delegate: PhotoManagerDelegate){
        allPhotos = PHAsset.fetchAssets(with: nil)
        super.init()
        self.delegate = delegate
        self.setAssets()
        PHPhotoLibrary.shared().register(self)
    }
    
    private func setAssets(){
        guard let allPhotos = self.allPhotos else { return }
        for i in 0 ..< allPhotos.count{
            assets.append(allPhotos.object(at: i))
        }
        delegate?.sendAssets(allPhotos: allPhotos)
    }
}

extension PhotoManager: PHPhotoLibraryChangeObserver{
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let allPhotos = self.allPhotos else { return }
        guard var detail = changeInstance.changeDetails(for: allPhotos) else { return }
        let afterChanges = detail.fetchResultAfterChanges
        delegate?.sendPhotoChange(change: afterChanges)
    }
}
