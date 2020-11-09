//
//  ClientsListingViewController.swift
//  p4b
//
//  Created by Sagar Ranshur on 20/07/20.
//  Copyright © 2020 Sagar Ranshur. All rights reserved.
//

import UIKit
import ObjectMapper

class ClientsListingViewController: UIViewController {

    @IBOutlet weak var customNavigationBar: UIView!
    @IBOutlet weak var clientsCollectionView: UICollectionView!
    
    var clientsArray = [ClientModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        customNavigationBar.elevate(elevation: 2.0)
        getClientListing()
    }
    
    //MARK: - API CALL Method
    //MARK: -
    
    func getClientListing()  {
        
        Utility.startIndicator()
    
        WebService.requestServiceWithPostMethod(url: Constants.singleton.hostName, requestType: Constants.RequestType.client) { (data, error) in
            
            do {
                Utility.hideIndicator()
                
                if let jsonData = data {
                    let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String : Any]
                    
                    if let objectModel = ClientListObject.init(JSON: json!) {
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
    
    func getData(objectModel: ClientListObject) {
        self.clientsArray = objectModel.data as! [ClientModel]
        self.clientsCollectionView.reloadData()
    }
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension ClientsListingViewController: UICollectionViewDelegate,UICollectionViewDataSource  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return clientsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //courses collectionview
         if collectionView == self.clientsCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "clientsCell", for: indexPath) as! ClientsCell
            let obj = clientsArray[indexPath.row]
            cell.image.downloaded(from: obj.image, contentMode: .scaleToFill)
            cell.baseView.elevate(elevation: 2.0)
            return cell
            
        }else {
            let cell = UICollectionViewCell()
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 128, height: 128)
    }
}

class ClientListObject: Mappable {
    var success: Bool = false
    var message: String = ""
    var data = [ClientModel]()
   
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        data <- map["data"]
    }
}
