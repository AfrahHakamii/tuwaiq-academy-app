//
//  CourseViewController.swift
//  tuwaiq-academy
//
//  Created by Afrah Omar on 02/06/1443 AH.
//

import UIKit

class CourseCollectionViewController: UIViewController {

    @IBOutlet weak var viewHeader: UIView!     {
        didSet{
            viewHeader.layer.borderColor = UIColor.tertiarySystemBackground.cgColor
            viewHeader.layer.borderWidth = 0
            viewHeader.layer.cornerRadius = 20
            viewHeader.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
//            viewWelcome.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
            viewHeader.layer.masksToBounds = true
            viewHeader.isUserInteractionEnabled = true
        }
    }
    
    @IBOutlet weak var imageHeader: UIImageView!
    
    
    @IBOutlet weak var collectionViewCourses: UICollectionView!
    
    @IBOutlet weak var uiViewCourses: UIView!
    var arrAcademy = [Academy]()
    var number:Int?
    var selectAcademy : Academy?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageHeader.layer.shadowColor = UIColor.gray.cgColor
        imageHeader.layer.shadowOpacity = 1
        imageHeader.layer.shadowOffset = .zero
        imageHeader.layer.cornerRadius = 10
        imageHeader.layer.shadowPath = UIBezierPath(rect: imageHeader.bounds).cgPath
        collectionViewCourses.layer.shouldRasterize = true
        self.collectionViewCourses.layer.cornerRadius = 10
        collectionViewCourses.layer.shadowColor = UIColor.gray.cgColor
        collectionViewCourses.layer.shadowOpacity = 1
        collectionViewCourses.layer.shadowOffset = .zero
        collectionViewCourses.layer.cornerRadius = 10
        collectionViewCourses.layer.shadowPath = UIBezierPath(rect: collectionViewCourses.bounds).cgPath
        collectionViewCourses.layer.shouldRasterize = true
        self.collectionViewCourses.layer.cornerRadius = 10
        collectionViewCourses.delegate = self
        collectionViewCourses.dataSource = self
        
        number = 2222
        
        arrAcademy = [Academy(image: UIImage(named: "ac")!, description: "ac".localized, title: "aca".localized),
                      Academy(image: UIImage(named: "1000")!, description: "h1000".localized, title: "g1000".localized),
                      Academy(image: UIImage(named: "str")!, description: "str2".localized , title: "str1".localized),
                      Academy(image: UIImage(named: "co")!, description: "co2".localized, title: "co1".localized),
                      Academy(image: UIImage(named: "tu1")!, description: "g3".localized, title: "g2".localized),
                      Academy(image: UIImage(named: "ac1")!, description: "ac3".localized, title: "ac2".localized)]
        
        print(" Array in ViewDidLoad : \(arrAcademy)")
    }
        
     
//    }
//    @IBAction func linkButton(_ sender: Any) {
//        UIApplication.shared.open(URL(string: "https://satr.codes/courses/KiQGXOXbXw/view")! as URL, options: [:], completionHandler: nil )
//    }
//
//
//    @IBAction func linkJava(_ sender: Any) {
//        UIApplication.shared.open(URL(string: "https://satr.codes/courses/UJpWHpTxcz/view")! as URL, options: [:], completionHandler: nil )
//    }
//
//    @IBAction func linkKotlinButton(_ sender: Any) {
//        UIApplication.shared.open(URL(string: "https://satr.codes/courses/SBeWZQhIkq/view")! as URL, options: [:], completionHandler: nil )
//    }
//}
    }

extension CourseCollectionViewController : UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(" This is my Array : \(arrAcademy)")
        return arrAcademy.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AcademyCollecatoionViewCell
        
        let academy = arrAcademy[indexPath.row]
        cell.settUpCell(photo: academy.image, description: academy.description)
        cell.backgroundColor = .systemBackground
               print("&&&&&&&^DATA^&&&&&&&", arrAcademy[indexPath.row])
        cell.layer.borderColor = UIColor.white.cgColor
               cell.layer.borderWidth = 2.0
               cell.layer.cornerRadius = 10
               
//        cell.backgroundColor = .systemGray4
   
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 0.3, height: self.view.frame.width * 0.493)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 2, bottom: 1, right: 2)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectAcademy = arrAcademy[indexPath.row]
        performSegue(withIdentifier: "VC", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sender = segue.destination as! ViewControllerShow
        sender.selectAcademy = selectAcademy
    }
}

