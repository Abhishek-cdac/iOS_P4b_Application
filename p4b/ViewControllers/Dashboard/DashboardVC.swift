//
//  DashboardVC.swift
//  nDatu
//
//  Created by Sagar Ranshur on 15/04/20.
//  Copyright © 2020 Sagar Ranshur. All rights reserved.
//

import UIKit
import ObjectMapper

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
    @IBOutlet weak var customNavigationBar: UIView!
    @IBOutlet weak var promotionalPageControl: UIPageControl!
    @IBOutlet weak var loginImage: UIImageView!
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var sideMenuOptionsTableView: UITableView!
    
    @IBOutlet weak var onlineCoursesTitle: UILabel!
    @IBOutlet weak var latestNewsTilte: UILabel!
    @IBOutlet weak var ourProjectsLabel: UILabel!
    @IBOutlet weak var ourClientsLabel: UILabel!
    
    @IBOutlet weak var noDataFoundCoursesLable: UILabel!
    @IBOutlet weak var noDataFoundEventsLable: UILabel!
    @IBOutlet weak var noDataFoundProjectsLable: UILabel!
    @IBOutlet weak var noDataFoundClientsLable: UILabel!


    var isClientsExpanded = false
    var isServicesExpanded = false
    var isEventsExpanded = false
    
    var isLoggedIn = false
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var height = 0.0
    var width = 0.0
    var promotionalBanner = [promotion]()
    var coursesArray = [CourseModel]()
    var eventsArray = [EventsModel]()
    var projectsArray = [ProjectsModel]()
    var clientsArray = [ClientModel]()

    
