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

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFavoriteData()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(item.count)
        print(item)
        print(item[0].imageURL)
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
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let pic = testPic
        var content = cell.defaultContentConfiguration()
        content.text = "test"
        content.image = pic
        cell.contentConfiguration = content
        cell.selectionStyle = .none
        return cell
    }
}
