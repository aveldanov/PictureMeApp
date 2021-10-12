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
    private var filteredUsers = [User]()
    private let searchController = UISearchController(searchResultsController: nil)
    private var inSearchMode: Bool{
        
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    
    
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
        return inSearchMode ? filteredUsers.count : loadedUsers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as! UserCell
//        print(loadedUsers)
//        cell.view = loadedUsers[indexPath.row]
        
        let user = inSearchMode ? filteredUsers[indexPath.row] : loadedUsers[indexPath.row]
        cell.viewModel = UserCellViewModel(user: user)
        
        return cell
    }    
}



 //MARK: SearchController didSelectRowAt - Delegate
extension SearchController{
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("[SearchController] user \(loadedUsers[indexPath.row].username) selected")
        let user = inSearchMode ? filteredUsers[indexPath.row] : loadedUsers[indexPath.row]
        let vc = ProfileController(user: user)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

 //MARK: UISearchResultsUpdating
extension SearchController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchText = searchController.searchBar.text?.lowercased() else{
            return
        }
//        print("[SearchController] updateSearchResults tapped \(searchText) ")
        
        filteredUsers = loadedUsers.filter{$0.username.lowercased().contains(searchText) || $0.fullname.lowercased().contains(searchText)}

        self.tableView.reloadData()
    }
    
    
    
    
}
