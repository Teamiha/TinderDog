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
    private var item: [FavoritePictures] = []
    private var items: [Picture] = []

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPosts()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(items[0])
    }
    
    //MARK: - StorageManager
    
    func loadFavoriteData() {
        StorageManager.shared.fetchData { result in
            switch result {
            case .success(let items):
                self.item = items
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadPosts() {
        StorageManager.shared.fetchData() { [weak self] result in
            switch result {
            case .success(let pictures):
                self?.items = pictures.map { pictureModel in
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
        let number = items.count
        return number
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
       
        let item = items[indexPath.row]
        
        let data = try? Data(contentsOf: URL(string: item.message) ?? URL(string: "https://images.dog.ceo/breeds/pitbull/20190801_154956.jpg")!)
        
        let pic = UIImage(data: data!)
        var content = cell.defaultContentConfiguration()
//        content.text = "test"
        content.image = pic
        cell.contentConfiguration = content
        cell.selectionStyle = .none
        return cell
    }
}
