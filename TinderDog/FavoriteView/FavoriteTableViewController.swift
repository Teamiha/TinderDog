//
//  FavoriteTableViewController.swift
//  TinderDog
//
//  Created by Михаил Светлов on 02.09.2022.
//

import UIKit

class FavoriteTableViewController: UITableViewController {
    
    //MARK: - Views
    
    private var testPic = UIImage(named: "testPicture")
    private let cellID = "ID"
    private var favoritePicture: [Picture] = []

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPosts()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadPosts()
        tableView.reloadData()
    }
    
    //MARK: - StorageManager
    
    func loadPosts() {
        StorageManager.shared.fetchFavoriteImageData() { [weak self] result in
            switch result {
            case .success(let pictures):
                self?.favoritePicture = pictures.map { pictureModel in
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
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let number = favoritePicture.count
        return number
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
       
        let item = favoritePicture[indexPath.row]
        
        let data = try? Data(contentsOf: URL(string: item.message) ?? URL(string: "https://images.dog.ceo/breeds/pitbull/20190801_154956.jpg")!)
        
        let picture = UIImage(data: data!)
        
        var content = cell.defaultContentConfiguration()
        content.imageProperties.reservedLayoutSize = .init(width: 350, height: 300)
        content.image = picture
        
        cell.contentConfiguration = content
        cell.selectionStyle = .none
        
        return cell
    }
}