//    var clientsArray = ["anab", "aryam", "baaboud", "babelhara", "baydmont", "brand","danfodo","elbsmala","HEALTH","Lumara","Mafath","msabeh","yagot"]
    
    @IBOutlet weak var eventBaseView: UIView!
    @IBOutlet weak var eventHeightConstraint: NSLayoutConstraint!
    
    var counter = 0
    
    var sideMenuOptionsArray = [["Online Courses".localised(),"Latest News".localised(),"Our Services".localised(),"Our Projects".localised(), "Our Clients".localised(), "Contact Us".localised(), "About Us".localised(), "Settings".localised()],
                                ["Register".localised(), "Login".localised()],
    ]
    
    struct promotion {
        var image: String
        var category: String
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.loginNotification(_:)), name: NSNotification.Name(rawValue: Constants.Notifications.loginNotification), object: nil)

        getDashboardDetailsAPI()
        loginHandler()
    }
    
    @objc func loginNotification(_ notification: NSNotification) {
        loginHandler()
    }


    func setUpView()  {
        //handle login/logout button clicked
        
        hideSideMenu()
        height = Double(collectionView.frame.size.height)
        width = Double(collectionView.frame.size.width)
        sideMenuBaseView.elevate(elevation: 2.0)
        customNavigationBar.elevate(elevation: 2.0)
        
        promotionalBanner = [
            promotion.init(image: "promotion1", category: "".localised()),
            //            promotion.init(image: "promotion2", category: "IT".localised()),
            //            promotion.init(image: "promotion3", category: "Quality Assurance".localised()),
            //            promotion.init(image: "promotion4", category: "Energy Software Solutions".localised()),
            //            promotion.init(image: "promotion5", category: "HeathCare Solutions".localised()),
        ]
        
//        coursesArray = [
//            Constants.Course.init(title: "Web Design".localised(), duration: "90 days".localised(), startDate: "08/08/2020", teacherName: "Shami Ahmed", applicants: "774"),
//            Constants.Course.init(title: "App Development".localised(), duration: "150 days".localised(), startDate: "02/08/2020", teacherName: "Zamil Sheik", applicants: "316"),
//        ];
//        eventsArray = [
//            Event.init(image: "event9", date: "2020/07/12", title: "Visit the GITEX exhibition".localised()),
//            Event.init(image: "event10", date: "2020/05/12", title: "Participation in the CITEX 2020 exhibition".localised()),
            
            //            Event.init(image: "event1", date: "2019/05/22", title: "ANAB COMPANY (Point Of Sales System) Visit"),
            //            Event.init(image: "event2", date: "2019/05/22", title: "ANAB COMPANY (Point Of Sales System) Visit"),
            //            Event.init(image: "event6", date: "2019/06/12", title: "Visit the SITEX exhibition 2019"),
            //            Event.init(image: "event5", date: "2019/06/12", title: "Visit the SITEX exhibition 2019"),
            //            Event.init(image: "event4", date: "2019/05/12", title: "Visit the SITEX exhibition 2019"),
            //            Event.init(image: "event7", date: "2019/05/12", title: "Visit the SITEX exhibition 2019"),
            //            Event.init(image: "event3", date: "2019/08/13", title: "GITEX 2019 event at Dubai"),
            //            Event.init(image: "event8", date: "2019/01/09", title: "Another ALAMAFAZA villages i am proud of that"),
            
//        ];
        
        
        Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)
        
        promotionalPageControl.numberOfPages = promotionalBanner.count
        promotionalPageControl.currentPage = 0
        
        collectionView.reloadData()
        newsletterCollectionView.reloadData()
        eventsCollectionView.reloadData()
        projectsCollectionView.reloadData()
        collectionView.layer.cornerRadius = 25;
        clientsCollectionView.reloadData()
        
        if let lang = UserDefaults.standard.value(forKey: Constants.UserDefaults.selectedLanguage) as? String {
            if lang == "Arabic".localised() {
                onlineCoursesTitle.textAlignment = .left
                ourClientsLabel.textAlignment = .left
                latestNewsTilte.textAlignment = .left
                ourProjectsLabel.textAlignment = .left
                
            }
        }
        
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
    
    func loginHandler(){
        
        if !sideMenuBaseView.isHidden {
            hideSideMenu()
        }
        
        isLoggedIn = UserDefaults.standard.bool(forKey: Constants.UserDefaults.isUserLogin)
        var username = UserDefaults.standard.value(forKey: Constants.UserDefaults.userDetails) as? [String: String]
        
        if isLoggedIn == true  {
            if let name = username?["name"] {
                userNameLabel.text = "Welcome ".localised() + name
            }else {
                userNameLabel.text = "Welcome Guest".localised()
            }
            
            sideMenuOptionsArray = [["Online Courses".localised(),"Latest News".localised(),"Our Services".localised(),"Our Projects".localised(), "Our Clients".localised(), "Contact Us".localised(), "About Us".localised(), "Settings".localised()],["Logout".localised()],
            ]
        }else {
            userNameLabel.text = "Welcome Guest".localised()
            sideMenuOptionsArray = [["Online Courses".localised(),"Latest News".localised(),"Our Services".localised(),"Our Projects".localised(), "Our Clients".localised(), "Contact Us".localised(), "About Us".localised(), "Settings".localised()],["Register".localised(),"Login".localised()]]
        }
        sideMenuOptionsTableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        hideSideMenu()
    }
    
    //MARK: - API CALL Method
    //MARK: -
    
    func getDashboardDetailsAPI()  {
        
        Utility.startIndicator()
    
        WebService.requestServiceWithPostMethod(url: Constants.singleton.hostName, requestType: Constants.RequestType.dashboard) { (data, error) in
            
            do {
                
                Utility.hideIndicator()
                
                if let jsonData = data {
                    let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String : Any]
                    
                    if let objectModel = DashboardObject.init(JSON: json!) {
                        if objectModel.success == true {
                            self.getData(objectModel: objectModel)
                        }else {
                            
                            (self.eventsArray.count > 0) ? (self.noDataFoundEventsLable.isHidden = true) : (self.noDataFoundEventsLable.isHidden = false)
                            (self.projectsArray.count > 0) ? (self.noDataFoundProjectsLable.isHidden = true) : (self.noDataFoundProjectsLable.isHidden = false)
                            (self.clientsArray.count > 0) ? (self.noDataFoundClientsLable.isHidden = true) : (self.noDataFoundClientsLable.isHidden = false)
                            Utility.showAlert(message: objectModel.message)
                        }
                    }
                }
                
            }catch {
                print(error.localizedDescription)
            }
        }
    }
    
    
    //MARK: - API Processing Methods
    //MARK: -
    
    func getData(objectModel: DashboardObject) {
        self.eventsArray = objectModel.event_data as! [EventsModel]
        self.projectsArray = objectModel.project_data as! [ProjectsModel]
        self.clientsArray = objectModel.client_data as! [ClientModel]
        self.coursesArray = objectModel.course_data as! [CourseModel]
        
        self.newsletterCollectionView.reloadData()
        self.clientsCollectionView.reloadData()
        self.eventsCollectionView.reloadData()
        self.projectsCollectionView.reloadData()
    }
    
    
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
    
    @IBAction func facebookBtnClicked(_ sender: UIButton) {
        
        let webViewController : WebViewController
        
        if #available(iOS 13.0, *) {
            webViewController = Constants.Storyboards.main.instantiateViewController(identifier: "WebViewController") as! WebViewController
        } else {
            // Fallback on earlier versions
            webViewController = Constants.Storyboards.main.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        }
        webViewController.url = Constants.HardcodedData.facebookUrl
        navigationController?.pushViewController(webViewController, animated: true)
    }
    
    @IBAction func twiterBtnClicked(_ sender: UIButton) {
        let webViewController : WebViewController
        
        if #available(iOS 13.0, *) {
            webViewController = Constants.Storyboards.main.instantiateViewController(identifier: "WebViewController") as! WebViewController
        } else {
            // Fallback on earlier versions
            webViewController = Constants.Storyboards.main.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        }
        webViewController.url = Constants.HardcodedData.twitterUrl
        navigationController?.pushViewController(webViewController, animated: true)
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
    
    //MARK: - Login Delegate methods
    //MARK: -
    func loginBtnClicked() {
        loginHandler()
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
        
        let courseListVC : CourseListingViewController
        
        if #available(iOS 13.0, *) {
            courseListVC = Constants.Storyboards.main.instantiateViewController(identifier: "CourseListingViewController") as! CourseListingViewController
        } else {
            // Fallback on earlier versions
            courseListVC = Constants.Storyboards.main.instantiateViewController(withIdentifier: "CourseListingViewController") as! CourseListingViewController
        }
        
        
