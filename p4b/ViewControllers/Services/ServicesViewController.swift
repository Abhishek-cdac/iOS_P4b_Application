//
//  ServicesViewController.swift
//  p4b
//
//  Created by Sagar Ranshur on 20/07/20.
//  Copyright © 2020 Sagar Ranshur. All rights reserved.
//

import UIKit

class ServicesViewController: UIViewController {

    @IBOutlet weak var customNavigationBar: UIView!
    @IBOutlet weak var servicesTableView: UITableView!
    
    var ourServicesArray = [Service]()
    struct Service {
        var image: String?
        var name: String?
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         //addCompanyLogoWithTable(scroll: servicesTableView)
        customNavigationBar.elevate(elevation: 2.0)
        ourServicesArray = [Service.init(image: "integration", name: "P4BERP - Integrated Business System".localised()), Service.init(image: "paymentGateway", name: "Online Payment Gateway".localised()), Service.init(image: "webDesign", name: "Web Design".localised())];
        servicesTableView.reloadData()
    }
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension ServicesViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ourServicesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ServicesTableViewCell
        
        cell.baseView.elevate(elevation: 2.0)
        let serviceObj = ourServicesArray[indexPath.row]
        cell.integrationImage.image = UIImage.init(named: serviceObj.image!)
        cell.titleLabel.text = serviceObj.name
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150;
    }
}
