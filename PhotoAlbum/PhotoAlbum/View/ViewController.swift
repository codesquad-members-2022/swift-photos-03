//
//  ViewController.swift
//  PhotoAlbum
//
//  Created by 김동준 on 2022/03/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private let collectionViewDelegate = CollectionViewDelegate(colorFactory: ColorFactory())
    private var photoManager: PhotoManagable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(setPhotoToCollectionView), name: PhotoManager.Notification.Event.getPhotoData, object: photoManager)
        NotificationCenter.default.addObserver(self, selector: #selector(deletedPhotoToCollectionView), name: PhotoManager.Notification.Event.deletedPhotosFromLibrary, object: photoManager)
        NotificationCenter.default.addObserver(self, selector: #selector(insertedPhotoToCollectionView), name: PhotoManager.Notification.Event.insertedPhotosFromLibrary, object: photoManager)
        
        collectionView.delegate = collectionViewDelegate
        collectionView.dataSource = collectionViewDelegate
        checkLibraryPermission()

    }
    
    func setNavigationUI() {
        self.navigationItem.title = "Photos"
        let addBarItem = UIBarButtonItem(image: nil, style: UIBarButtonItem.Style.plain, target: self, action: #selector(presentDoodle))
        
        self.navigationItem.rightBarButtonItem = addBarItem
        addBarItem.title = "➕"
        addBarItem.tintColor = .black
    }
    
    @objc func presentDoodle(_ sender: Any) {
        guard let doodleViewController = storyboard?.instantiateViewController(withIdentifier: "DoodleViewController") as? DoodleViewController
        else { return }
        
        self.navigationController?.pushViewController(doodleViewController, animated: true)
    }
    
    
    func setPhotoManager(photoManager: PhotoManagable){
        self.photoManager = photoManager
    }
    
    private func checkLibraryPermission(){
        let photoLibraryPermission = PhotoLibraryPermission(permissionDelegate: self)
        photoLibraryPermission.checkPermission()
    }
    
    @objc func setPhotoToCollectionView(_ noti: Notification){
        guard let photoManagerModel = noti.userInfo?[PhotoManager.Notification.Key.imageData] as? PhotoManagerModelable else { return }
        collectionViewDelegate.setPhotoData(photoData: photoManagerModel.getAssetsImage())
    }
    
    @objc func deletedPhotoToCollectionView(_ noti: Notification){
        guard let photoManagerModel = noti.userInfo?[PhotoManager.Notification.Key.removedIndex] as? PhotoManagerModelable else { return }
        let deleteIndexs = photoManagerModel.getChangedIndexs()
        collectionViewDelegate.deleteUpdate(deletedIndex: deleteIndexs)
        DispatchQueue.main.async {
            for index in deleteIndexs{
                self.collectionView.reloadItems(at: [IndexPath(row: 0, section: index)])
            }
        }
    }
    
    @objc func insertedPhotoToCollectionView(_ noti: Notification){
        guard let photoManagerModel = noti.userInfo?[PhotoManager.Notification.Key.insertedData] as? PhotoManagerModelable else { return }
        let insertedData = photoManagerModel.getInsertedData()
        let insertedIndex = photoManagerModel.getChangedIndexs()
        collectionViewDelegate.insertedUpdate(updateData: insertedData)
        DispatchQueue.main.async {
            for index in insertedIndex{
                self.collectionView.reloadItems(at: [IndexPath(row: 0, section: index)])
            }
        }
    }
    
    func setAuthAlertAction() {
            let authAlert = UIAlertController(title: "사진 앨범 권한 요청", message: "사진첩 권한을 허용해야만 기능을 사용하실 수 있습니다.", preferredStyle: .alert)

            let getAuthAction = UIAlertAction(title: "설정화면에서 권한허용하기.", style: .default, handler: { (UIAlertAction) in
                if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
                }
            })

            authAlert.addAction(getAuthAction)
            self.present(authAlert, animated: true, completion: nil)
        }
}

extension ViewController: PhotoLibraryPermissionDelegate{
    func didAccepPhotoLibraryPermission() {
        photoManager?.getAllImages()
    }
    
    func didFailPhotoLibraryPermission() {
        setAuthAlertAction()
    }
}
