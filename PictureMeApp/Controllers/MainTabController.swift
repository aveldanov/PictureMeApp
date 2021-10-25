//
//  MainTabController.swift
//  PictureMeApp
//
//  Created by Anton Veldanov on 10/3/21.
//

import UIKit
import Firebase
import YPImagePicker

class MainTabController: UITabBarController{
    
     //MARK: Properties
    
    private var user: User?{
        didSet{
            guard let user = user else {return}
            configureViewControllers(withUser: user)
        }
    }
    
    
    
     //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserIsLoggedIn()
        fetchUserCall()
    }
    
    
     //MARK: API
    
    private func checkIfUserIsLoggedIn(){
        if Auth.auth().currentUser == nil{
            DispatchQueue.main.async {
                let vc = LoginController()
                vc.delegate = self
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        }
    }
    
    
    func fetchUserCall(){
        UserService.fetchUser { user in
            self.user = user
        }
    }

    
    
     //MARK: Helpers
    
    func configureViewControllers(withUser user: User){
        // store instance to put them into an array
//        view.backgroundColor = .white

        let feedLayout = UICollectionViewFlowLayout()
        let feed = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: FeedController(collectionViewLayout: feedLayout))
        
        let search = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"), rootViewController: SearchController())
        let imageSelector = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"), rootViewController: ImageSelectorController())
        let notifications = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"), rootViewController: NotificationsController())
        
        
//        let profileLayout = UICollectionViewFlowLayout()
        
        let profileController = ProfileController(user: user)
        let profile = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected"), rootViewController: profileController)
        
        viewControllers = [feed, search, imageSelector, notifications, profile]
        tabBar.tintColor = .black
        
        
        self.delegate = self
    }
    
    
    
    func templateNavigationController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController{
        
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.selectedImage = selectedImage
        nav.tabBarItem.image = unselectedImage
        nav.navigationBar.tintColor = .black
        
        return nav
    }
    
    func didFinishPickingMedia(_ picker: YPImagePicker){
        picker.didFinishPicking { items, cancelled in
            picker.dismiss(animated: false) {
                guard let selectedImage = items.singlePhoto?.image else{
                    return
                }
//                print("didFinishPickingMedia")
                
//                let vc = UploadPostController(selectedImage: selectedImage)
                
                let vc = UploadPostController()
                vc.selectedImage = selectedImage
                vc.currentUser = self.user
                vc.delegate = self
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: false, completion: nil)
            }
        }
    }
    
    
}



 //MARK: AuthProtocolDelegate

extension MainTabController: AuthProtocolDelegate{
    func authDidComplete() {
        print("[MainTabController] auth did complete. Fetch user and update here")
        fetchUserCall()
        self.dismiss(animated: true, completion: nil)

    }
    
}

 //MARK: UITabBarControllerDelegate

extension MainTabController: UITabBarControllerDelegate{
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.firstIndex(of: viewController)
        
        if index == 2{
            
            var config = YPImagePickerConfiguration()
            config.library.mediaType = .photo
            config.shouldSaveNewPicturesToAlbum = false
            config.startOnScreen = .library //from enum
            config.screens = [.library]
            config.hidesStatusBar = false
            config.hidesBottomBar = false
            config.library.maxNumberOfItems = 1
            
            
            let picker = YPImagePicker(configuration: config)
            picker.modalPresentationStyle = .fullScreen
            
            present(picker, animated: true, completion: nil)
            
            didFinishPickingMedia(picker)
        }
        
        
        return true
    }
    
}


 //MARK: UploadPostControllerDelegate
extension MainTabController: UploadPostControllerDelegate{
    func controllerDidFinishUploadingPost(_ controller: UploadPostController) {
        print("[MainTabController] UploadPostControllerDelegate - DONE")
        selectedIndex = 0 //first tab
        
        controller.dismiss(animated: true, completion: nil)
        
        // dig for FeedController then refresh
        guard let feedNav = viewControllers?.first as? UINavigationController else{
            return
        }
        guard let feed = feedNav.viewControllers.first as? FeedController else {
            return
        }
        feed.handleRefresh()
    }
}
