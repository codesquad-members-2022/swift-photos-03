//
//  PhotoLibraryPermission.swift
//  PhotoAlbum
//
//  Created by 김동준 on 2022/03/22.
//

import Foundation
import Photos

protocol PhotoLibraryPermissionDelegate{
    func didAccepPhotoLibraryPermission()
    func didFailPhotoLibraryPermission()
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
            permissionDelegate.didFailPhotoLibraryPermission()
            break
        case .authorized:
            permissionDelegate.didAccepPhotoLibraryPermission()
        case .limited:
            permissionDelegate.didAccepPhotoLibraryPermission()
        @unknown default:
            break
        }
    }
    
    private func requestAuth(){
        PHPhotoLibrary.requestAuthorization( { status in
            switch status{
            case .authorized:
                permissionDelegate.didAccepPhotoLibraryPermission()
            case .denied:
                permissionDelegate.didFailPhotoLibraryPermission()
            case .restricted, .notDetermined:
                permissionDelegate.didFailPhotoLibraryPermission()
            default:
                break
            }
        })
    }
    
}
