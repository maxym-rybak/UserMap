//
//  UserListTableViewController.swift
//  UserMap
//
//  Created by Max Rybak on 11/15/18.
//  Copyright © 2018 Max Rybak. All rights reserved.
//

import UIKit

class UserListTableViewController: UITableViewController {
    
    var presenter: UserListPresenterProtocol?
    var usernames: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserListRouter.configure(userListViewRef: self)
        presenter?.loadUsersAttemp()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usernames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        cell.textLabel?.text = usernames[indexPath.row]
        return cell
    }
    
}

extension UserListTableViewController: UserListViewProtocol {
    
    func showUsers(usernames: inout [String]) {
        self.usernames = usernames
        self.tableView.reloadData()
    }

}
