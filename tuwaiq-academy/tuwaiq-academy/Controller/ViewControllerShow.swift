//
//  ViewControllerShow.swift
//  tuwaiq-academy
//
//  Created by Afrah Omar on 02/06/1443 AH.
//

import UIKit

class ViewControllerShow: UIViewController {
    var selectAcademy : Academy?
    @IBOutlet weak var UIView: UIView!     {
        didSet{
            UIView.layer.borderColor = UIColor.tertiarySystemBackground.cgColor
            UIView.layer.borderWidth = 0
            UIView.layer.cornerRadius = 20
            UIView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
//            viewWelcome.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
            UIView.layer.masksToBounds = true
            UIView.isUserInteractionEnabled = true
        }
    }
    @IBOutlet weak var titleAcademy: UILabel!
    @IBOutlet weak var imageAcademyShow: UIImageView!
  
    @IBOutlet weak var descriptionAcademy: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageAcademyShow.layer.shadowColor = UIColor.systemGray6.cgColor
        imageAcademyShow.layer.shadowOpacity = 1
        imageAcademyShow.layer.shadowOffset = .zero
        imageAcademyShow.layer.cornerRadius = 10
        imageAcademyShow.layer.shadowPath = UIBezierPath(rect: imageAcademyShow.bounds).cgPath
        imageAcademyShow.layer.shouldRasterize = true
        self.imageAcademyShow.layer.cornerRadius = 10

//        UIView.layer.shadowColor = UIColor.gray.cgColor
//        UIView.layer.shadowOpacity = 1
//        UIView.layer.shadowOffset = .zero
//        UIView.layer.cornerRadius = 10
//        UIView.layer.shadowPath = UIBezierPath(rect: UIView.bounds).cgPath
//        UIView.layer.shouldRasterize = true
//        self.UIView.layer.cornerRadius = 10
        if let selectAcademy = selectAcademy {
            titleAcademy.text = selectAcademy.description
            imageAcademyShow.image = selectAcademy.image
            descriptionAcademy.text = selectAcademy.title
        }

        
    }
}

