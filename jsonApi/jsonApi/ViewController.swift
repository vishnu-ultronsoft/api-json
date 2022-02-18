//
//  ViewController.swift
//  jsonApi
//
//  Created by vishnu saini on 17/02/22.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireSwiftyJSON


class ViewController: UIViewController {
    
   var modaleArr = [WelcomeElement]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        GetData()
        
        // Do any additional setup after loading the view.
    }
    
    func GetData()  {
        
        let urlFile = "https://jsonplaceholder.typicode.com/albums/1/photos"

        Alamofire.request(urlFile)
          .responseJSON { response in
              switch (response.result) {

                          case .success( _):

                          do {
                              let users = try JSONDecoder().decode([WelcomeElement].self, from: response.data!)
                              self.modaleArr = users
                              DispatchQueue.main.async {
                                  self.tableView.reloadData()
                              }
                              print(users)

                          } catch let error as NSError {
                              print("Failed to load: \(error.localizedDescription)")
                          }

                           case .failure(let error):
                              print("Request error: \(error.localizedDescription)")
                       }


        }
        
        
    }


}

extension ViewController: UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modaleArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell
        cell.lblTitle.text  = modaleArr[indexPath.row].title
        
        
        //cell.imgView.image = modaleArr[indexPath.row].thumbnailURL as? String ??
        
        
        let imageUrl = modaleArr[indexPath.row].thumbnailURL as? String

           Alamofire.request(imageUrl!, method: .get).response { response in
               guard let image = UIImage(data:response.data!) else {
                   // Handle error
                   return
               }
               let imageData = image.jpegData(compressionQuality: 1.0)
               cell.imgView.image = image
           }
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        let datail: ShowViewController = self.storyboard?.instantiateViewController(withIdentifier: "ShowViewController") as! ShowViewController
        datail.modaleArr1 = modaleArr[indexPath.row]
        print(self.modaleArr[indexPath.row])
        
        self.navigationController?.pushViewController(datail, animated: true)
      
    }
    
  
}
