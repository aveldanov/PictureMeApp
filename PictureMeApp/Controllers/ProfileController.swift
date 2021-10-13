//
//  ProfileController.swift
//  PictureMeApp
//
//  Created by Anton Veldanov on 10/3/21.
//

import UIKit

class ProfileController: UICollectionViewController{

     //MARK: Properties
    
    //user observer needed as we start off with an empty value
    // Could have put it within completion handler
//    var user: User?{
//        didSet{
//            self.collectionView.reloadData()
//        }
//    }
    
    private var user: User

     //MARK: Lifecycle
    
    init(user: User){
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    
     //MARK: API Calls

    
    
     //MARK: Helpers
    
    private func configureCollectionView(){
        
        navigationItem.title = user.username
        
        
        collectionView.backgroundColor = .lightGray
        
        //cell
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: ProfileCell.identifier)
        //header
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileHeader.identifier)
    }
    
    

    
}

 //MARK: UICollectionViewDataSource
extension ProfileController{
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCell.identifier, for: indexPath) as! ProfileCell
        return cell
    }
    
    // header
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //called each time when it reloadsData()
        print("[ProfileController] header called")
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileHeader.identifier, for: indexPath) as! ProfileHeader
        header.delegate = self
        
        header.viewModel = ProfileHeaderViewModel(user: user)
        //            print("[ProfileController] user has not been set")
        
        
        return header
        
        
    }
    
    
}


//MARK: UICollectionViewDelegate
extension ProfileController{
   
   
}


//MARK: ProfileController
extension ProfileController: UICollectionViewDelegateFlowLayout{
   
    // size and spacing between cell
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    // cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (view.frame.width - 2)/3
        
        return CGSize(width: size, height: size)
    }
    
    // header size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 240)
        
    }
    
    
}


 //MARK: ProfileHeaderProtocolDelegate

extension ProfileController: ProfileHeaderProtocolDelegate{
    func header(_ profileHeader: ProfileHeader, didTapActionButtonFor user: User) {
        print("[ProfileController] header func")
        
        
        if user.isCurrentUser {
            print("[ProfileController] Show Edit Profile Here")
        } else if user.isFollowed{
            print("[ProfileController] Unfollow user here")

        }else{
            UserService.followUser(uid: user.uid) { error in
                print("[ProfileController] didFollow User. Update UI now")

            }
        }
        
    }
 
}
