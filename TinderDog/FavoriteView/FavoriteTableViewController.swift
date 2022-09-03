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

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
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
