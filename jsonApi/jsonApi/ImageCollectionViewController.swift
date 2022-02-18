//
//  ImageCollectionViewController.swift
//  jsonApi
//
//  Created by vishnu saini on 17/02/22.
//

import UIKit
import Alamofire
import AlamofireSwiftyJSON

private let reuseIdentifier = "Cell"

class ImageCollectionViewController: UICollectionViewController {
    
    var modelArr: [WelcomeElement]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }



    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return modelArr.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! imgCollectionViewCell
    
        // Configure the cell
        let imageUrl = modelArr[indexPath.row].thumbnailURL as? String

           Alamofire.request(imageUrl!, method: .get).response { response in
               guard let image = UIImage(data:response.data!) else {
                   // Handle error
                   return
               }
               let imageData = image.jpegData(compressionQuality: 1.0)
              
               cell.imagView.image = image

           }
        
        
    
        return cell
    }

}
