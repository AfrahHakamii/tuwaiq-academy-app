//
//  postCell.swift
//  tuwaiq-academy
//
//  Created by Afrah Omar on 24/05/1443 AH.
//

import UIKit

class PostCell: UITableViewCell {
        
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postDescriptionLabel: UILabel!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView! {
        didSet {
            userImageView.layer.borderColor = UIColor.systemGray2.cgColor
            userImageView.layer.borderWidth = 1.0
            userImageView.layer.cornerRadius = userImageView.bounds.height
            / 2
            userImageView.layer.masksToBounds = true
            userImageView.isUserInteractionEnabled = true
        

            postImageView.layer.shadowColor = UIColor.systemGray6.cgColor
            postImageView.layer.shadowOpacity = 1
            postImageView.layer.shadowOffset = .zero
            postImageView.layer.cornerRadius = 10
            postImageView.layer.shadowPath = UIBezierPath(rect: postImageView.bounds).cgPath
            postImageView.layer.shouldRasterize = true
            self.postImageView.layer.cornerRadius = 10

        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(with post:Post) -> UITableViewCell {
        postTitleLabel.text = post.title
        postDescriptionLabel.text = post.description
        postImageView.loadImageUsingCache(with: post.imageUrl)
        userNameLabel.text = post.user.name
        userImageView.loadImageUsingCache(with: post.user.imageUrl)
        return self
    }
    
    override func prepareForReuse() {
        userImageView.image = nil
        postImageView.image = nil
    }
}
