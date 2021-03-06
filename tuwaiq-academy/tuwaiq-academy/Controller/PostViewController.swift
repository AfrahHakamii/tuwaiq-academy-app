//
//  PostViewController.swift
//  tuwaiq-academy
//
//  Created by Afrah Omar on 24/05/1443 AH.
//

import UIKit
import Firebase
class PostViewController: UIViewController {
    var selectedPost:Post?
    var selectedPostImage:UIImage?
    var selectedUserImage:UIImage?
    @IBOutlet weak var actionButton: UIButton! {
        didSet {
            actionButton.setTitle(NSLocalizedString("Add", tableName: "Localizable", comment: ""), for: .normal)
            
        }
    }
    
    @IBOutlet weak var thebathOutlet: UILabel!
    {   didSet {
        thebathOutlet.text = "The bath programming language".localized
    }
    }
    @IBOutlet weak var descriptionOutlet: UILabel!  {   didSet {
        descriptionOutlet.text = "Description".localized
    }
    }
    
    @IBOutlet weak var viewPost: UIView!
    
    
    @IBOutlet weak var viewPostHeader: UIView!
    
    @IBOutlet weak var postImageView: UIImageView!{
        didSet {
            postImageView.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
            postImageView.addGestureRecognizer(tapGesture)
        }
    }
 
    @IBOutlet weak var postTitleTextField: UITextField!
    @IBOutlet weak var postDescriptionTextField: UITextField!
//    @IBOutlet weak var bioTextField: UITextField!
    let activityIndicator = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewPost.layer.shadowColor = UIColor.gray.cgColor
        viewPost.layer.shadowOffset = .zero
        viewPost.layer.cornerRadius = 10
        viewPost.layer.shadowPath = UIBezierPath(rect: viewPost.bounds).cgPath
        viewPost.layer.shouldRasterize = true
        self.viewPost.layer.cornerRadius = 10
        postImageView.layer.shadowColor = UIColor.systemGray6.cgColor
        postImageView.layer.shadowOffset = .zero
        postImageView.layer.cornerRadius = 10
        postImageView.layer.shadowPath = UIBezierPath(rect: postImageView.bounds).cgPath
        postImageView.layer.shouldRasterize = true
        self.postImageView.layer.cornerRadius = 10
        
        if let selectedPost = selectedPost,
        let selectedImage = selectedPostImage{
            postTitleTextField.text = selectedPost.title
            postDescriptionTextField.text = selectedPost.description
            postImageView.image = selectedImage
            actionButton.setTitle("Update Post", for: .normal)
            let deleteBarButton = UIBarButtonItem(image: UIImage(systemName: "trash.fill"), style: .plain, target: self, action: #selector(handleDelete))
            self.navigationItem.rightBarButtonItem = deleteBarButton
        }else {
            actionButton.setTitle("Add Post", for: .normal)
            self.navigationItem.rightBarButtonItem = nil
            
        }
        // Do any additional setup after loading the view.
    }
    @objc func handleDelete (_ sender: UIBarButtonItem) {
        let ref = Firestore.firestore().collection("posts")
        if let selectedPost = selectedPost {
            Activity.showIndicator(parentView: self.view, childView: activityIndicator)
            ref.document(selectedPost.id).delete { error in
                if let error = error {
                    print("Error in db delete",error)
                }else {
                    // Create a reference to the file to delete
                    let storageRef = Storage.storage().reference(withPath: "posts/\(selectedPost.user.id)/\(selectedPost.id)")
                    // Delete the file
                    storageRef.delete { error in
                        if let error = error {
                            print("Error in storage delete",error)
                        } else {
                            self.activityIndicator.stopAnimating()
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                    
                }
            }
        }
    }
    @IBAction func handleActionTouch(_ sender: Any) {
        if let image = postImageView.image,
           let imageData = image.jpegData(compressionQuality: 0.75),
           let title = postTitleTextField.text,
           let description = postDescriptionTextField.text,
           let currentUser = Auth.auth().currentUser {
            Activity.showIndicator(parentView: self.view, childView: activityIndicator)
//            ref.addDocument(data:)
            var postId = ""
            if let selectedPost = selectedPost {
                postId = selectedPost.id
            }else {
                postId = "\(Firebase.UUID())"
            }
            let storageRef = Storage.storage().reference(withPath: "posts/\(currentUser.uid)/\(postId)")
            let updloadMeta = StorageMetadata.init()
            updloadMeta.contentType = "image/jpeg"
            storageRef.putData(imageData, metadata: updloadMeta) { storageMeta, error in
                if let error = error {
                    print("Upload error",error.localizedDescription)
                }
                storageRef.downloadURL { url, error in
                    var postData = [String:Any]()
                    if let url = url {
                        let db = Firestore.firestore()
                        let ref = db.collection("posts")
                        if let selectedPost = self.selectedPost {
                            postData = [
                                "userId":selectedPost.user.id,
                                "title":title,
                                        "description":description,
                                "imageUrl":url.absoluteString,
                                "createdAt":selectedPost.createdAt ?? FieldValue.serverTimestamp(),
                                "updatedAt": FieldValue.serverTimestamp()
                            ]
                        }else {
                            postData = [
                                "userId":currentUser.uid,
                                "title":title,
                                "description":description,
                                "imageUrl":url.absoluteString,
                                "createdAt":FieldValue.serverTimestamp(),
                                "updatedAt": FieldValue.serverTimestamp()
                            ]
                        }
                        ref.document(postId).setData(postData) { error in
                            if let error = error {
                                print("FireStore Error",error.localizedDescription)
                            }
                            Activity.removeIndicator(parentView: self.view, childView: self.activityIndicator)
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            }
        }
    }
}
extension PostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func chooseImage() {
        self.showAlert()
    }
    private func showAlert() {
        let alert = UIAlertController(title: "Choose Profile Picture", message: "From where you want to pick this image?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    //get image from source type
    private func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        //Check is source type available
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        postImageView.image = chosenImage
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