//        courseListVC.coursesArray = coursesArray
        navigationController?.pushViewController(courseListVC, animated: true)
    }
    
    @IBAction func contactUsClicked(_ sender: UIButton) {
        
        let contactUsVC : ContactUsViewController
        
        if #available(iOS 13.0, *) {
            contactUsVC = Constants.Storyboards.main.instantiateViewController(identifier: "ContactUsViewController") as! ContactUsViewController
        } else {
            // Fallback on earlier versions
            contactUsVC = Constants.Storyboards.main.instantiateViewController(withIdentifier: "ContactUsViewController") as! ContactUsViewController
        }
        
        navigationController?.pushViewController(contactUsVC, animated: true)
    }
    
    @IBAction func logoutBtnClicked(_ sender: UIButton) {
        
        if isLoggedIn == true {
            let alert = UIAlertController.init(title: "Message".localised(), message: "Are you want to logout?".localised(), preferredStyle: .alert)
            let cancel = UIAlertAction.init(title: "CANCEL".localised(), style: .default, handler: nil)
            let action = UIAlertAction.init(title: "OK".localised(), style: .default) { (action) in
                
                UserDefaults.standard.set(false, forKey: Constants.UserDefaults.isUserLogin)
                UserDefaults.standard.set(nil, forKey: Constants.UserDefaults.userDetails)
                UserDefaults.standard.synchronize()
                
                self.loginHandler()
                self.hideSideMenu()
                
            }
            alert.addAction(cancel);
            alert.addAction(action);
            self.present(alert, animated: true, completion: nil)
        }else {
            
            let loginVC : LoginViewController
            
            if #available(iOS 13.0, *) {
                loginVC = Constants.Storyboards.main.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
            } else {
                // Fallback on earlier versions
                loginVC = Constants.Storyboards.main.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            }
            loginVC.isFromDashboard = true
            self.present(loginVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func eventBtnClicked(_ sender: UIButton) {
        isEventsExpanded ? hideEventsView() : showEventsView()
    }
    
    @IBAction func event2TapAction(_ sender: UITapGestureRecognizer) {
        
        let contactUsVC : Event2ViewController
        
        if #available(iOS 13.0, *) {
            contactUsVC = Constants.Storyboards.main.instantiateViewController(identifier: "Event2ViewController") as! Event2ViewController
        } else {
            // Fallback on earlier versions
            contactUsVC = Constants.Storyboards.main.instantiateViewController(withIdentifier: "Event2ViewController") as! Event2ViewController
        }
        
        navigationController?.pushViewController(contactUsVC, animated: true)
    }
    
    @IBAction func event3TapAction(_ sender: UITapGestureRecognizer) {
        
        let contactUsVC : Event3ViewController
        
        if #available(iOS 13.0, *) {
            contactUsVC = Constants.Storyboards.main.instantiateViewController(identifier: "Event3ViewController") as! Event3ViewController
        } else {
            // Fallback on earlier versions
            contactUsVC = Constants.Storyboards.main.instantiateViewController(withIdentifier: "Event3ViewController") as! Event3ViewController
        }
        navigationController?.pushViewController(contactUsVC, animated: true)
        
    }
    
    @IBAction func event1TapAction(_ sender: UITapGestureRecognizer) {
        
        let contactUsVC : Event1ViewController
        
        if #available(iOS 13.0, *) {
            contactUsVC = Constants.Storyboards.main.instantiateViewController(identifier: "Event1ViewController") as! Event1ViewController
        } else {
            // Fallback on earlier versions
            contactUsVC = Constants.Storyboards.main.instantiateViewController(withIdentifier: "Event1ViewController") as! Event1ViewController
        }
        
        navigationController?.pushViewController(contactUsVC, animated: true)
    }
    
    
    @IBAction func settingsBtnClicked(_ sender: UIButton) {
        
        let contactUsVC : SettingsViewController
        
        if #available(iOS 13.0, *) {
            contactUsVC = Constants.Storyboards.main.instantiateViewController(identifier: "SettingsViewController") as! SettingsViewController
        } else {
            // Fallback on earlier versions
            contactUsVC = Constants.Storyboards.main.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        }
        navigationController?.pushViewController(contactUsVC, animated: true)
    }
    
    @IBAction func event4TapAction(_ sender: UITapGestureRecognizer) {
    }
    
    @IBAction func seeAllCoursesTapHandler(_ sender: UITapGestureRecognizer) {
        
        let courseListVC : CourseListingViewController
        
        if #available(iOS 13.0, *) {
            courseListVC = Constants.Storyboards.main.instantiateViewController(identifier: "CourseListingViewController") as! CourseListingViewController
        } else {
            // Fallback on earlier versions
            courseListVC = Constants.Storyboards.main.instantiateViewController(withIdentifier: "CourseListingViewController") as! CourseListingViewController
        }
        
