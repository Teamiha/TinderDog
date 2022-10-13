//
//  TapBarModel.swift
//  TinderDog
//
//  Created by Михаил Светлов on 31.08.2022.
//

import Foundation
import UIKit

enum TabBarModel {
    case main
    case favorite
    case recomendation

    var title: String {
        switch self {
        case .main:
            return "Main"
        case .favorite:
            return "Favorites"
        case .recomendation:
            return "Recommendation"
        }
    }

    var image: UIImage? {
        switch self {
        case .main:
            return UIImage(systemName: "circle")
        case .favorite:
            return UIImage(systemName: "heart")
        case .recomendation:
            return UIImage(systemName: "wand.and.stars")
        }
    }

    var selectedImage: UIImage? {
        return image
    }
    
}
