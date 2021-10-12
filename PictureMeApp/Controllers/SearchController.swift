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
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    
    
     //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        fetchUsersCall()
        configureSearchController()
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
    
    
    private func configureSearchController(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search profile"
        navigationItem.searchController = searchController
        definesPresentationContext = false
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
//        cell.view = loadedUsers[indexPath.row]
        
        cell.viewModel = UserCellViewModel(user: loadedUsers[indexPath.row])
        
        return cell
    }    
}



 //MARK: SearchController didSelectRowAt - Delegate
extension SearchController{
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("[SearchController] user \(loadedUsers[indexPath.row].username) selected")
        let vc = ProfileController(user: loadedUsers[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension SearchController: UISearchResultsUpdating{
    
    
    
}
