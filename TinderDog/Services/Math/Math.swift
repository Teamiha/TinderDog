//
//  Math.swift
//  TinderDog
//
//  Created by Михаил Светлов on 15.09.2022.
//

import Foundation

class MathManager {
    
    static let shared = MathManager()
    
    func calculateNewImageIndex(lastCountPictures: Int, currentCountPictures: Int) -> [Int] {
        let lastCountPicturesArray = (0..<lastCountPictures).map{$0}
        let currentCountPicturesArray = (0..<currentCountPictures).map{$0}
        
        let result: [Int] = (lastCountPicturesArray + currentCountPicturesArray).filter {return $0 >= lastCountPictures}
        
        return result
        
    }
    
    
}