//        courseListVC.coursesArray = coursesArray
        navigationController?.pushViewController(courseListVC, animated: true)
    }
    @IBAction func seeAllLatestNewsTapHandler(_ sender: UITapGestureRecognizer) {
        
        let courseListVC : LatestNewsViewController
        
        if #available(iOS 13.0, *) {
            courseListVC = Constants.Storyboards.main.instantiateViewController(identifier: "LatestNewsViewController") as! LatestNewsViewController
        } else {
            // Fallback on earlier versions
            courseListVC = Constants.Storyboards.main.instantiateViewController(withIdentifier: "LatestNewsViewController") as! LatestNewsViewController
        }
        
        //        courseListVC.eventsArray = eventsArray
        navigationController?.pushViewController(courseListVC, animated: true)
        
    }
    @IBAction func seeAllProjectsTapHandler(_ sender: UITapGestureRecognizer) {
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
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //courses collectionview
        if collectionView == newsletterCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath) as! NewsLetterCell
            
            if let lang = UserDefaults.standard.value(forKey: Constants.UserDefaults.selectedLanguage) as? String {
                if lang == "Arabic".localised() {
                    cell.contentLabel.textAlignment = .left
                }
            }
            
            let coursesObj = coursesArray[indexPath.row]
            cell.articleLabel.text = coursesObj.heading + " | "
            cell.contentLabel.text = "Course Duration".localised() + " : " + coursesObj.duration
            cell.courseDateLabel.text = "Course Start Date".localised() + " : " + coursesObj.start_date
            cell.baseView.elevate(elevation: 2.0)
            return cell
            
        }else if collectionView == projectsCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "projectsCell", for: indexPath) as! ProjectsCollectionViewCell
            
            let projectsObj = projectsArray[indexPath.row]
            cell.titleLabel.text = projectsObj.name
            cell.durationLabel.text = "Duration".localised() + " : " + projectsObj.duration
            cell.clientNameLabel.text = "Client".localised() + " : " + projectsObj.client_name
            cell.baseView.elevate(elevation: 2.0)
            return cell
            
        }else if collectionView == eventsCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventsCell", for: indexPath) as! EventsCollectionViewCell
            
            let eventsObj = eventsArray[indexPath.row]
            cell.eventImage.downloaded(from: eventsObj.image, contentMode: .scaleToFill)
            cell.dateLabel.text = eventsObj.event_date
            cell.titleLabel.text = eventsObj.details
            cell.baseView.elevate(elevation: 2.0)
            return cell
            
        }else if collectionView == self.clientsCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "clientsCell", for: indexPath) as! ClientsCell
            let clientObj = clientsArray[indexPath.row]
            cell.image.downloaded(from: clientObj.image, contentMode: .scaleAspectFit)
            cell.baseView.elevate(elevation: 2.0)
            return cell
            
        }else if collectionView == self.collectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PromotiosCell
            cell.image.image = UIImage.init(named: "promotion1")
            //            let promotionObject = promotionalBanner[indexPath.row]
            //            cell.image.image = UIImage.init(named: promotionObject.image)
            //            cell.categoryLabel.text = promotionObject.category
            return cell
        }else {
            let cell = UICollectionViewCell()
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
            return CGSize.init(width: self.width , height: 200)
        }
    }
}

