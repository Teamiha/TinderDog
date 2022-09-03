//
//  RecomendationViewController.swift
//  TinderDog
//
//  Created by Михаил Светлов on 03.09.2022.
//

import UIKit

class RecomendationViewController: UIViewController {
    
    //MARK: - Constants
    
    private enum Constants {
        static let showRcomendButtonSize: CGFloat = 100
        static let clearDataButtonSize: CGFloat = 40
        
        static let fromImageToTop: CGFloat = 50
        static let imageLeadingSpace: CGFloat = 40
        static let imageTrailingSpace: CGFloat = -40
        
        static let fromLabelToImageSpacing: CGFloat = -50
        
        static let fromRecomendButtonTopToImageBottom: CGFloat = 20
        static let RecomendButtonLeadingSpace: CGFloat = 130
        static let RecomendButtonTrailingSpace: CGFloat = -130
        
        static let fromClearDataButtonTopToImageBottom: CGFloat = 25
        static let ClearDataButtonLeadingSpace: CGFloat = 40
        static let ClearDataButtonTrailingSpace: CGFloat = -270
    }
    
    //MARK: - Views
    
    lazy var dogImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "testPicture"))
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    lazy var showRecomendButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "wand.and.rays",  withConfiguration: UIImage.SymbolConfiguration(pointSize: Constants.showRcomendButtonSize))
        let imagePressed = image!.withTintColor(.gray, renderingMode: .alwaysOriginal)
        
        button.tintColor = .black
        
        button.setImage(image, for: .normal)
        button.setImage(imagePressed, for: .highlighted)
        
        return button
    }()
    
    lazy var labelRecommendBreeds: UILabel = {
        let label = UILabel()
        label.text = "Название породы"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30)
        return label
    }()
    
    lazy var clearDataButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "trash.fill",  withConfiguration: UIImage.SymbolConfiguration(pointSize: Constants.clearDataButtonSize))
        let imagePressed = image!.withTintColor(.gray, renderingMode: .alwaysOriginal)
        
        button.tintColor = .red
        
        button.setImage(image, for: .normal)
        button.setImage(imagePressed, for: .highlighted)
        
        return button
    }()
    
    
    
    

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews(dogImage, clearDataButton, labelRecommendBreeds, showRecomendButton)
        setConstraints()

        
    }
}

private extension RecomendationViewController{
    
    func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    //MARK: - Constraints
    
    func setConstraints() {
        dogImage.translatesAutoresizingMaskIntoConstraints = false
        showRecomendButton.translatesAutoresizingMaskIntoConstraints = false
        clearDataButton.translatesAutoresizingMaskIntoConstraints = false
        labelRecommendBreeds.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dogImage.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.fromImageToTop),
            dogImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.imageLeadingSpace),
            dogImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.imageTrailingSpace)
        ])
        
        NSLayoutConstraint.activate([
            labelRecommendBreeds.topAnchor.constraint(equalTo: dogImage.bottomAnchor, constant: Constants.fromLabelToImageSpacing),
            labelRecommendBreeds.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            labelRecommendBreeds.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            showRecomendButton.topAnchor.constraint(equalTo: dogImage.bottomAnchor, constant: Constants.fromRecomendButtonTopToImageBottom),
            showRecomendButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.RecomendButtonLeadingSpace),
            showRecomendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.RecomendButtonTrailingSpace)
        ])
        
        NSLayoutConstraint.activate([
            clearDataButton.topAnchor.constraint(equalTo: dogImage.bottomAnchor, constant: Constants.fromClearDataButtonTopToImageBottom),
            clearDataButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.ClearDataButtonLeadingSpace),
            clearDataButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.ClearDataButtonTrailingSpace)
        ])
    }
    
}
