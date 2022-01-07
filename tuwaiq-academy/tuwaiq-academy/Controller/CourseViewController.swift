//
//  CourseViewController.swift
//  tuwaiq-academy
//
//  Created by Afrah Omar on 02/06/1443 AH.
//

import UIKit

class CourseCollectionViewController: UIViewController {

    
    @IBOutlet weak var collectionViewCourses: UICollectionView!
    
    var arrAcademy = [Academy]()
    var number:Int?
    var selectAcademy : Academy?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewCourses.delegate = self
        collectionViewCourses.dataSource = self
        number = 2222
        
        arrAcademy = [Academy(image: UIImage(named: "ac")!, description: "aca".localized, title: "ac".localized),
                      Academy(image: UIImage(named: "1000")!, description: "g1000".localized, title: "h1000".localized),
                      Academy(image: UIImage(named: "str")!, description: "str1".localized , title: "str2".localized),
                      Academy(image: UIImage(named: "co")!, description: "co1".localized, title: "co2".localized),
                      Academy(image: UIImage(named: "tu1")!, description: "g2".localized, title: "g3".localized),
                      Academy(image: UIImage(named: "ac1")!, description: "ac2".localized, title: "ac3".localized)]
        
        print(" Array in ViewDidLoad : \(arrAcademy)")
        
     
    }
    @IBAction func linkButton(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://satr.codes/courses/KiQGXOXbXw/view")! as URL, options: [:], completionHandler: nil )
    }
    
    
    @IBAction func linkJava(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://satr.codes/courses/UJpWHpTxcz/view")! as URL, options: [:], completionHandler: nil )
    }
    
    @IBAction func linkKotlinButton(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://satr.codes/courses/SBeWZQhIkq/view")! as URL, options: [:], completionHandler: nil )
    }
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

