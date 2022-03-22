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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = collectionViewDelegate
        collectionView.dataSource = collectionViewDelegate
    }


}

