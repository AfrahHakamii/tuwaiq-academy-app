//
//  CourseCollectionViewCell.swift
//  tuwaiq-academy
//
//  Created by Afrah Omar on 29/05/1443 AH.
//

import UIKit

class CourseCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var courseImage: UIImageView!
    @IBOutlet weak var courseLabel: UILabel!
    
    func setupCell(photo: UIImage, title: String ){
        courseImage.image = photo
        courseLabel.text = title
    }
}
