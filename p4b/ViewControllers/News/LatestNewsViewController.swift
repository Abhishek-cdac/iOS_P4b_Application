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

    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var customNavigationBar: UIView!
    
    var eventsArray = [EventsModel]()
    
    struct Event {
        var image: String
        var date: String
        var title: String
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customNavigationBar.elevate(elevation: 2.0)
        getEventListing()
    }
    
    //MARK: - API CALL Method
    //MARK: -
    
    func getEventListing()  {
        
        Utility.startIndicator()
    
        WebService.requestServiceWithPostMethod(url: Constants.singleton.hostName, requestType: Constants.RequestType.event) { (data, error) in
            
            do {
                Utility.hideIndicator()
                
                if let jsonData = data {
                    let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String : Any]
                    
                    if let objectModel = EventObject.init(JSON: json!) {
                        if objectModel.success == true {
                            self.getData(objectModel: objectModel)
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
    
    //MARK: - API Processing Methods
    //MARK: -
    
    func getData(objectModel: EventObject) {
        self.eventsArray = objectModel.data as! [EventsModel]
        self.newsTableView.reloadData()
    }
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension LatestNewsViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTableView.dequeueReusableCell(withIdentifier: "latestNewsCell", for: indexPath) as! LatestNewsTableViewCell
        
        let coursesObj = eventsArray[indexPath.row]
        cell.eventImage.downloaded(from: coursesObj.image, contentMode: .scaleToFill)
        cell.dateLabel.text = coursesObj.event_date
        cell.titlelabel.text = coursesObj.heading
        cell.baseView.elevate(elevation: 2.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}

class EventObject: Mappable {
    var success: Bool = false
    var message: String = ""
    var data = [EventsModel]()
   
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        data <- map["data"]
    }
}
