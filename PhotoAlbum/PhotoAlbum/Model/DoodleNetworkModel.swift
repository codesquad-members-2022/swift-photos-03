//
//  DoodleNetworkModel.swift
//  PhotoAlbum
//
//  Created by Jihee hwang on 2022/03/25.
//

import Foundation
import UIKit

protocol DoodleNetworkDelegate {
    func didMakeImageData(data: Data)
}

class DoodleNetworkModel: NSObject {
    private var doodles: [Doodle] = []
    private let jsonDecoder = JSONDecoder()
    private let delegate: DoodleNetworkDelegate
    
    func decodeDoodleImage() {
        guard let doodleData: NSDataAsset = NSDataAsset(name: "doodle") else { return }
        
        do {
            self.doodles = try jsonDecoder.decode([Doodle].self, from: doodleData.data)
        } catch {
            print(error.localizedDescription)
        }

        for doodle in doodles {
            let dataTesk = URLSession(configuration: URLSessionConfiguration.default)
                .dataTask(with: doodle.image) { (data, response, error) in
                    guard let data = data else { return }
                    
                    self.delegate.didMakeImageData(data: data)
                }
            dataTesk.resume()
        }
       
    }
    
    init(delegate: DoodleNetworkDelegate) {
        self.delegate = delegate
    }
    
}
