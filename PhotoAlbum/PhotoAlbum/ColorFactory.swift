//
//  CellModelFactory.swift
//  PhotoAlbum
//
//  Created by Jihee hwang on 2022/03/22.
//

import Foundation

protocol ColorRGBMakeable {
    func randomR() -> Double
    func randomG() -> Double
    func randomB() -> Double
}

struct ColorFactory {

    private func randomRGBDouble() -> Double {
        let rgbMaxValue = 255
        return Double(Int.random(in: 1 ..< rgbMaxValue)) / 255
    }
    
}

extension ColorFactory: ColorRGBMakeable {
    func randomR() -> Double {
        return randomRGBDouble()
    }
    
    func randomG() -> Double {
        return randomRGBDouble()
    }
    
    func randomB() -> Double {
        return randomRGBDouble()
    }
}
