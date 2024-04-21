//
//  ImageCollectionViewCell.swift
//  ImageScroller
//
//  Created by madhur bansal on 21/04/24.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    static var identifier: String {
        return String(String(describing: self))
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    @IBOutlet weak var gridImageView: LazyImage!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        gridImageView.backgroundColor = .lightGray
    }

    func configure(_ data: ApiModel) {
        let url = URL(string: data.thumbnail.domain + "/" +  data.thumbnail.basePath + "/0/" + data.thumbnail.key)!
        gridImageView.loadImage(url: url)
    }
}
