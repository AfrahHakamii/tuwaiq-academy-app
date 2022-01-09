//
//  ViewController.swift
//  tuwaiq-academy
//
//  Created by Afrah Omar on 19/05/1443 AH.
//

import UIKit
class LandingViewController: UIViewController {
    
    @IBOutlet weak var languageSegmentControl: UISegmentedControl! {
        didSet {
            if let lang = UserDefaults.standard.string(forKey: "currentLanguage") {
                switch lang {
                case "ar":
                    languageSegmentControl.selectedSegmentIndex = 0
                    UIView.appearance().semanticContentAttribute = .forceRightToLeft
                case "en":
                    languageSegmentControl.selectedSegmentIndex = 1
                    UIView.appearance().semanticContentAttribute = .forceLeftToRight
                default:
                    let localLang =  Locale.current.languageCode
                    if localLang == "en" {
                        languageSegmentControl.selectedSegmentIndex = 1
                        
                    }else {
                        languageSegmentControl.selectedSegmentIndex = 0
                    }
                    
                }
            }else {
                let localLang =  Locale.current.languageCode
                UserDefaults.standard.setValue([localLang], forKey: "AppleLanguage")
                if localLang == "en" {
                    languageSegmentControl.selectedSegmentIndex = 0
                }else {
                    languageSegmentControl.selectedSegmentIndex = 1
                }
            }
        }
    }
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
            signInLandingOutlet.setTitle(NSLocalizedString("Sign in", tableName: "Localizable", comment: ""), for: .normal)
            
        }
    }
    @IBAction func languageChanged(_ sender: UISegmentedControl) {
        if let lang = sender.titleForSegment(at:sender.selectedSegmentIndex)?.lowercased() {
            UserDefaults.standard.set(lang, forKey: "currentLanguage")
            Bundle.setLanguage(lang)
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = storyboard.instantiateInitialViewController()
            }
        }
    }
}
extension String {
    var localized: String {
        
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
