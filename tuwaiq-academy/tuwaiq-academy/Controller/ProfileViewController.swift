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
    
    @IBOutlet weak var viewCourse: UIView!
    @IBOutlet weak var imageProfileUser: UIImageView! {
        didSet {
//            imageProfileUser.layer.borderColor = UIColor.systemGray2.cgColor
            imageProfileUser.layer.borderWidth = 1.0
            imageProfileUser.layer.cornerRadius = imageProfileUser.bounds.height
            / 2
            imageProfileUser.layer.masksToBounds = true
            imageProfileUser.isUserInteractionEnabled = true
        }
    }
    @IBOutlet weak var nameUserProfile: UILabel!
    @IBOutlet weak var emailUserProfile: UILabel!
    @IBOutlet weak var uiViewProfile: UIView!
    @IBAction func handleLogout(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LandingNavigationController") as? UINavigationController {
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
        } catch  {
            print("ERROR in signout",error.localizedDescription)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        uiViewProfile.layer.shadowColor = UIColor.gray.cgColor
//        uiViewProfile.layer.shadowOpacity = 1
        uiViewProfile.layer.shadowOffset = .zero
        uiViewProfile.layer.cornerRadius = 10
        uiViewProfile.layer.shadowPath = UIBezierPath(rect: uiViewProfile.bounds).cgPath
        uiViewProfile.layer.shouldRasterize = true
        self.uiViewProfile.layer.cornerRadius = 10
        
        viewCourse.layer.shadowColor = UIColor.gray.cgColor
//        uiViewProfile.layer.shadowOpacity = 1
        viewCourse.layer.shadowOffset = .zero
        viewCourse.layer.cornerRadius = 10
        viewCourse.layer.shadowPath = UIBezierPath(rect: viewCourse.bounds).cgPath
        viewCourse.layer.shouldRasterize = true
        self.viewCourse.layer.cornerRadius = 10
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
    @IBAction func linkYouTubeButton(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://www.youtube.com/channel/UC_pOwgeaVK7bg3z7fJB5N8w")! as URL, options: [:], completionHandler: nil )
        
        
    }
    @IBAction func linkWebButton(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://tuwaiq.edu.sa/#bootcamps")! as URL, options: [:], completionHandler: nil )
        
        
    }
    @IBAction func linkTwitterButton(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://twitter.com/tuwaiqacademy?lang=ar")! as URL, options: [:], completionHandler: nil )
        
        
    }
    @IBAction func linkLinkedinButton(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://www.linkedin.com/company/tuwaiqacademy/")! as URL, options: [:], completionHandler: nil )
        
        
    }
    
    @IBAction func linkButton(_ sender: Any)
        {
                UIApplication.shared.open(URL(string: "https://satr.codes/courses/KiQGXOXbXw/view")! as URL, options: [:], completionHandler: nil )
            }
        
        
    
    @IBAction func linkJava(_ sender: Any) {
                UIApplication.shared.open(URL(string: "https://satr.codes/courses/UJpWHpTxcz/view")! as URL, options: [:], completionHandler: nil )
            }
        
    
    @IBAction func linkKotlinButton(_ sender: Any) {
                UIApplication.shared.open(URL(string: "https://satr.codes/courses/SBeWZQhIkq/view")! as URL, options: [:], completionHandler: nil )
            }
}
