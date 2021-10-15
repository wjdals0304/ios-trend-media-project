//
//  TvShowTableViewCell.swift
//  TrendMediaProject
//
//  Created by 김정민 on 2021/10/15.
//

import UIKit

class TvShowTableViewCell: UITableViewCell {

    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var posterImage: UIImageView!
    @IBOutlet var rateLabel: UILabel!
    
    @IBOutlet var tvShowTitleLabel: UILabel!
    
    static var identifier : String = "TvShowTableViewCell"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
}
