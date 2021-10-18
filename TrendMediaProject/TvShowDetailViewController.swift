//
//  TvShowDetailViewController.swift
//  TrendMediaProject
//
//  Created by 김정민 on 2021/10/15.
//

import UIKit

class TvShowDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet var detailTableView: UITableView!
    @IBOutlet var detailTitleLabel: UILabel!
    
    // Data pass
    var tvShowData : TvShow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailTableView.delegate = self
        detailTableView.dataSource = self
        
        detailTitleLabel.text = "출연/제작"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "뒤로", style: .plain, target: self, action: #selector(closeButtonClicked))




    }
    
    @objc
    func closeButtonClicked(){
        
        // push - pop
        // push: dismiss x, present
       self.navigationController?.popViewController(animated: true)
        
//     self.dismiss(animated: true, completion: nil)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let starArr: [String] = (tvShowData?.starring.components(separatedBy: ","))!
        
        return starArr.count
    
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TvShowDetailTableViewCell" ,for : indexPath ) as? TvShowDetailTableViewCell else { return UITableViewCell() }
            
        
        cell.titleLabel?.text = tvShowData?.title
        cell.subTitleLabel?.text = tvShowData?.overview
        
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        

        return UIScreen.main.bounds.height / 5
        
    }
    
    

}
