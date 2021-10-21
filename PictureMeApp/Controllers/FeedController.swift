//
//  FeedController.swift
//  PictureMeApp
//
//  Created by Anton Veldanov on 10/3/21.
//

import UIKit
import Firebase

private let identifier = "Cell"

class FeedController: UICollectionViewController{
    
    weak var delegate: AuthProtocolDelegate?
    
    private var loadedPosts = [Post]()
    
     //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchPostsCall()
    }
    
    
     //MARK: API Calls
    
    func fetchPostsCall(){
        
        
        PostService.fetchPosts { posts in
            self.loadedPosts = posts
            self.collectionView.reloadData()
        }
        
    }
    
    
    
    
     //MARK: Helpers
    
    func configureUI(){
        collectionView.backgroundColor = .white
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: identifier)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(handleLogout))
        navigationItem.title = "Feed"
        
    }
    
     //MARK: Actions
    
    @objc private func handleLogout(){
        do{
            try Auth.auth().signOut()
            let vc = LoginController()
            vc.delegate = self.tabBarController as? MainTabController
//            vc.delegate = delegate
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            
            self.present(nav, animated: true, completion: nil)
        } catch{
            print("[MainTabController] Failed to sign out")
        }
    } 
}

 //MARK: UICollectionView DataSource
extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return loadedPosts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! FeedCell
        
        return cell
    }
    
    
}


 //MARK: UICollectionViewDelegateFlowLayout

extension FeedController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        var height = 8+40+8+width // pad + prof pict + pad + postPict
        height += 50 // actions
        height += 60 // comments
        return CGSize(width: width, height: height)
    }
}
