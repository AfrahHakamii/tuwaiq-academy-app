//
//  AcademyCollecatoionViewCell.swift
//  tuwaiq-academy
//
//  Created by Afrah Omar on 02/06/1443 AH.
//

import Foundation
import UIKit



class AcademyCollecatoionViewCell: UICollectionViewCell {
    

    @IBOutlet weak var myImageCollectionViewCell: UIImageView!
    
    @IBOutlet weak var descriptionCollectionView: UILabel!
    {
   didSet {
       descriptionCollectionView.layer.masksToBounds = true
       descriptionCollectionView.layer.cornerRadius = 20
         }
   }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        myImageCollectionViewCell.layer.shadowColor = UIColor.gray.cgColor
        myImageCollectionViewCell.layer.shadowOpacity = 1
        myImageCollectionViewCell.layer.shadowOffset = .zero
        myImageCollectionViewCell.layer.cornerRadius = 10
        myImageCollectionViewCell.layer.shadowPath = UIBezierPath(rect: myImageCollectionViewCell.bounds).cgPath
        myImageCollectionViewCell.layer.shouldRasterize = true
        self.myImageCollectionViewCell.layer.cornerRadius = 10
    }
    

        // Configure the view for the selected state
    
        
    func settUpCell(photo:UIImage, description: String) {
            myImageCollectionViewCell.image = photo
        descriptionCollectionView.text = description
        }

    }