extension DashboardVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenuOptionsArray[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sideMenuOptionsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let lang = UserDefaults.standard.value(forKey: Constants.UserDefaults.selectedLanguage) as? String {
            if lang == "Arabic".localised() {
                cell.textLabel?.textAlignment = .left
            }else {
                cell.textLabel?.textAlignment = .right
            }
        }
        
        cell.textLabel?.text = sideMenuOptionsArray[indexPath.section][indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let selectedValue = sideMenuOptionsArray[indexPath.section][indexPath.row]
            switch selectedValue {
            case "Online Courses".localised():
                let courseListVC : CourseListingViewController
                
                if #available(iOS 13.0, *) {
                    courseListVC = Constants.Storyboards.main.instantiateViewController(identifier: "CourseListingViewController") as! CourseListingViewController
                } else {
                    // Fallback on earlier versions
                    courseListVC = Constants.Storyboards.main.instantiateViewController(withIdentifier: "CourseListingViewController") as! CourseListingViewController
                }
                
//                courseListVC.coursesArray = coursesArray
                navigationController?.pushViewController(courseListVC, animated: true)
                
            case "Latest News".localised():
                let courseListVC : LatestNewsViewController
                
                if #available(iOS 13.0, *) {
                    courseListVC = Constants.Storyboards.main.instantiateViewController(identifier: "LatestNewsViewController") as! LatestNewsViewController
                } else {
                    // Fallback on earlier versions
                    courseListVC = Constants.Storyboards.main.instantiateViewController(withIdentifier: "LatestNewsViewController") as! LatestNewsViewController
                }
                navigationController?.pushViewController(courseListVC, animated: true)
                
            case "Settings".localised():
                let contactUsVC : SettingsViewController
                
                if #available(iOS 13.0, *) {
                    contactUsVC = Constants.Storyboards.main.instantiateViewController(identifier: "SettingsViewController") as! SettingsViewController
                } else {
                    // Fallback on earlier versions
                    contactUsVC = Constants.Storyboards.main.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
                }
                navigationController?.pushViewController(contactUsVC, animated: true)
                
            case "Our Services".localised():
                
                let contactUsVC : ServicesViewController
                
                if #available(iOS 13.0, *) {
                    contactUsVC = Constants.Storyboards.main.instantiateViewController(identifier: "ServicesViewController") as! ServicesViewController
                } else {
                    // Fallback on earlier versions
                    contactUsVC = Constants.Storyboards.main.instantiateViewController(withIdentifier: "ServicesViewController") as! ServicesViewController
                }
                
                navigationController?.pushViewController(contactUsVC, animated: true)
                
            case "Our Clients".localised():
                
                let contactUsVC : ClientsListingViewController
                
                if #available(iOS 13.0, *) {
                    contactUsVC = Constants.Storyboards.main.instantiateViewController(identifier: "ClientsListingViewController") as! ClientsListingViewController
                } else {
                    // Fallback on earlier versions
                    contactUsVC = Constants.Storyboards.main.instantiateViewController(withIdentifier: "ClientsListingViewController") as! ClientsListingViewController
                }
                navigationController?.pushViewController(contactUsVC, animated: true)
                
            case "Contact Us".localised():
                let contactUsVC : ContactUsViewController
                
                if #available(iOS 13.0, *) {
                    contactUsVC = Constants.Storyboards.main.instantiateViewController(identifier: "ContactUsViewController") as! ContactUsViewController
                } else {
                    // Fallback on earlier versions
                    contactUsVC = Constants.Storyboards.main.instantiateViewController(withIdentifier: "ContactUsViewController") as! ContactUsViewController
                }
                navigationController?.pushViewController(contactUsVC, animated: true)
                
                
            default:
                return
            }
        }else if indexPath.section == 1 {
            let selectedValue = sideMenuOptionsArray[indexPath.section][indexPath.row]
            
            if isLoggedIn {
                if selectedValue == "Logout".localised() {
                    let alert = UIAlertController.init(title: "Message".localised(), message: "Are you want to logout?".localised(), preferredStyle: .alert)
                    let cancel = UIAlertAction.init(title: "CANCEL".localised(), style: .default, handler: nil)
                    let action = UIAlertAction.init(title: "OK".localised(), style: .default) { (action) in
                        
                        UserDefaults.standard.set(false, forKey: Constants.UserDefaults.isUserLogin)
                        UserDefaults.standard.set(nil, forKey: Constants.UserDefaults.userDetails)
                        UserDefaults.standard.synchronize()
                        
                        self.loginHandler()
                        self.hideSideMenu()
                    }
                    alert.addAction(cancel);
                    alert.addAction(action);
                    self.present(alert, animated: true, completion: nil)
                    
                }
            }else {
                switch selectedValue {
                case "Login".localised():
                    
                    let loginVC : LoginInfoViewController
                    if #available(iOS 13.0, *) {
                        loginVC = Constants.Storyboards.main.instantiateViewController(identifier: "LoginInfoViewController") as! LoginInfoViewController
                    } else {
                        // Fallback on earlier versions
                        loginVC = Constants.Storyboards.main.instantiateViewController(withIdentifier: "LoginInfoViewController") as! LoginInfoViewController
                    }
                    
                    let navController = UINavigationController.init(rootViewController: loginVC)
                    loginVC.isFromDashboard = true
                    self.present(navController, animated: true, completion: nil)
                    
                case "Register".localised():
                    
                    let signUpVC : SignUpViewController
                    if #available(iOS 13.0, *) {
                        signUpVC = Constants.Storyboards.main.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
                    } else {
                        // Fallback on earlier versions
                        signUpVC = Constants.Storyboards.main.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
                    }
                    
                    let navController = UINavigationController.init(rootViewController: signUpVC)
                    signUpVC.isFromDashboard = true
                    self.present(navController, animated: true, completion: nil)
                    
                default:
                    return
                }
            }
        }
    }
}

