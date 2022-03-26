//
//  DocumentManager.swift
//  PhotoAlbum
//
//  Created by 김동준 on 2022/03/26.
//

import Foundation
import UIKit


class DocumentManager: NSObject{
    override init(){
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(saveImageToDevice), name: DoodleCell.Notification.Event.tappedSaveImage, object: nil)
    }
    
    private func saveImage(image: UIImage, name: String,
                           onSuccess: @escaping ((Bool) -> Void)) {
        
        
        let documentPath = NSSearchPathForDirectoriesInDomains(      .documentDirectory, .userDomainMask, true )[ 0 ] as NSString
        let outputPath = "\(documentPath)/1.jpeg"
        
        guard let data: Data
                = image.jpegData(compressionQuality: 1)
                ?? image.pngData() else { return }
        if let directory: NSURL =
            try? FileManager.default.url(for: .documentDirectory,
                                            in: .userDomainMask,
                                            appropriateFor: nil,
                                            create: false) as NSURL {
            do {
                try data.write(to: URL(string: outputPath)!)
                print(directory)
                onSuccess(true)
            } catch let error as NSError {
                print("Could not saveImage🥺: \(error), \(error.userInfo)")
                onSuccess(false)
            }
        }
    }
    
    @objc func saveImageToDevice(_ noti: Notification){
        guard let image = noti.userInfo?[DoodleCell.Notification.Key.imageData] as? UIImage else { return }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(imageComplete(_:didFinishSavingWithError:contextInfo:)), nil)//사진저장코드
    }
    
    @objc func imageComplete(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        //사진 저장 한후
        if let error = error {
            // we got back an error!
            print(error)
        } else {
            // save
        }
    }
}
