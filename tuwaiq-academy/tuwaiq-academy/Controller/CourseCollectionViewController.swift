//
//  CourseCollectionViewController.swift
//  tuwaiq-academy
//
//  Created by Afrah Omar on 29/05/1443 AH.
//

import UIKit

class CourseCollectionViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var collectionViewCourses: UICollectionView!
    var arrCourse = [Course]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewCourses.delegate = self
        collectionViewCourses.dataSource = self
        arrCourse.append(Course(photo: UIImage(named: "swift")!, title: "Swift"))
        arrCourse.append(Course(photo: UIImage(named: "js")!, title: " JavaScript"))
        arrCourse.append(Course(photo: UIImage(named: "java")!, title: "Java"))
        arrCourse.append(Course(photo: UIImage(named: "k")!, title: "Kotlin"))
        arrCourse.append(Course(photo: UIImage(named: "python")!, title: "Python"))
        arrCourse.append(Course(photo: UIImage(named: "c")!, title: " #C"))
        arrCourse.append(Course(photo: UIImage(named: "swift")!, title: "مسار طويق للأمن السيبراني"))
        arrCourse.append(Course(photo: UIImage(named: "x")!, title: "الحوسبة السحابية"))
        arrCourse.append(Course(photo: UIImage(named: "t")!, title: " لتطوير الالعاب"))
    }
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrCourse.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "course", for: indexPath) as! CourseCollectionViewCell
        let course = arrCourse[indexPath.row]
        cell.setupCell(photo: course.photo, title: course.title)
//        cell.backgroundColor = Color L
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  CGSize(width: self.view.frame.width * 0.3 , height: self.view.frame.width * 0.3 )
    }
}

struct Course {
    let photo : UIImage
    let title : String
}
