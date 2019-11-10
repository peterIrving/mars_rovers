//
//  PhotoCell.swift
//  Rovers
//
//  Created by Peter Irving on 11/10/19.
//  Copyright © 2019 Peter Irving. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func setupCell(photo: Photo) {
        if let urlString = photo.imgSrc {
            let imgUrl = URL(string: urlString)
                
            imageView.kf.setImage(with: imgUrl)
        }
    }
}
