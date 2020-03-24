//
//  CollectionViewCell.swift
//  VideoCollection
//
//  Created by Дмитрий Тараканов on 23.03.2020.
//  Copyright © 2020 Dmitry Angarsky. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!

    var video: Video! {
        didSet {
            updateUI()
        }
    }

    func updateUI() {

        thumbnailImageView.image = UIImage(named: video.thumbnailFileName)
        userNameLabel.text = video.authorName
        
        self.contentView.layer.cornerRadius = 11.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true

        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 10.0)
        self.layer.shadowRadius = 14.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds,
                                             cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
}
