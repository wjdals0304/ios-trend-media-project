//
//  TvShowSearchTableViewCell.swift
//  TrendMediaProject
//
//  Created by 김정민 on 2021/10/17.
//

import UIKit

class TvShowSearchTableViewCell: UITableViewCell {

    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var overViewLabel: UILabel!
    @IBOutlet var showTitleImage: UIImageView!
    
    static var identifier : String = "TvShowSearchCell"

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
