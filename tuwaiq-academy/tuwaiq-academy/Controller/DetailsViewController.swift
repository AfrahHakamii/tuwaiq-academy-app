//
//  DetailsViewController.swift
//  tuwaiq-academy
//
//  Created by Afrah Omar on 24/05/1443 AH.
//

import UIKit

class DetailsViewController: UIViewController {
    var selectedPost:Post?
    var selectedPostImage:UIImage?
    var selectedUserImage:UIImage?
    @IBOutlet weak var postDescriptionLabel: UILabel!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabelDetails: UILabel!
    {   didSet {
        descriptionLabelDetails.text = "Description".localized
   }
   }
    
    @IBOutlet weak var theBathLabelDetails: UILabel!  {   didSet {
        theBathLabelDetails.text = "The bath programming language".localized
    }
    }
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameView: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        postImageView.layer.shadowColor = UIColor.systemGray6.cgColor
        postImageView.layer.shadowOpacity = 1
        postImageView.layer.shadowOffset = .zero
        postImageView.layer.cornerRadius = 10
        postImageView.layer.shadowPath = UIBezierPath(rect: postImageView.bounds).cgPath
        postImageView.layer.shouldRasterize = true
        self.postImageView.layer.cornerRadius = 10
//            let tabGesture =
        if let selectedPost = selectedPost,
        let selectedImage = selectedPostImage{
            postTitleLabel.text = selectedPost.title
            postDescriptionLabel.text = selectedPost.description
            postImageView.image = selectedImage
            userImageView.image = selectedUserImage
            usernameView.text = selectedPost.user.name
            
        
        }
        // Do any additional setup after loading the view.
    }
}
