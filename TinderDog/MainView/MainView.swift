//
//  MainView.swift
//  TinderDog
//
//  Created by Михаил Светлов on 31.08.2022.
//

//import UIKit
//
//class MainView: UIView {
//    
//     lazy var dogImage: UITextField = {
//            let textField = UITextField()
//            textField.placeholder = "New Task"
//            textField.borderStyle = .roundedRect
//            return textField
//        }()
//    
//    lazy var dogImage: UIImageView {
//
//       let image = UIImageView(image: UIImage(named: "testPicture"))
//       image.translatesAutoresizingMaskIntoConstraints = false
//       image.contentMode = .scaleToFill
//
//       return image
//   }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        addSubview(dogImage)
//      
//        
//        NSLayoutConstraint.activate([
//            dogImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 80),
//            dogImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
//            dogImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40)
//        ])
//        
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    
//    
//}
