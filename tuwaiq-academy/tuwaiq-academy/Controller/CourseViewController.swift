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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewCourses.delegate = self
        collectionViewCourses.dataSource = self
        number = 2222
        
        arrAcademy = [Academy(image: UIImage(named: "t2")!, description: "Afrah".localized),
                      Academy(image: UIImage(named: "t1")!, description: "Afrah".localized),
                      Academy(image: UIImage(named: "t3")!, description: "Afrah".localized),
                      Academy(image: UIImage(named: "t4")!, description: "Afrah"),
                      Academy(image: UIImage(named: "t5")!, description: "Afrah"),]
        
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

extension CourseCollectionViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(" This is my Array : \(arrAcademy)")
        return arrAcademy.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AcademyCollecatoionViewCell
        
        let academy = arrAcademy[indexPath.row]
        
        cell.settUpCell(photo: academy.image, description: academy.description)
   
        return cell
    }
    
    
}

