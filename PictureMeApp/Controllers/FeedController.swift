//
//  FeedController.swift
//  PictureMeApp
//
//  Created by Anton Veldanov on 10/3/21.
//

import UIKit
import Firebase


class FeedController: UICollectionViewController{
    
    weak var delegate: AuthProtocolDelegate?
    
    private var loadedPosts = [Post]()

    var post: Post?
    
     //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchPostsCall()
    }
    
    
     //MARK: API Calls
    
    func fetchPostsCall(){
        guard post == nil else{
            return
        }
        
        PostService.fetchPosts { posts in
            self.loadedPosts = posts
            self.collectionView.refreshControl?.endRefreshing()
            self.collectionView.reloadData()
        }
        
    }
    
    
    
    
     //MARK: Helpers
    
    func configureUI(){
        collectionView.backgroundColor = .white
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: FeedCell.identifier)
        
        
        if post == nil{
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout",
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(handleLogout))
        }
        
        
        
        navigationItem.title = "Feed"
        
        // pull data refresh
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView.refreshControl = refresher
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
    
    
    
    @objc func handleRefresh(){
        loadedPosts.removeAll()
        fetchPostsCall()
    }
    
    
}

 //MARK: UICollectionView DataSource
extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return post != nil ? 1 : loadedPosts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCell.identifier, for: indexPath) as! FeedCell
        
        if let post = post{
            cell.viewModel = PostViewModel(post: post)
        }else{
            cell.viewModel = PostViewModel(post: loadedPosts[indexPath.row])
        }
        
        
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
