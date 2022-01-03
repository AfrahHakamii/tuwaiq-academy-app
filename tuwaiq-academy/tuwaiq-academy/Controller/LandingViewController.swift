//
//  ViewController.swift
//  tuwaiq-academy
//
//  Created by Afrah Omar on 19/05/1443 AH.
//

import UIKit
class LandingViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBOutlet weak var registeLandingOutlet: UIButton! {
        didSet {
            registeLandingOutlet.setTitle(NSLocalizedString("Register", tableName: "Localizable", comment: ""), for: .normal)
            
        }
    }
    
    @IBOutlet weak var signInLandingOutlet: UIButton! {
        didSet {
            signInLandingOutlet.setTitle(NSLocalizedString("Signin", tableName: "Localizable", comment: ""), for: .normal)
            
        }
    }
    
}
