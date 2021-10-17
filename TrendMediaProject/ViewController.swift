//
//  ViewController.swift
//  TrendMediaProject
//
//  Created by 김정민 on 2021/10/15.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet var mediaTableView: UITableView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var searchButton: UIButton!
    
    let tvShowList = TvShowInformation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mediaTableView.delegate = self
        mediaTableView.dataSource = self
        
        titleLabel.text = "TREND MEDIA"
        
        let buttonImage:UIImage? = UIImage(systemName: "magnifyingglass")
        searchButton.setImage( buttonImage , for: .normal)
        searchButton.setTitle("", for: .normal)
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvShowList.tvShow.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        //타입 캐스팅
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TvShowTableViewCell.identifier, for : indexPath) as? TvShowTableViewCell else { return UITableViewCell() }

        let row = tvShowList.tvShow[indexPath.row]
        
        // Assets 이미지 파일명 파싱
        let postImageTitle = row.title.lowercased().replacingOccurrences(of: " ", with: "_")
        
        cell.genreLabel?.text = row.genre
        cell.tvShowTitleLabel?.text = row.title
        
        cell.posterImage?.image = UIImage(named: postImageTitle)
        cell.rateLabel?.text = String(row.rate)
        cell.releaseDateLabel?.text = row.releaseDate
        cell.starringListLabel?.text = row.starring
                
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 2
        
    }
    
    
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TvShowSearchViewController") as! TvShowSearchViewController
        
        let nav = UINavigationController(rootViewController: vc)
        
        
        nav.modalPresentationStyle = .fullScreen
        
        
        self.present(nav,animated: true , completion: nil)
        
    
    }
    
    // cell 선택 시
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "TvShowDetailViewController") as? TvShowDetailViewController else {
            return
        }
    
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
    
    
}

