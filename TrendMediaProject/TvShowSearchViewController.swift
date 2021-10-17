//
//  TvShowSearchViewController.swift
//  TrendMediaProject
//
//  Created by 김정민 on 2021/10/15.
//

import UIKit

class TvShowSearchViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate {
 

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        navigationItem.title = "영화검색"
        
    }
    
    @objc func closeButtonClicked(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        //타입 캐스팅
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TvShowSearchTableViewCell.identifier, for : indexPath) as? TvShowSearchTableViewCell else {
            return UITableViewCell() }
        
        cell.titleLabel?.text = "영화제목"
        cell.overViewLabel?.text = "줄거리줄거리줄거리 줄거리"
        
        return cell
    
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 10
        
    }
    
    
    
}
