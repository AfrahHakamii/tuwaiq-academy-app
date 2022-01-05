//
//  ProfileViewController.swift
//  tuwaiq-academy
//
//  Created by Afrah Omar on 02/06/1443 AH.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    var arrAcademy = [Academy]()
    var selectAcademy : Academy?
  
    @IBOutlet weak var imageProfileUser: UIImageView!
    @IBOutlet weak var nameUserProfile: UILabel!
    @IBOutlet weak var emailUserProfile: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
   
        
     
        
        getUser()

        // Do any additional setup after loading the view.
        func getUser() {
            let ref = Firestore.firestore()
            if let currentUser = Auth.auth().currentUser{
                ref.collection("users").document(currentUser.uid).addSnapshotListener {
                    snapshot, error in
                    if let error = error {
                        print("", error.localizedDescription)
                    }
                    if let snapshot = snapshot, let userDate = snapshot.data() {
                        let user = User(dict: userDate)
                        self.imageProfileUser.loadImageUsingCache(with: user.imageUrl)
                        self.nameUserProfile.text = user.name
                        self.emailUserProfile.text = user.email
                        
                    }
                }
            }
        }
    

}

}

