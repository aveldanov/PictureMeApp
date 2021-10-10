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
    var user: User?{
        didSet{
            self.collectionView.reloadData()
        }
    }
    

     //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        fetchUserCall()
    }
    
    
     //MARK: API Calls
    
    func fetchUserCall(){
        
        UserService.fetchUser { user in
            self.user = user
            self.navigationItem.title = user.username
        }
        
    }
    
    
     //MARK: Helpers
    
    private func configureCollectionView(){
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
        if let user = user{
            header.viewModel = ProfileHeaderViewModel(user: user)
        }else{
            print("[ProfileController] user has not been set")
        }
 
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
