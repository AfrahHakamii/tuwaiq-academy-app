//
//  LoginViewController.swift
//  tuwaiq-academy
//
//  Created by Afrah Omar on 23/05/1443 AH.
//

import UIKit
import Firebase
import SwiftUI
class LoginViewController: UIViewController {
    var activityIndicator = UIActivityIndicatorView()
    
    @IBOutlet weak var emailLoginLabel: UILabel! {   didSet {
        emailLoginLabel.text = "Email".localized
    }
    }
    @IBOutlet weak var passwordLoginLabel: UILabel! {   didSet {
        passwordLoginLabel.text = "Password".localized
    }
    }
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.isSecureTextEntry = true 
        }
    }
    @IBOutlet weak var signLoginOutlet: UIButton! {
        didSet {
            signLoginOutlet.setTitle(NSLocalizedString("Signin", tableName: "Localizable", comment: ""), for: .normal)
            
        }
    }
    @IBOutlet weak var registerLoginOutlet: UIButton! {
        didSet {
            registerLoginOutlet.setTitle(NSLocalizedString("Register", tableName: "Localizable", comment: ""), for: .normal)
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func handleLogin(_ sender: Any) {
        if let email = emailTextField.text,
           let password = passwordTextField.text {
            Activity.showIndicator(parentView: self.view, childView: activityIndicator)
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let _ = authResult {
                    if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeNavigationController") as? UINavigationController {
                        vc.modalPresentationStyle = .fullScreen
                        Activity.removeIndicator(parentView: self.view, childView: self.activityIndicator)
                        self.present(vc, animated: true, completion: nil)
                    }
                }
            }
        }
    }
}
