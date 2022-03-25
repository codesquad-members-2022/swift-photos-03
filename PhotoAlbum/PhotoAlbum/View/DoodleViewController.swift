//
//  DoodleViewController.swift
//  PhotoAlbum
//
//  Created by Jihee hwang on 2022/03/25.
//

import UIKit

class DoodleViewController: UIViewController {

    @IBOutlet weak var doodleCollectionView: UICollectionView!
    private let doodleViewDelegate = DoodleViewDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .darkGray
        self.navigationController?.navigationBar.tintColor = .white
        doodleCollectionView.backgroundColor = .darkGray
        
        doodleCollectionView.delegate = doodleViewDelegate
        doodleCollectionView.dataSource = doodleViewDelegate
        
        let doodleNetworkModel = DoodleNetworkModel(delegate: self)
        doodleNetworkModel.decodeDoodleImage()
        
        setNavigationUI()
 
    }

    func setNavigationUI() {
        self.navigationItem.title = "Doodles"
        
        let addBarItem = UIBarButtonItem(image: nil, style: UIBarButtonItem.Style.plain, target: self, action: #selector(presentDoodle))
        
        self.navigationItem.rightBarButtonItem = addBarItem
        addBarItem.title = "Close"
        addBarItem.tintColor = .white
        
        self.navigationItem.hidesBackButton = true // 백버튼 삭제
    }
    
    @objc func presentDoodle(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension DoodleViewController: DoodleNetworkDelegate {
    
    func didMakeImageData(data: Data) {
        doodleViewDelegate.setImageData(doodleImage: data)
        DispatchQueue.main.async {
            self.doodleCollectionView.reloadData()
        }
    }
    
}
