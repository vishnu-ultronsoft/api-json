//
//  ShowViewController.swift
//  jsonApi
//
//  Created by vishnu saini on 17/02/22.
//

import UIKit
import Alamofire
import AlamofireSwiftyJSON

class ShowViewController: UIViewController {
    
    var modaleArr1: WelcomeElement!
   // var empolyee: Employee!

    @IBOutlet weak var imgFullView: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLable.text = modaleArr1.title
       // imgFullView.image = modaleArr1.thumbnailURL as? String
        
        let imageUrl = modaleArr1.url as? String

           Alamofire.request(imageUrl!, method: .get).response { response in
               guard let image = UIImage(data:response.data!) else {
                   // Handle error
                   return
               }
               let imageData = image.jpegData(compressionQuality: 1.0)
               self.imgFullView.image = image
           }

        // Do any additional setup after loading the view.
    }
    @IBAction func btnShowImage(_ sender: Any) {
        
        let datail: ImageCollectionViewController = self.storyboard?.instantiateViewController(withIdentifier: "ImageCollectionViewController") as! ImageCollectionViewController
        datail.modelArr = self.modaleArr1[indexPath.row]
       // print(self.modaleArr[indexPath.row])
        
        self.navigationController?.pushViewController(datail, animated: true)
        
    }
    
}
