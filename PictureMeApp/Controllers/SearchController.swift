//
//  SearchController.swift
//  PictureMeApp
//
//  Created by Anton Veldanov on 10/3/21.
//

import UIKit

class SearchController: UITableViewController{
     //MARK: Properties
    
    
    
    
     //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.identifier)
        tableView.rowHeight = 64
        configureTableView()
    }
    
    
    
     //MARK: Helpers
    
    
    private func configureTableView(){
        view.backgroundColor = .systemPink

        
    }
    
}




 //MARK: UITableViewDataSource
extension SearchController{
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as! UserCell
        
        return cell
    }
    
    
}
