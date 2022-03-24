//
//  NavigationController.swift
//  PhotoAlbum
//
//  Created by 김동준 on 2022/03/22.
//

import Foundation
import UIKit

class NavigationController: UINavigationController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.topItem?.title = "photos"
        
    }
    
}
