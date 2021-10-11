//
//  SearchController.swift
//  PictureMeApp
//
//  Created by Anton Veldanov on 10/3/21.
//

import UIKit

class SearchController: UITableViewController{
     //MARK: Properties
    
    private var loadedUsers = [User]()
    
    
     //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        fetchUsersCall()
    }
    
    
    
     //MARK: API Calls
    
    func fetchUsersCall(){
        UserService.fetchUsers { users in
            //            print("[SearchController] Users\(users)")
            self.loadedUsers = users
            self.tableView.reloadData()
        }
    }
    
    
     //MARK: Helpers
    
    
    private func configureTableView(){
        view.backgroundColor = .lightGray
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.identifier)
        tableView.rowHeight = 64
    }
}




 //MARK: UITableViewDataSource
extension SearchController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loadedUsers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as! UserCell
        print(loadedUsers)
        cell.user = loadedUsers[indexPath.row]
        
        return cell
    }    
}
