//
//  FavoriteTableViewController.swift
//  TinderDog
//
//  Created by Михаил Светлов on 02.09.2022.
//

import UIKit

class FavoriteTableViewController: UITableViewController {
    
    //MARK: - Views
    
    private let cellID = "ID"
    private var favoritePictureURL: [Picture] = []
    private var downloadImage: [UIImage] = []
    private var lastCountFavoritePicture: Int = 0
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFavoriteImageURL()
        uploadImage()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        configureNavigationBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavoriteImageURL()
        updateImage()
    }
    
    //MARK: - StorageManager
    
    func loadFavoriteImageURL() {
        StorageManager.shared.fetchFavoriteImageData() { [weak self] result in
            switch result {
            case .success(let pictures):
                self?.favoritePictureURL = pictures.map { pictureModel in
                    Picture(
                        message: pictureModel.imageURL!,
                        status: "Ok"
                    )
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func uploadImage() {
        lastCountFavoritePicture = favoritePictureURL.count
        for i in 0..<favoritePictureURL.count  {
            let url = URL(string: favoritePictureURL[i].message)
            
            URLSession.shared.dataTask(with: url!) { data, response, error in
                guard let data = data, let _ = response else {
                    print(error?.localizedDescription ?? "No error description")
                    return
                }
                guard let image = UIImage(data: data) else { return }
                
                
                DispatchQueue.main.async {
                    self.downloadImage.append(image)
                    self.tableView.reloadData()
                }
            }.resume()
        }
    }
        
        
    func updateImage() {
        if lastCountFavoritePicture >= favoritePictureURL.count {
            print("")
            lastCountFavoritePicture = favoritePictureURL.count
            return
            
        } else if lastCountFavoritePicture < favoritePictureURL.count {
            
            let newIndex = MathManager.shared.calculateNewImageIndex(lastCountPictures: lastCountFavoritePicture, currentCountPictures: favoritePictureURL.count)
            
            lastCountFavoritePicture = favoritePictureURL.count
            
            for i in newIndex {
                
                let url = URL(string: favoritePictureURL[i].message)
                
                URLSession.shared.dataTask(with: url!) { data, response, error in
                    guard let data = data, let _ = response else {
                        print(error?.localizedDescription ?? "No error description")
                        return
                    }
                    
                    guard let image = UIImage(data: data) else { return }
                    
                    DispatchQueue.main.async {
                        self.downloadImage.append(image)
                        self.tableView.reloadData()
                    }
                }.resume()
            }
        }
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let number = downloadImage.count
        return number
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
  
        let picture =  downloadImage[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.imageProperties.reservedLayoutSize = .init(width: 350, height: 300)
        
        content.image = picture
        
        cell.layer.borderWidth = 10
        cell.layer.borderColor = UIColor.systemBackground.cgColor
        cell.contentConfiguration = content
        cell.selectionStyle = .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alert = UIAlertController(title: "ALERT", message: "Are you sure you want to remove this photo from your favorites?", preferredStyle: .alert)
        
        let deleteAction = UIAlertAction(title: "DELETE", style: .destructive) { _ in
            let indexPathForCoreDataDelete = indexPath[1]
            
            self.favoritePictureURL.remove(at: indexPath.row)
            self.downloadImage.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            
            StorageManager.shared.deletePictureFromFavorite(numberOfRow: indexPathForCoreDataDelete)
        }
        
        let abortAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(deleteAction)
        alert.addAction(abortAction)
        present(alert, animated: true)
    }
    
    //MARK: - Navigation Bar
    
    func configureNavigationBar() {
        navigationItem.title = "Favorites"
        
    }
}
