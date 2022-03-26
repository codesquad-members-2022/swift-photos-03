//
//  PhotoManager.swift
//  PhotoAlbum
//
//  Created by 김동준 on 2022/03/23.
//

import Foundation
import Photos

protocol PhotoManagable{
    func getAllImages()
}

class PhotoManager: NSObject{
    private let photoSize = CGSize(width: 100, height: 100)
    private lazy var imageManager = PHCachingImageManager()
    private let options = PHImageRequestOptions()
    private var allPhotos: PHFetchResult<PHAsset>?
    
    override init(){
        super.init()
        options.isSynchronous = true
    }
    
    private func setAssets() -> PhotoManagerModelable?{
        PHPhotoLibrary.shared().register(self)
        var assets: [PHAsset] = []
        var data: [Data] = []
        allPhotos = PHAsset.fetchAssets(with: nil)
        guard let allPhotos = allPhotos else {
            print("allphoto error")
            return nil
        }

        for i in 0 ..< allPhotos.count{
            assets.append(allPhotos.object(at: i))
        }
        for asset in assets{
            imageManager.requestImage(for: asset, targetSize: photoSize, contentMode: .aspectFill, options: options) { image, _ in
                guard let imageData = image?.pngData() else { return }
                data.append(imageData)
            }
        }
        let photoImageModel = PhotoImageModel()
        photoImageModel.setAssetsImages(imageData: data)
        return photoImageModel
    }
    
    enum Notification{
        enum Event{
            static let getPhotoData = Foundation.Notification.Name("getPhotoData")
            static let insertedPhotosFromLibrary = Foundation.Notification.Name("insertedPhotosFromLibrary")
            static let deletedPhotosFromLibrary = Foundation.Notification.Name("deletedPhotosFromLibrary")
        }
        enum Key{
            case imageData
            case removedIndex
            case insertedData
        }
    }
}

extension PhotoManager: PhotoManagable{
    func getAllImages() {
        guard let imageData = setAssets() else { return }
        NotificationCenter.default.post(name: PhotoManager.Notification.Event.getPhotoData, object: self, userInfo: [PhotoManager.Notification.Key.imageData: imageData])
    }
}

extension PhotoManager: PHPhotoLibraryChangeObserver{
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let allPhotos = self.allPhotos else { return }
        guard let detail = changeInstance.changeDetails(for: allPhotos) else { return }
        let photoImageModel = PhotoImageModel()
        if let inserted = detail.insertedIndexes{
            var data: [Data] = []
            for asset in detail.insertedObjects{
                imageManager.requestImage(for: asset, targetSize: photoSize, contentMode: .aspectFill, options: options) { image, _ in
                    guard let imageData = image?.pngData() else { return }
                    data.append(imageData)
                }
            }
            photoImageModel.setChangedIndexs(changedIndexs: inserted)
            photoImageModel.setInsertedData(insertedData: data)
            NotificationCenter.default.post(name: PhotoManager.Notification.Event.insertedPhotosFromLibrary, object: self, userInfo: [PhotoManager.Notification.Key.insertedData: photoImageModel])
        }
        
        if let removed = detail.removedIndexes{
            photoImageModel.setChangedIndexs(changedIndexs: removed)
            NotificationCenter.default.post(name: PhotoManager.Notification.Event.deletedPhotosFromLibrary, object: self, userInfo: [PhotoManager.Notification.Key.removedIndex: photoImageModel])
        }
        self.allPhotos = detail.fetchResultAfterChanges
    }
}

