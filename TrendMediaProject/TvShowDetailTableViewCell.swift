//
//  TvShowDetailTableViewCell.swift
//  TrendMediaProject
//
//  Created by 김정민 on 2021/10/18.
//

import UIKit

class TvShowDetailTableViewCell: UITableViewCell {

    
    @IBOutlet var starImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
