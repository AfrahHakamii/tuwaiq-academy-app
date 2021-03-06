//
//  RegisterViewController.swift
//  tuwaiq-academy
//
//  Created by Afrah Omar on 23/05/1443 AH.
//


import UIKit
import Firebase
class RegisterViewController: UIViewController {
    
    let imagePickerController = UIImagePickerController()
    var activityIndicator = UIActivityIndicatorView()

    @IBOutlet weak var eyePasswordOutlet: UIButton!
    @IBOutlet weak var eyeOutlet: UIButton!
    @IBOutlet weak var userImageView: UIImageView! {
        didSet {
            userImageView.layer.borderColor = UIColor.systemGray2.cgColor
            userImageView.layer.borderWidth = 1.0
            userImageView.layer.cornerRadius = userImageView.bounds.height
            / 2
            userImageView.layer.masksToBounds = true
            userImageView.isUserInteractionEnabled = true
            let tabGesture = UITapGestureRecognizer(target: self, action: #selector(selectImage))
            userImageView.addGestureRecognizer(tabGesture)
        }
    }
    
    @IBOutlet weak var viewRegister: UIView!
    @IBOutlet weak var nameTextField: UITextField! {
        didSet {
            nameTextField.placeholder = "Please enter your name".localized
        }
    }
    @IBOutlet weak var emailTextField: UITextField! {
        didSet {
            emailTextField.placeholder = "Your email address".localized
        }
    }
    @IBOutlet weak var passwordTextField: UITextField!{
        didSet {
            passwordTextField.isSecureTextEntry = true
            passwordTextField.placeholder = "You Password".localized
        }
    }
    
    @IBOutlet weak var confirmPasswordTextField: UITextField! {
        didSet {
            confirmPasswordTextField.placeholder = "Confirm Password".localized
            confirmPasswordTextField.isSecureTextEntry = true
        }
    }
    @IBOutlet weak var registerOutlet: UIButton!  {
        didSet {
        registerOutlet.setTitle(NSLocalizedString("Register", tableName: "Localizable", comment: ""), for: .normal)
        
    }
}
    @IBOutlet weak var sginOutlet: UIButton!  {
        didSet {
            sginOutlet.setTitle(NSLocalizedString("Sign in", tableName: "Localizable", comment: ""), for: .normal)
            
        }
    }
    
    @IBOutlet weak var orLabel: UILabel! {   didSet {
        orLabel.text = "You have an account?".localized
    }
    }
    @IBOutlet weak var nameLabel: UILabel! {   didSet {
        nameLabel.text = "Name:".localized
    }
    }
    @IBOutlet weak var emailRegisterLabel: UILabel! {   didSet {
        emailRegisterLabel.text = "Email:".localized
    }
    }
    @IBOutlet weak var passwordRegisterLabel: UILabel! {   didSet {
        passwordRegisterLabel.text = "Password:".localized
    }
    }
    @IBOutlet weak var confirmPassordRegisterLabel: UILabel! {   didSet {
        confirmPassordRegisterLabel.text = "Confirm Password:".localized
    }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTextField.rightView = eyePasswordOutlet
                passwordTextField.rightViewMode = .whileEditing
                
        confirmPasswordTextField.rightView = eyeOutlet
        confirmPasswordTextField.rightViewMode = .whileEditing
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))
        
        viewRegister.layer.shadowColor = UIColor.gray.cgColor
        viewRegister.layer.shadowOffset = .zero
        viewRegister.layer.cornerRadius = 10
        viewRegister.layer.shadowPath = UIBezierPath(rect: viewRegister.bounds).cgPath
        viewRegister.layer.shouldRasterize = true
        self.viewRegister.layer.cornerRadius = 10
        
        imagePickerController.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func eyePasswordAcation(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
             if passwordTextField.isSecureTextEntry {
                 if let image = UIImage(systemName: "eye.fill") {
                     sender.setImage(image, for: .normal)
                 }
             } else {
                 if let image = UIImage(systemName: "eye.slash.fill"){
                     sender.setImage(image, for: .normal)
                 }
             }

    }
    
    @IBAction func eyeConfirmPassword(_ sender: UIButton) {
        confirmPasswordTextField.isSecureTextEntry.toggle()
            if confirmPasswordTextField.isSecureTextEntry {
                if let image = UIImage(systemName: "eye.fill") {
                    sender.setImage(image, for: .normal)
                }
            } else {
                if let image = UIImage(systemName: "eye.slash.fill"){
                    sender.setImage(image, for: .normal)
                }
            }

    }
    @IBAction func handleRegister(_ sender: Any) { 
        
        if let image = userImageView.image,
           let imageData = image.jpegData(compressionQuality: 0.75),
           let name = nameTextField.text,
           let email = emailTextField.text,
           let password = passwordTextField.text,
           let confirmPassword = confirmPasswordTextField.text,
           password == confirmPassword {
            Activity.showIndicator(parentView: self.view, childView: activityIndicator)
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    Alert.showAlert(strTitle: "Error", strMessage: error.localizedDescription, viewController: self)
                    Activity.removeIndicator(parentView: self.view, childView: self.activityIndicator)
                    print("Registration Auth Error",error.localizedDescription)
                }
                if let authResult = authResult {
                    let storageRef = Storage.storage().reference(withPath: "users/\(authResult.user.uid)")
                    let uploadMeta = StorageMetadata.init()
                    uploadMeta.contentType = "image/jpeg"
                    storageRef.putData(imageData, metadata: uploadMeta) { storageMeta, error in
                        if let error = error {
                            Alert.showAlert(strTitle: "Error", strMessage: error.localizedDescription, viewController: self)
                            Activity.removeIndicator(parentView: self.view, childView: self.activityIndicator)
                            Alert.showAlert(strTitle: "Error", strMessage: error.localizedDescription, viewController: self)
                            Activity.removeIndicator(parentView: self.view, childView: self.activityIndicator)
                            print("Registration Storage Error",error.localizedDescription)
                        }
                        storageRef.downloadURL { url, error in
                            if let error = error {
                                Alert.showAlert(strTitle: "Error", strMessage: error.localizedDescription, viewController: self)
                                Activity.removeIndicator(parentView: self.view, childView: self.activityIndicator)
                                print("Registration Storage Download Url Error",error.localizedDescription)
                            }
                            if let url = url {
                                print("URL",url.absoluteString)
                                let db = Firestore.firestore()
                                let userData: [String:String] = [
                                    "id":authResult.user.uid,
                                    "name":name,
                                    "email":email,
                                    "imageUrl":url.absoluteString
                                ]
                                db.collection("users").document(authResult.user.uid).setData(userData) { error in
                                    if let error = error {
                                        Alert.showAlert(strTitle: "Error", strMessage: error.localizedDescription, viewController: self)
                                        Activity.removeIndicator(parentView: self.view, childView: self.activityIndicator)
                                        print("Registration Database error",error.localizedDescription)
                                    }else {
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
                }
            }
        }
    }
}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @objc func selectImage() {
        showAlert()
    }
    func showAlert() {
        let alert = UIAlertController(title: "choose Profile Picture", message: "where do you want to pick your image from?", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { Action in
            self.getImage(from: .camera)
        }
        let galaryAction = UIAlertAction(title: "photo Album", style: .default) { Action in
            self.getImage(from: .photoLibrary)
        }
        let dismissAction = UIAlertAction(title: "Cancle", style: .destructive) { Action in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(cameraAction)
        alert.addAction(galaryAction)
        alert.addAction(dismissAction)
        self.present(alert, animated: true, completion: nil)
    }
    func getImage( from sourceType: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return}
        userImageView.image = chosenImage
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
