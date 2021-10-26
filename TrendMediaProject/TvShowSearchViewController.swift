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

class TvShowSearchViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate {
 

    var movieData: [MovieModel] = []
    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        navigationItem.title = "영화검색"
        
        
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
        if let query = "스파이더맨".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            
            let url = "https://openapi.naver.com/v1/search/movie.json?query=\(query)&display=15&start=1"
            let header : HTTPHeaders =  [
                "X-Naver-Client-Id": "oRRaT25yO8saX0XxwuJF",
                "X-Naver-Client-Secret" : "h_9RjwFW3S",
            ]
            
            
            AF.request(url, method: .get,headers : header ).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    
                    let json = JSON(value)
                    
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

                case .failure(let error):
                    print(error)
                }
            }
            
        }
        
    }
    
    
    
}
