//
//  BookCollectionViewCell.swift
//  TrendMediaProject
//
//  Created by 김정민 on 2021/10/25.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BookCollectionViewCell"

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var posterImage: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
