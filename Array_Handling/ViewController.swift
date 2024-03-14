//
//  ViewController.swift
//  Array_Handling
//
//  Created by mspc-68 on 13/03/24.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var collectionExeLibrary: UICollectionView!
    
    var arrExeLibrary = [ExeLibraryDataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.uiInitialSetup()
        self.callApi()
       
    }

    func uiInitialSetup(){
        
        self.collectionExeLibrary.register(UINib(nibName: "ExerciseCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ExerciseCollectionViewCell")
        
    }
    func callApi(){
       
        var myurl = Wsurl.exerciselibrary
        let param = ["device_id":"150B4AC1-D968-473E-AE90-D37291CEA2E5",
                     "auth_customer_id":"1cbd5dab4f76d009a2aa001896669a28a4366e0af962bb910e90246650145f3f",
                     "added_by_type":"Admin","page_index":"1","device_token":"fCoLlghdpEpSguAZIj0_oy:APA91bGwHID3PcFtKOu1phbFRb-6nqyFN8HCwTDnNU6yZaVsPJDJPUDlt_oCFDFKrXYRjxUbrJtmD4-AkttmVDNm560imC3sEIl26-s0elRQXbmrsw4FsS4kdY8ruygmi_1UGjcs-0Vc","device_type":"Ios"]
        let headers: HTTPHeaders = ["AUTHTOKEN":"1cbd5dab4f76d009a2aa001896669a28a4366e0af962bb910e90246650145f3f","APIKEY":"HBDEV","APIVERSION":"1"]
        
        AF.request(myurl,method:.get ,parameters: param,headers: headers).responseJSON{
            response in
           // print(response)
            if response.data != nil{
                do {
                    let object = try JSONSerialization.jsonObject(with: response.data!,options: JSONSerialization.ReadingOptions.fragmentsAllowed) as? [String:Any]
                    if let data = object!["data"] as? [[String:Any]]{
                        for obj in data{
                            let modeldata = ExeLibraryDataModel(dict: obj)
                            self.arrExeLibrary.append(modeldata)
                        }
                        self.collectionExeLibrary.reloadData()
                    }
                    print(self.arrExeLibrary.count)
                }catch{
                    error
                }
            }
        }
    }
}

extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.arrExeLibrary.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.collectionExeLibrary.dequeueReusableCell(withReuseIdentifier: "ExerciseCollectionViewCell", for: indexPath) as! ExerciseCollectionViewCell
        
        let data = arrExeLibrary[indexPath.item]
        
        cell.lblExeTypeName.text = data.display_name
        return cell
    }
    
    
}
