//
//  RoverCell.swift
//  Rovers
//
//  Created by Peter Irving on 11/10/19.
//  Copyright © 2019 Peter Irving. All rights reserved.
//

import UIKit

class RoverCell: UICollectionViewCell {
    
    @IBOutlet weak var roverLabel: UILabel!
    @IBOutlet weak var roverImage: UIImageView!
    
    func setupCell(roverName: String) {
        roverLabel.text = roverName
        roverImage.image = getImageName(roverName: roverName)
    }
    
    func getImageName(roverName: String) -> UIImage? {
        if roverName == "Curiosity" {
            return UIImage(named: "resize_curiosity")!
        } else if roverName == "Opportunity" {
            return UIImage(named: "resize_opportunity")!
        } else if roverName == "Spirit" {
            return UIImage(named: "resize_spirit")!
        } else {
            return nil
        }
    }
}
