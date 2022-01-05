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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


        // Configure the view for the selected state
    
        
    func settUpCell(photo:UIImage, description: String) {
            myImageCollectionViewCell.image = photo
        descriptionCollectionView.text = description
        }

    }
