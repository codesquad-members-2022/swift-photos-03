//
//  ViewController.swift
//  PhotoAlbum
//
//  Created by 김동준 on 2022/03/21.
//

import UIKit
import Photos
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private let collectionViewDelegate = CollectionViewDelegate(colorFactory: ColorFactory())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLibraryPermission()
        
        collectionView.delegate = collectionViewDelegate
        collectionView.dataSource = collectionViewDelegate
    }
    
    private func checkLibraryPermission(){
        let photoLibraryPermission = PhotoLibraryPermission(permissionDelegate: self)
        photoLibraryPermission.checkPermission()
    }
    
}

extension ViewController: PhotoLibraryPermissionDelegate{
    func accept() {
        collectionView.reloadData()
    }
    
    func failed() {
        print("permission failed")
    }
}
