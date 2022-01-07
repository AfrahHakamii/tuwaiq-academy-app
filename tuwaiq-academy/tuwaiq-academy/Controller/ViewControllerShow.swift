//
//  ViewControllerShow.swift
//  tuwaiq-academy
//
//  Created by Afrah Omar on 02/06/1443 AH.
//

import UIKit

class ViewControllerShow: UIViewController {
    var selectAcademy : Academy?
    @IBOutlet weak var UIView: UIView!
    @IBOutlet weak var titleAcademy: UILabel!
    @IBOutlet weak var imageAcademyShow: UIImageView!
    @IBOutlet weak var descriptionAcademy: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

//        UIView.layer.shadowColor = UIColor.gray.cgColor
//        UIView.layer.shadowOpacity = 1
//        UIView.layer.shadowOffset = .zero
//        UIView.layer.cornerRadius = 10
//        UIView.layer.shadowPath = UIBezierPath(rect: UIView.bounds).cgPath
//        UIView.layer.shouldRasterize = true
//        self.UIView.layer.cornerRadius = 10
        if let selectAcademy = selectAcademy {
            titleAcademy.text = selectAcademy.title
            imageAcademyShow.image = selectAcademy.image
            descriptionAcademy.text = selectAcademy.description
        }

        
    }
}

