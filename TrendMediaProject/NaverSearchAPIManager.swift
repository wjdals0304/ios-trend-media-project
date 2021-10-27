//
//  NaverSearchAPIManager.swift
//  TrendMediaProject
//
//  Created by 김정민 on 2021/10/27.
//

import Foundation
import Alamofire
import SwiftyJSON

class NaverSearchAPIManager {
    
    static let shared = NaverSearchAPIManager()
    
    func fetchMovieData(query : String , startPage :Int
                        , result : @escaping (Int,JSON) -> () ) {
        
        
        let url = "https://openapi.naver.com/v1/search/movie.json?query=\(query)&display=10&start=\(startPage)"
        
        let header : HTTPHeaders =  [
            "X-Naver-Client-Id": APIKey.NAVER_ID,
            "X-Naver-Client-Secret" : APIKey.NAVER_SECRET,
        ]
        
        
        AF.request(url, method: .get,headers : header ).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                let code = response.response?.statusCode ?? 500
                
                result(code,json)
            
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    
}
