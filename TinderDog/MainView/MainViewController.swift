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
        
        static let fromNextButtonTopToImageBottom: CGFloat = 10
        static let nextButtonLeadingSpace: CGFloat = 130
        static let nextButtonTrailingSpace: CGFloat = -130
        static let nextButtonSize: CGFloat = 100
        
        static let fromDetailButtonTopToImageBottom: CGFloat = 25
        static let detailButtonLeadingSpace: CGFloat = 40
        static let detailButtonTrailingSpace: CGFloat = -270
        static let detailButtonSize: CGFloat = 70
        
        static let favoriteButtonTopToImageBottom: CGFloat = 25
        static let favoriteLeadingSpace: CGFloat = 270
        static let favoriteTrailingSpace: CGFloat = -40
        static let favoriteButtonSize: CGFloat = 70
    }
    
    
    
    //MARK: - Views
    
     lazy var dogImage: UIImageView = {
        
        let image = UIImageView(image: UIImage(named: "testPicture"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
         
        return image
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "arrow.right.circle.fill",  withConfiguration: UIImage.SymbolConfiguration(pointSize: Constants.nextButtonSize))
        let imagePressed = image!.withTintColor(.gray, renderingMode: .alwaysOriginal)
        
        button.tintColor = .black
        
        button.setImage(image, for: .normal)
        button.setImage(imagePressed, for: .highlighted)
        
        return button
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "heart.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: Constants.favoriteButtonSize))
        
        button.tintColor = .systemPink
        
        button.setImage(image, for: .normal)
        
        return button
    }()
    
    lazy var detailButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "list.bullet.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: Constants.detailButtonSize))
        let imagePressed = image!.withTintColor(.gray, renderingMode: .alwaysOriginal)
        
        button.tintColor = .black
        
        button.setImage(image, for: .normal)
        button.setImage(imagePressed, for: .highlighted)
        
        return button
    }()
    
    
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews(dogImage, nextButton, favoriteButton, detailButton)
        view.backgroundColor = .white
        setConstraints()
        configureNavigationBar()
    }
    
    
}


//MARK: - Private Methods

private extension MainViewController {
    
    func setupSubviews(_ subviews: UIView...) {
            subviews.forEach { subview in
                view.addSubview(subview)
            }
        }
    
//MARK: - Constraints
    
    func setConstraints() {
        dogImage.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        detailButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dogImage.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.fromImageToTop),
            dogImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.imageLeadingSpace),
            dogImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.imageTrailingSpace)
        ])
        
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: dogImage.bottomAnchor, constant: Constants.fromNextButtonTopToImageBottom),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.nextButtonLeadingSpace),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.nextButtonTrailingSpace)
        ])
        
        NSLayoutConstraint.activate([
            favoriteButton.topAnchor.constraint(equalTo: dogImage.bottomAnchor, constant: Constants.favoriteButtonTopToImageBottom),
            favoriteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.favoriteLeadingSpace),
            favoriteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.favoriteTrailingSpace)
         ])
        
        NSLayoutConstraint.activate([
            detailButton.topAnchor.constraint(equalTo: dogImage.bottomAnchor, constant: Constants.fromDetailButtonTopToImageBottom),
            detailButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.detailButtonLeadingSpace),
            detailButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.detailButtonTrailingSpace)
         ])
            
    }
    
    func configureNavigationBar() {
        navigationItem.title = "Главная"
    }
}