class DashboardObject: Mappable {
    var success: Bool = false
    var message: String = ""
    var news_data = [NewsModel]()
    var client_data = [ClientModel]()
    var project_data = [ProjectsModel]()
    var event_data = [EventsModel]()
    var course_data = [CourseModel]()
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        news_data <- map["news_data"]
        client_data <- map["client_data"]
        project_data <- map["project_data"]
        event_data <- map["event_data"]
        course_data <- map["course_data"]
    }
}

class NewsModel: Mappable {
    var id: Int = 0
    var heading: String = ""
    var details: String = ""
    var published_on: String = ""
    var image: String = ""
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        heading <- map["heading"]
        details <- map["details"]
        published_on <- map["published_on"]
        image <- map["image"]
    }
}

class ClientModel: Mappable {
    var id: Int = 0
    var name: String = ""
    var website: String = ""
    var details: String = ""
    var mobile: String = ""
    var image: String = ""
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        website <- map["website"]
        details <- map["details"]
        mobile <- map["mobile"]
        image <- map["image"]
    }
}

class ProjectsModel: Mappable {
    var id: Int = 0
    var name: String = ""
    var details: String = ""
    var duration: String = ""
    var client_name: String = ""
    var image: String = ""
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        details <- map["details"]
        duration <- map["duration"]
        client_name <- map["client_name"]
        image <- map["image"]
    }
}

class EventsModel: Mappable {
    var id: Int = 0
    var heading: String = ""
    var details: String = ""
    var event_date: String = ""
    var image: String = ""
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        heading <- map["heading"]
        details <- map["details"]
        event_date <- map["event_date"]
        image <- map["image"]
    }
}

class CourseModel: Mappable {
    var id: Int = 0
    var heading: String = ""
    var details: String = ""
    var duration: String = ""
    var applied_count: Int = 0
    var start_date: String = ""
    var image: String = ""
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        heading <- map["heading"]
        details <- map["details"]
        duration <- map["duration"]
        applied_count <- map["applied_count"]
        start_date <- map["start_date"]
        image <- map["image"]
    }
}






