//
//  ImageCollectionViewCell.swift
//  Flickr
//
//  Created by Carlos Bastida on 21/09/21.
//

import UIKit
import SDWebImage

class ImageCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ImageCollectionCell"
    @IBOutlet weak var thumbnailView: UIImageView!
    
    func configure(with model:Item){
        if let image = model.media?.m{
            thumbnailView.sd_setImage(with: URL(string: image))
        }
    }
}
