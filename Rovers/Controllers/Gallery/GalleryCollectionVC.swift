//
//  GalleryCollectionVC.swift
//  Rovers
//
//  Created by Peter Irving on 11/10/19.
//  Copyright © 2019 Peter Irving. All rights reserved.
//

import UIKit

class GalleryCollectionVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var images: [Photo] = []
    var rover: String!
    let flowLayout = UICollectionViewFlowLayout()
    var shouldFetch = false
    var selectedImageIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImages()
        self.title = rover.uppercased()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
  
        let numberAcross: CGFloat = 3
        let remainingSpace = collectionView.bounds.width
                            - flowLayout.sectionInset.left
                            - flowLayout.sectionInset.right
                            - flowLayout.minimumInteritemSpacing * (numberAcross - 1)
        let dimension = remainingSpace / numberAcross
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        collectionView.collectionViewLayout = flowLayout
    }
     
    func showNetworkErrorAlert(message: String) {
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "There was an error fetching images", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay"
                , style: .cancel, handler: { (action) in
                    self.dismiss(animated: false, completion: nil)
                self.navigationController!.popToRootViewController(animated: true)
            }))
            self.present(alert, animated: true)
        }
    }
    
    func fetchImages() {
        if NetworkingClient.shared.morePages == false {
            return
        }
        NetworkingClient.shared.fetch(rover: rover) { (images, error) in
            if let error = error {
                self.showNetworkErrorAlert(message: error.localizedDescription)
                return
            }
            if let returnedImages = images {
                self.images.append(contentsOf: returnedImages)
                self.shouldFetch = true
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
     
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
         selectedImageIndex = indexPath.row
         performSegue(withIdentifier: "EnlargedImageSegue", sender: self)
     }
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         
         if segue.destination is EnlargedImageVC {
             let vc = segue.destination as? EnlargedImageVC
             vc?.image = images[selectedImageIndex]
         }
     }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! PhotoCell
        cell.setupCell(photo: images[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
    
        guard let footerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: "Footer",
            for: indexPath) as? LoadingFooter
        else {
            fatalError("Invalid view type")
        }
        return footerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {

        if NetworkingClient.shared.page == 1 {
            return CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height)
        }
        else if NetworkingClient.shared.morePages == false {
            return CGSize(width: self.view.frame.size.width, height: 0)
        } else {
            return CGSize(width: self.view.frame.size.width, height: 100)
        }
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
    
        if offsetY > contentHeight - (scrollView.frame.height * 1.7)  {
            if shouldFetch == true {
                shouldFetch = !shouldFetch
                fetchImages()
            }
        }
    }
}
