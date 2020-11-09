//
//  DashboardVC.swift
//  nDatu
//
//  Created by Sagar Ranshur on 15/04/20.
//  Copyright © 2020 Sagar Ranshur. All rights reserved.
//

import UIKit

class DashboardVC: UIViewController {
    
    @IBOutlet weak var reportTaskBaseView: UIView!
    @IBOutlet weak var myTasksBaseView: UIView!
    @IBOutlet weak var completedTasksBaseView: UIView!
    @IBOutlet weak var sideMenuBaseView: UIView!
    @IBOutlet weak var sideMenuWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingConstraintSideView: NSLayoutConstraint!
    @IBOutlet weak var userProfileWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var baseView: UIView!
    
    @IBOutlet weak var menuClientsHeightContraints: NSLayoutConstraint!
    @IBOutlet weak var menuServicesHeightContraint: NSLayoutConstraint!
    @IBOutlet weak var clientsBaseViewSideMenu: UIView!
    @IBOutlet weak var servicesBaseViewSideMenu: UIView!
    @IBOutlet weak var sideMenuLeadingContraint: NSLayoutConstraint!
    @IBOutlet weak var clientsCollectionView: UICollectionView!
    @IBOutlet weak var newsletterCollectionView: UICollectionView!
    @IBOutlet weak var eventsCollectionView: UICollectionView!
    @IBOutlet weak var projectsCollectionView: UICollectionView!

    @IBOutlet weak var promotionalPageControl: UIPageControl!
    
    var isClientsExpanded = false
    var isServicesExpanded = false
    var isEventsExpanded = false

    @IBOutlet weak var collectionView: UICollectionView!
    
    var height = 0.0
    var width = 0.0
    var promotionalBanner = [promotion]()
    var coursesArray = [Course]()
    var eventsArray = [Event]()
    var projectsArray = [Project]()

    var clientsArray = ["ibm", "googleIcon", "samsung", "adobe", "microsoft"]

    @IBOutlet weak var eventBaseView: UIView!
    @IBOutlet weak var eventHeightConstraint: NSLayoutConstraint!
    
    var counter = 0

    struct promotion {
        var image: String
        var category: String
    }
    
    struct Course {
        var title: String
        var duration: String
        var startDate: String
    }
    
    struct Event {
        var image: String
        var date: String
        var title: String
    }
    
    struct Project {
        var projectName: String
        var duration: String
        var clientName: String
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func setUpView()  {
        hideSideMenu()
        height = Double(collectionView.frame.size.height)
        width = Double(collectionView.frame.size.width)
        sideMenuBaseView.elevate(elevation: 2.0)
        
        promotionalBanner = [
            promotion.init(image: "promotion1", category: "Bussiness Outsourcing".localised()),
            promotion.init(image: "promotion2", category: "IT".localised()),
            promotion.init(image: "promotion3", category: "Quality Assurance".localised()),
            promotion.init(image: "promotion4", category: "Energy Software Solutions".localised()),
            promotion.init(image: "promotion5", category: "HeathCare Solutions".localised()),
        ]
        
        coursesArray = [
            Course.init(title: "Web Design", duration: "90 days", startDate: "08/08/2020"),
            Course.init(title: "App Development", duration: "150 days", startDate: "02/08/2020"),
        ];
        eventsArray = [
            Event.init(image: "event9", date: "2020/07/12", title: "Visit the GITEX exhibition"),
            Event.init(image: "event10", date: "2020/05/12", title: "Participation in the CITEX 2020 exhibition"),

//            Event.init(image: "event1", date: "2019/05/22", title: "ANAB COMPANY (Point Of Sales System) Visit"),
//            Event.init(image: "event2", date: "2019/05/22", title: "ANAB COMPANY (Point Of Sales System) Visit"),
//            Event.init(image: "event6", date: "2019/06/12", title: "Visit the SITEX exhibition 2019"),
//            Event.init(image: "event5", date: "2019/06/12", title: "Visit the SITEX exhibition 2019"),
//            Event.init(image: "event4", date: "2019/05/12", title: "Visit the SITEX exhibition 2019"),
//            Event.init(image: "event7", date: "2019/05/12", title: "Visit the SITEX exhibition 2019"),
//            Event.init(image: "event3", date: "2019/08/13", title: "GITEX 2019 event at Dubai"),
//            Event.init(image: "event8", date: "2019/01/09", title: "Another ALAMAFAZA villages i am proud of that"),

        ];
        projectsArray = [
            Project.init(projectName: "ERP Project", duration: "90 days", clientName: "Trance LLP"),
            Project.init(projectName: "D'Mas App Development", duration: "150 days", clientName: "D'Mas Corporation"),

            ];


        Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)
        
        promotionalPageControl.numberOfPages = promotionalBanner.count
        promotionalPageControl.currentPage = 0
                
