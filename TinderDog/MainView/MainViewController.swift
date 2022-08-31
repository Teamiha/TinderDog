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
    
     lazy var dogImage: UIImageView = {
        
        let image = UIImageView(image: UIImage(named: "testPicture"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
         
        return image
    }()
    
    lazy var nextButton: UIButton = {
        let image = UIImage(systemName: "arrow.right.circle.fill")
       
        let button = UIButton()
//        button.setTitle("Test", for: .normal)
        button.setImage(UIImage(systemName: "arrow.right.circle.fill",  withConfiguration: UIImage.SymbolConfiguration(pointSize: 100)) , for: .normal)
//        button.sizeThatFits(CGSize(width: 100, height: 100))
        
        return button
    }()
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(dogImage)
        view.addSubview(nextButton)
        view.backgroundColor = .white
        setConstraints()
        configureNavigationBar()
    }
    
    
}


//MARK: - Private Methods

private extension MainViewController {
    
//MARK: - Constraints
    
    func setConstraints() {
        dogImage.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dogImage.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.fromImageToTop),
            dogImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.imageLeadingSpace),
            dogImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.imageTrailingSpace)
        ])
        
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: dogImage.bottomAnchor, constant: 50),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.imageLeadingSpace),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.imageTrailingSpace)
        ])
    }
    
    func configureNavigationBar() {
        navigationItem.title = "Главная"
    }
}
