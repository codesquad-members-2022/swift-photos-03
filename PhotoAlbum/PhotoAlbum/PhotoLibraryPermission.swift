//
//  PhotoLibraryPermission.swift
//  PhotoAlbum
//
//  Created by 김동준 on 2022/03/22.
//

import Foundation
import Photos

protocol PhotoLibraryPermissionDelegate{
    func accept()
    func failed()
}

struct PhotoLibraryPermission{
    private let permissionDelegate: PhotoLibraryPermissionDelegate
    init(permissionDelegate: PhotoLibraryPermissionDelegate){
        self.permissionDelegate = permissionDelegate
    }
    
    func checkPermission() {
        let photoAuthStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthStatus {
        case .notDetermined:
            requestAuth()
        case .restricted:
            requestAuth()
        case .denied:
            permissionDelegate.failed()
            break
        case .authorized:
            permissionDelegate.accept()
        case .limited:
            permissionDelegate.accept()
        @unknown default:
            break
        }
    }
    
    private func requestAuth(){
        PHPhotoLibrary.requestAuthorization( { status in
            switch status{
            case .authorized:
                permissionDelegate.accept()
            case .denied:
                permissionDelegate.failed()
            case .restricted, .notDetermined:
                permissionDelegate.failed()
            default:
                break
            }
        })
    }
    
}