        collectionView.reloadData()
        newsletterCollectionView.reloadData()
        eventsCollectionView.reloadData()
        projectsCollectionView.reloadData()
        collectionView.layer.cornerRadius = 25;
        clientsCollectionView.reloadData()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: Constants.HardcodedData.screenWidth/2 + 40, height: 160)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        newsletterCollectionView!.collectionViewLayout = layout
        
        let eventsLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        eventsLayout.scrollDirection = .horizontal
        eventsLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        eventsLayout.itemSize = CGSize(width: Constants.HardcodedData.screenWidth/2 + 60, height: 230)
        eventsLayout.minimumInteritemSpacing = 0
        eventsLayout.minimumLineSpacing = 0
        eventsCollectionView!.collectionViewLayout = eventsLayout
        
        let projectslayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        projectslayout.scrollDirection = .horizontal
        projectslayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        projectslayout.itemSize = CGSize(width: Constants.HardcodedData.screenWidth/2 + 40, height: 160)
        projectslayout.minimumInteritemSpacing = 0
        projectslayout.minimumLineSpacing = 0
        projectsCollectionView!.collectionViewLayout = projectslayout
}
    
    @objc func moveToNextPage(){
        
        if counter < promotionalBanner.count {
            let index = IndexPath.init(row: counter, section: 0)
            collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            promotionalPageControl.currentPage = counter
            counter += 1
        }else {
            counter = 0
            let index = IndexPath.init(row: counter, section: 0)
            collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            promotionalPageControl.currentPage = counter
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        hideSideMenu()
    }
    
    //MARK: - API CALL Method
    //MARK: -
    
    
    
    //MARK: - Hide & Show Side bar Menu
    //MARK: -
    
    func showSideMenu()  {
        UIView.animate(withDuration: 0.5) {
          //  self.sideMenuWidthConstraint.constant = Constants.HardcodedData.screenWidth * 0.75
            self.sideMenuLeadingContraint.constant = 0
            self.userProfileWidthConstraint.constant = 45
            self.sideMenuBaseView.isHidden = false
            self.baseView.isUserInteractionEnabled = true
            self.view.layoutIfNeeded()
        }
    }
    
    func hideSideMenu()  {
        UIView.animate(withDuration: 0.5) {
            self.sideMenuLeadingContraint.constant = -750
            self.baseView.isUserInteractionEnabled = false
            self.view.layoutIfNeeded()
        }
    }
    
    func showClientsView()  {
            UIView.animate(withDuration: 0.5) {
                self.menuClientsHeightContraints.constant = 250
                self.clientsBaseViewSideMenu.isHidden = false
                self.isClientsExpanded = true
            }
        }
        
        func hideClientsView()  {
            UIView.animate(withDuration: 0.5) {
                self.menuClientsHeightContraints.constant = 0
                self.clientsBaseViewSideMenu.isHidden = true
                self.isClientsExpanded = false
            }
        }
    
       func showServicesView()  {
            UIView.animate(withDuration: 0.5) {
                self.menuServicesHeightContraint.constant = 180
                self.servicesBaseViewSideMenu.isHidden = false
                self.isServicesExpanded = true
            }
        }
        
        func hideServicesView()  {
            UIView.animate(withDuration: 0.5) {
                self.menuServicesHeightContraint.constant = 0
                self.servicesBaseViewSideMenu.isHidden = true
                self.isServicesExpanded = false
            }
        }
    
    func showEventsView()  {
        UIView.animate(withDuration: 0.5) {
            self.eventHeightConstraint.constant = 160
            self.eventBaseView.isHidden = false
            self.isEventsExpanded = true
        }
    }
    
    func hideEventsView()  {
        UIView.animate(withDuration: 0.5) {
            self.eventHeightConstraint.constant = 0
            self.eventBaseView.isHidden = true
            self.isEventsExpanded = false
        }
    }

    //MARK: - Button Action Methods
    //MARK: -
        
    @IBAction func sideMenuClicked(_ sender: UIButton) {
        showSideMenu()
    }
    
    @IBAction func mainViewClicked(_ sender: UITapGestureRecognizer) {
        hideSideMenu()
    }
    
    @IBAction func ourClientsBtnClicked(_ sender: UIButton) {
        isClientsExpanded ? hideClientsView() : showClientsView()
    }
    
    @IBAction func ourServicesBtnClicked(_ sender: UIButton) {
        isServicesExpanded ? hideServicesView() : showServicesView()
    }
    
    @IBAction func registerForNewCourses(_ sender: UIButton) {
        let registerVC = Constants.Storyboards.main.instantiateViewController(identifier: "RegisterForCourseVC") as! RegisterForCourseVC
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    @IBAction func contactUsClicked(_ sender: UIButton) {
        let contactUsVC = Constants.Storyboards.main.instantiateViewController(identifier: "ContactUsViewController") as! ContactUsViewController
        navigationController?.pushViewController(contactUsVC, animated: true)
    }
    
    @IBAction func logoutBtnClicked(_ sender: UIButton) {
        let alert = UIAlertController.init(title: "Message".localised(), message: "Are you want to logout?".localised(), preferredStyle: .alert)
        let cancel = UIAlertAction.init(title: "CANCEL".localised(), style: .default, handler: nil)
        let action = UIAlertAction.init(title: "OK".localised(), style: .default) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(cancel);
        alert.addAction(action);
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func eventBtnClicked(_ sender: UIButton) {
        isEventsExpanded ? hideEventsView() : showEventsView()
    }
    
    @IBAction func event2TapAction(_ sender: UITapGestureRecognizer) {
        let contactUsVC = Constants.Storyboards.main.instantiateViewController(identifier: "Event2ViewController") as! Event2ViewController
        navigationController?.pushViewController(contactUsVC, animated: true)
    }
    
    @IBAction func event3TapAction(_ sender: UITapGestureRecognizer) {
        
        let contactUsVC = Constants.Storyboards.main.instantiateViewController(identifier: "Event3ViewController") as! Event3ViewController
        navigationController?.pushViewController(contactUsVC, animated: true)

    }
    
    @IBAction func event1TapAction(_ sender: UITapGestureRecognizer) {
        let contactUsVC = Constants.Storyboards.main.instantiateViewController(identifier: "Event1ViewController") as! Event1ViewController
        navigationController?.pushViewController(contactUsVC, animated: true)
    }
    
    
    @IBAction func settingsBtnClicked(_ sender: UIButton) {
        let contactUsVC = Constants.Storyboards.main.instantiateViewController(identifier: "SettingsViewController") as! SettingsViewController
        navigationController?.pushViewController(contactUsVC, animated: true)
    }
    
    @IBAction func event4TapAction(_ sender: UITapGestureRecognizer) {
            }
}

extension DashboardVC: UICollectionViewDelegate,UICollectionViewDataSource  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == newsletterCollectionView {
            return coursesArray.count
        }else if collectionView == eventsCollectionView {
            return eventsArray.count
        }else if collectionView == projectsCollectionView {
            return projectsArray.count
        }else if collectionView == clientsCollectionView{
            return clientsArray.count
        } else {
            return promotionalBanner.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == newsletterCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath) as! NewsLetterCell
            let coursesObj = coursesArray[indexPath.row]
            cell.articleLabel.text = coursesObj.title
            cell.contentLabel.text = "Course Duration" + " : " + coursesObj.duration
            cell.courseDateLabel.text = "Course Start Date" + " : " + coursesObj.startDate
            cell.baseView.elevate(elevation: 2.0)
            return cell
            
        }else if collectionView == projectsCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "projectsCell", for: indexPath) as! ProjectsCollectionViewCell

            let projectsObj = projectsArray[indexPath.row]
            cell.titleLabel.text = projectsObj.projectName
            cell.durationLabel.text = "Duration" + " : " + projectsObj.duration
            cell.clientNameLabel.text = "Client" + " : " + projectsObj.clientName
            cell.baseView.elevate(elevation: 2.0)
            return cell
            
        }else if collectionView == eventsCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventsCell", for: indexPath) as! EventsCollectionViewCell
            
            let eventsObj = eventsArray[indexPath.row]
            cell.eventImage.image = UIImage.init(named: eventsObj.image)
            cell.dateLabel.text = eventsObj.date
            cell.titleLabel.text = eventsObj.title
            cell.baseView.elevate(elevation: 2.0)
            return cell
            
        }else if collectionView == self.clientsCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "clientsCell", for: indexPath) as! ClientsCell
            cell.image.image = UIImage.init(named: clientsArray[indexPath.row])
            cell.baseView.elevate(elevation: 2.0)
            return cell
            
        }else if collectionView == self.collectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PromotiosCell
            let promotionObject = promotionalBanner[indexPath.row]
            cell.image.image = UIImage.init(named: promotionObject.image)
            cell.categoryLabel.text = promotionObject.category
            return cell
        }else {
            let cell = UICollectionViewCell()
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == newsletterCollectionView {
            return CGSize(width: Constants.HardcodedData.screenWidth / 2 + 40 , height: 160);
            
        }else if collectionView == eventsCollectionView {
            return CGSize(width: Constants.HardcodedData.screenWidth / 2 + 60 , height: 230);
            
        }else if collectionView == projectsCollectionView {
            return CGSize(width: Constants.HardcodedData.screenWidth / 2 + 40 , height: 160);
            
        }else if collectionView == clientsCollectionView {
            return CGSize(width: 128, height: 128)
        } else {
            return CGSize.init(width: self.width , height: 250)
        }
    }

}


