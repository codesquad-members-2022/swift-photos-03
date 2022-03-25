//
//  PhotoManagerModel.swift
//  PhotoAlbum
//
//  Created by 김동준 on 2022/03/24.
//

import Foundation

protocol PhotoManagerModelable{
    func getAssetsImage() -> [Data]
    func getChangedIndexs() -> IndexSet
    func getInsertedData() -> [Data]
}

class PhotoImageModel{
    private(set) var imageData: [Data] = []
    private(set) var changedIndexs: IndexSet = []
    private(set) var insertedData: [Data] = []
    
    func setAssetsImages(imageData: [Data]){
        self.imageData = imageData
    }
    
    func setChangedIndexs(changedIndexs: IndexSet){
        self.changedIndexs = changedIndexs
    }
    
    func setInsertedData(insertedData: [Data]){
        self.insertedData = insertedData
    }
}

extension PhotoImageModel: PhotoManagerModelable{
    func getAssetsImage() -> [Data] {
        return imageData
    }
    
    func getChangedIndexs() -> IndexSet{
        return changedIndexs
    }
    
    func getInsertedData() -> [Data]{
        return insertedData
    }
}
