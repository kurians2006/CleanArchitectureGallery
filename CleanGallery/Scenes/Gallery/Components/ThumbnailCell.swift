//
//  ThumbnailCell.swift
//  CleanGallery
//
//  Created by Naeem Paracha on 01/07/2021.
//

import UIKit

class ThumbnailCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override var isHighlighted: Bool {
        didSet {
            if self.isHighlighted {
                UIView.animate(
                    withDuration: 0.1,
                    animations: {
                        self.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
                })
            } else {
                UIView.animate(
                    withDuration: 0.1,
                    animations: {
                        self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                })
            }
        }
    }
}
