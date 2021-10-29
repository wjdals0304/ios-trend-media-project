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
    @IBOutlet var searchbar: UISearchBar!
    
    var startPage = 1
    
    //search 텍스트
    var searchText : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        navigationItem.title = "영화검색"
        
        tableView.prefetchDataSource = self
        searchbar.delegate = self
        searchbar.showsCancelButton = true
        
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
    
    
    func fetchMovieData(query: String , startPage : Int = 1 ){
        
        //네이버 영화 API 호출
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
        }
        
        self.searchText = query
        
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
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()

                }

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
                fetchMovieData(query: searchText , startPage: startPage)
                print("prefetch: \(indexPath)")
            }
        }
        
    }
    
    //취소
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
      //print("취소 : \(indexPaths)")
        
        
    }
    
}

extension TvShowSearchViewController: UISearchBarDelegate {
    
    // 검색 버튼(키보드 리턴키)을 눌렀을 때 실행
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let text = searchBar.text {
            startPage = 1
            fetchMovieData(query: text )
        }
    }
    
    // 취소 버튼 눌렀을 때 실행
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {

        //searchBar.showsCancelButton = false
        movieData.removeAll()
        tableView.reloadData()
        
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    
    // 서치바에 커서 깜박이기 시작할 때
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print(#function)
        //searchBar.showsCancelButton = true
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
}
