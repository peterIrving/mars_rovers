//
//  EnlargedImageVC.swift
//  Rovers
//
//  Created by Peter Irving on 11/10/19.
//  Copyright © 2019 Peter Irving. All rights reserved.
//

import UIKit

class EnlargedImageVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraLabel: UILabel!
    @IBOutlet weak var solLabel: UILabel!
    @IBOutlet weak var earthdateLabel: UILabel!
    @IBOutlet weak var roverName: UILabel!
    
    var image: Photo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imgUrl = URL(string: image.imgSrc!)
        imageView.kf.setImage(with: imgUrl)
        cameraLabel.text = image.camera?.fullName
        solLabel.text = "Martian Sol: \(image.sol!)"
        earthdateLabel.text = image.earthDate
        roverName.text = image.rover?.name
    }
}
