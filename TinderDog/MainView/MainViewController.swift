//
//  ViewController.swift
//  TinderDog
//
//  Created by Михаил Светлов on 31.08.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - Constants
    
    private enum Constants {
        static let fromImageToTop: CGFloat = 50
        static let imageLeadingSpace: CGFloat = 40
        static let imageTrailingSpace: CGFloat = -40
    }
    
    
    
    //MARK: - Views
    
     var dogImage: UIImageView = {
        
        let image = UIImageView(image: UIImage(named: "testPicture"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
         
        return image
    }()
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(dogImage)
        view.backgroundColor = .white
        setConstraints()
        configureNavigationBar()
    }
    
    
}




private extension MainViewController {
    
    func setConstraints() {
        dogImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dogImage.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.fromImageToTop),
            dogImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.imageLeadingSpace),
            dogImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.imageTrailingSpace)
        ])
    }
    
    func configureNavigationBar() {
        navigationItem.title = "Главная"
    }
}
