//
//  NavigationController.swift
//  PhotoAlbum
//
//  Created by 김동준 on 2022/03/22.
//

import Foundation
import UIKit

class NavigationController: UINavigationController{
 
    private lazy var viewController = storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let viewController = viewController else { return }
        viewController.setPhotoManager(photoManager: PhotoManager())

        viewControllers.append(viewController)
    }
    
}
