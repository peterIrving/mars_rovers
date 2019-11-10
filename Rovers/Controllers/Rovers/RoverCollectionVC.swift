//
//  RoverCollectionVC.swift
//  Rovers
//
//  Created by Peter Irving on 11/10/19.
//  Copyright © 2019 Peter Irving. All rights reserved.
//

import UIKit

class RoverCollectionVC: UICollectionViewController {
    
    let rovers = ["Curiosity", "Opportunity", "Spirit"]
    let flowLayout = UICollectionViewFlowLayout()
    var selectedRoverString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let roverCount: CGFloat = CGFloat(rovers.count)
        let remainingSpace = collectionView.bounds.width
                            - flowLayout.sectionInset.left
                            - flowLayout.sectionInset.right
            - (flowLayout.minimumInteritemSpacing * (roverCount - 1))
        let width = remainingSpace
        let height = collectionView.bounds.height
        flowLayout.itemSize = CGSize(width: width, height: height * 0.31)
        collectionView.collectionViewLayout = flowLayout
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rovers.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoverCell", for: indexPath) as! RoverCell

        cell.setupCell(roverName: rovers[indexPath.row])

        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedRoverString = rovers[indexPath.row].lowercased()
        resetNetworkingClient()
        performSegue(withIdentifier: "GoToGallery", sender: self)
    }
    
    func resetNetworkingClient() {
        NetworkingClient.shared.page = 1
        NetworkingClient.shared.morePages = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

       if segue.destination is GalleryCollectionVC {
           let vc = segue.destination as? GalleryCollectionVC
           vc?.rover = selectedRoverString
       }
    }
}
