//
//  LatestNewsViewController.swift
//  p4b
//
//  Created by Sagar Ranshur on 20/07/20.
//  Copyright © 2020 Sagar Ranshur. All rights reserved.
//



import UIKit
import ObjectMapper

class LatestNewsViewController: UIViewController {
    
    @IBOutlet weak var navTitle: UILabel!
    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var customNavigationBar: UIView!
    
    var eventsArray = [EventsModel]()
    var newsArray = [NewsModel]()
    var projectsArray = [ProjectsModel]()
    
    var lblTitle : String?
    var selectedValueForTable : String?
    
    struct Event {
        var image: String
        var date: String
        var title: String
    }
    
    struct News {
        var image: String
        var date: String
        var title: String
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        newsTableView.register(UINib(nibName: "ProjectsTableCell", bundle: nil), forCellReuseIdentifier: "ProjectsTableCell")
        self.navTitle.text = lblTitle
        customNavigationBar.elevate(elevation: 2.0)
        
        print("Selected subdomain value is :\(String(describing: selectedValueForTable))")
        getEventListing(selectedEventType: selectedValueForTable ?? "news")
        
    }
    
    //MARK: - API CALL Method
    //MARK: -
      
    func getEventListing(selectedEventType : String)  {
        
        Utility.startIndicator()
        
        WebService.requestServiceWithPostMethod(url: Constants.singleton.hostName, requestType:  selectedEventType) { (data, error) in
            
            do {
                Utility.hideIndicator()
                
                if let jsonData = data {
                    let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String : Any]
                    
                    
                    if self.navTitle.text == "News".localised(){
                        if let objectModel = EventObject.init(JSON: json!) {
                            if objectModel.success == true {
                                
                                self.getData(objectModel: objectModel)
                                
                            }
                        }
                         
                    }else{
                        if let objectModel = ProjectObject.init(JSON: json!) {
                            if objectModel.success == true {
                                
                               self.getDataForProject(objectModel: objectModel)
                                
                            }
                        }
                        
                    }
                     
                }else {
                    print("receive nil data")
                }
                
            }catch {
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK:- News Delete
    
    func newsAndProjectDeleteAPI(id:Int) {
        
        Utility.startIndicator()
        
        var requestparameters = [String : Any]()
        var requestType = ""
        if navTitle.text == "News".localised(){
            requestparameters = ["news_id" : id
                                    ] as [String : Any]
            requestType = Constants.RequestType.news_delete
        }else{
            requestparameters = ["project_id" : id
                                    ] as [String : Any]
            requestType = Constants.RequestType.project_delete
        }
        
        
       
        WebService.requestServiceWithParametersPostMethod(url: Constants.singleton.hostName, requestType: requestType, parameters: requestparameters) { (data, error) in
            do {
                
                Utility.hideIndicator()
                
                if let jsonData = data {
                    let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String : Any]
                    if let loginDetailsObject = LoginModel.init(JSON: json!)
                    {
                        if loginDetailsObject.success == true {
                            self.getEventListing(selectedEventType: self.selectedValueForTable ?? "news")
                        }else {
                            Utility.showAlert(message: loginDetailsObject.message)
                        }
                    }
                }else {
                    Utility.showAlert(message: Constants.validationMesages.tryAgainError)
                }
                
            }catch {
                Utility.showAlert(message: Constants.validationMesages.tryAgainError)
            }
        }
        
    }
    
    //MARK: - API Processing Methods
    //MARK: -
    
    func getData(objectModel: EventObject) {
        self.newsArray = objectModel.data
        self.newsTableView.reloadData()
    }
    
    func getDataForProject(objectModel: ProjectObject) {
        self.projectsArray = objectModel.data
        print("Projects are:\(self.projectsArray)")
        self.newsTableView.reloadData()
    }
    
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension LatestNewsViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if navTitle.text == "News".localised(){
            return self.newsArray.count
        }else{
            return self.projectsArray.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if navTitle.text == "News".localised(){
            let cell = newsTableView.dequeueReusableCell(withIdentifier: "latestNewsCell", for: indexPath) as! LatestNewsTableViewCell
            
            let coursesObj = newsArray[indexPath.row]
            cell.eventImage.downloaded(from: coursesObj.image, contentMode: .scaleToFill)
            cell.dateLabel.text = coursesObj.published_on
            cell.titlelabel.text = coursesObj.heading
            cell.baseView.elevate(elevation: 2.0)
            cell.deleteButton.tag = indexPath.row
            cell.deleteButton.addTarget(self, action: #selector(self.deleteButtonAction(_:)), for: .touchUpInside)
            return cell
            
        }else{
           
               let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectsTableCell") as? ProjectsTableCell
                
                let projObj = projectsArray[indexPath.row]
                cell!.lblHeading.text = projObj.name
                cell!.lblClient.text = projObj.client_name
                cell!.lblDuration.text  = projObj.duration
                cell!.baseView.elevate(elevation: 2.0)
            cell?.deleteButton.tag = indexPath.row
            cell?.deleteButton.addTarget(self, action: #selector(self.deleteButtonAction(_:)), for: .touchUpInside)
 
            return cell!
         }
        
    }
    @objc func deleteButtonAction(_ sender: UIButton) {
        alert(index: sender.tag)
    }
    
    func alert(index:Int){
        let alert = UIAlertController(title: "Confirm", message: "Are yo sure you want to delete?", preferredStyle: .alert)
            
             let ok = UIAlertAction(title: "Yes", style: .default, handler: { action in
                if self.navTitle.text == "News".localised(){
                    let coursesObj = self.newsArray[index]
                    self.newsAndProjectDeleteAPI(id: coursesObj.id)
               }else {
                let projObj = self.projectsArray[index]
                self.newsAndProjectDeleteAPI(id: projObj.id)
                }
             })
             alert.addAction(ok)
             let cancel = UIAlertAction(title: "No", style: .default, handler: { action in
             })
             alert.addAction(cancel)
             DispatchQueue.main.async(execute: {
                self.present(alert, animated: true)
             })
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if navTitle.text == "News".localised(){
            return 250
        }else{
            return 115
        }
        
        
    }
}

class EventObject: Mappable {
    var success: Bool = false
    var message: String = ""
    var data = [NewsModel]()
    
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        data <- map["data"]
    }
}

class ProjectObject: Mappable {
    var success: Bool = false
    var message: String = ""
    var data = [ProjectsModel]()
    
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        data <- map["data"]
    }
}
