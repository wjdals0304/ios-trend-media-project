//
//  TvShowSearchViewController.swift
//  TrendMediaProject
//
//  Created by 김정민 on 2021/10/15.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class TvShowSearchViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate, UITableViewDataSourcePrefetching {
 
    var movieData: [MovieModel] = []
    @IBOutlet var tableView: UITableView!
    
    var startPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        navigationItem.title = "영화검색"
        
        tableView.prefetchDataSource = self
        
        fetchMovieData()
        
    }
    
    @objc func closeButtonClicked(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        //타입 캐스팅
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TvShowSearchTableViewCell.identifier, for : indexPath) as? TvShowSearchTableViewCell else {
            return UITableViewCell() }
        
        
        let row = movieData[indexPath.row]
        
        cell.titleLabel?.text = row.titleData
        cell.lbl2.text = row.subtitle
        cell.overViewLabel?.text = row.userRatingData
        
        let url = URL(string: row.imageData)
        cell.showTitleImage.kf.setImage(with: url)
        
        
        return cell
    
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 5
    }
    
    
    func fetchMovieData(){
        
        //네이버 영화 API 호출
        guard let query = "스파이더맨".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
        }
        NaverSearchAPIManager.shared.fetchMovieData(query: query, startPage: startPage) { statusCode, json in

            switch statusCode {
            case 200:
                
                for item in json["items"].arrayValue {
                    
                    let value = item["title"].stringValue.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
                    let image = item["image"].stringValue
                    let link = item["link"].stringValue
                    let userRating = item["userRating"].stringValue
                    let sub = item["subtitle"].stringValue
                
                    
                    let data = MovieModel(titleData: value, imageData: image, linkData: link, userRatingData: userRating, subtitle: sub)
                    
                    self.movieData.append(data)
                    
                }
                
                self.tableView.reloadData()

            default :
                print("error")
            }
        }


    }
    
    // 셀이 화면에 보이기 전에 필요한 리소스를 미리 다운 받는 기능
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths {
            if movieData.count - 1 == indexPath.row {
                startPage += 10
                fetchMovieData()
                print("prefetch: \(indexPath)")
            }
        }
        
    }
    
    //취소
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
//        print("취소 : \(indexPaths)")
    }
    
    
    
}
