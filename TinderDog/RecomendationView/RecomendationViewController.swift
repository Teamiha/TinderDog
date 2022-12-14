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
        static let showRecomendButtonSize: CGFloat = 100
        static let clearDataButtonSize: CGFloat = 40
        
        static let fromImageToTop: CGFloat = 110
        static let imageLeadingSpace: CGFloat = 40
        static let imageTrailingSpace: CGFloat = -40
        static let fromImageToBottom: CGFloat = -350
        
        static let fromLabelToImageSpacing: CGFloat = 17
        
        static let fromRecomendButtonTopToImageBottom: CGFloat = 90
        static let RecomendButtonLeadingSpace: CGFloat = 130
        static let RecomendButtonTrailingSpace: CGFloat = -130
        
        static let fromClearDataButtonTopToImageBottom: CGFloat = 90
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
        let image = UIImage(systemName: "wand.and.rays",  withConfiguration: UIImage.SymbolConfiguration(pointSize: Constants.showRecomendButtonSize))
        let imagePressed = image!.withTintColor(.gray, renderingMode: .alwaysOriginal)
        
        button.tintColor = .black
        
        button.addTarget(self, action: #selector(recomendationButtonTaped), for: .touchUpInside)
        
        button.setImage(image, for: .normal)
        button.setImage(imagePressed, for: .highlighted)
        
        return button
    }()
    
    lazy var labelRecommendBreeds: UILabel = {
        let label = UILabel()
        var breedName = ""
        label.numberOfLines = 2
        label.text = "Click on the button below to find out your favorite breed"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30)
        return label
    }()
    
    lazy var clearDataButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "trash.fill",  withConfiguration: UIImage.SymbolConfiguration(pointSize: Constants.clearDataButtonSize))
        let imagePressed = image!.withTintColor(.gray, renderingMode: .alwaysOriginal)
        
        button.tintColor = .red
        
        button.addTarget(self, action: #selector(clearDataButtonTaped), for: .touchUpInside)
        
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
        configureNavigationBar()
    }
}

private extension RecomendationViewController{
    
    @objc func recomendationButtonTaped() {
        let favoriteBreed = StorageManager.shared.calculateFavoriteBreed()
        if favoriteBreed == "Error" {
            labelRecommendBreeds.text = """
            Not enough data
            """
        } else {
            let favoriteBreedText = favoriteBreed?.capitalized
            labelRecommendBreeds.text = """
        Your favorite breed:
        \(favoriteBreedText ?? "error")
        """
            
            NetworkManager.shared.fetchFavoriteBreedImage(breed: favoriteBreed!) { result in
                switch result {
                case .success(let imageURL):
                    
                    DispatchQueue.global().async {
                        let data = try? Data(contentsOf: URL(string: imageURL) ?? URL(string: "https://images.dog.ceo/breeds/pitbull/20190801_154956.jpg")!)
                        DispatchQueue.main.async {
                            self.dogImage.image = UIImage(data: data!)
                        }
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    @objc func clearDataButtonTaped() {
        
        let alert = UIAlertController(title: "ALERT", message: "Are you sure you want to clear the recommendation database?", preferredStyle: .alert)
        
        let deleteAction = UIAlertAction(title: "DELETE", style: .destructive) { _ in
            
            StorageManager.shared.clearBreedData()
        }
        
        let abortAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(deleteAction)
        alert.addAction(abortAction)
        present(alert, animated: true)
    }
    
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
            dogImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.imageTrailingSpace),
            dogImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.fromImageToBottom) 
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
    
    //MARK: - Navigation Bar
    
    func configureNavigationBar() {
        navigationItem.title = "Recommendation"
        
    }
    
}
