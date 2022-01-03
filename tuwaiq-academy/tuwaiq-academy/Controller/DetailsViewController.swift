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
        descriptionLabelDetails.text = "description".localized
   }
   }
    
    @IBOutlet weak var theBathLabelDetails: UILabel!  {   didSet {
        theBathLabelDetails.text = "TheBath".localized
    }
    }
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameView: UILabel!
    @IBOutlet weak var postCityLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
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
