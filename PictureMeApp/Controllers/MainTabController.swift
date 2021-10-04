//
//  MainTabController.swift
//  PictureMeApp
//
//  Created by Anton Veldanov on 10/3/21.
//

import UIKit


class MainTabController: UITabBarController{
    
     //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
    }
    
    
     //MARK: Helpers
    
    func configureViewControllers(){
        // store instance to put them into an array
//        view.backgroundColor = .white

        let feed = FeedController()
        let search = SearchController()
        let imageSelector = ImageSelectorController()
        let notifications = NotificationsController()
        let profile = ProfileController()
        
        viewControllers = [feed, search, imageSelector, notifications, profile]
    }
    
    
    
}
