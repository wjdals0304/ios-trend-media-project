//
//  bookCollectionViewController.swift
//  TrendMediaProject
//
//  Created by 김정민 on 2021/10/25.
//

import UIKit

class BookCollectionViewController: UIViewController {
    
    //1. collectionView 아웃렛 연결
    @IBOutlet var bookCollectionView: UICollectionView!
    
    
    let tvShowList = TvShowInformation()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 2.delegate
        bookCollectionView.delegate = self
        bookCollectionView.dataSource = self
        
        let spacing: CGFloat = 15
    //        let width = UIScreen.main.bounds.width - (spacing * 1.2 )
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 170  , height:150 )
       
        
        layout.sectionInset = UIEdgeInsets(top:spacing,left:spacing,bottom:spacing,right:spacing)
        
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .vertical
        bookCollectionView.collectionViewLayout = layout
        
        //4. xlb
        let nibName = UINib(nibName: BookCollectionViewCell.identifier , bundle : nil)
        bookCollectionView.register(nibName, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "MY MEDIA", style: .plain, target: self, action: #selector(closeButtonClicked))

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(closeButtonClicked))
        
    }
    
    @objc func closeButtonClicked(){
        self.dismiss(animated: true, completion: nil)
    }
}


extension BookCollectionViewController : UICollectionViewDataSource, UICollectionViewDelegate{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier : BookCollectionViewCell.identifier,  for: indexPath ) as? BookCollectionViewCell else {
            return UICollectionViewCell()
        }
        let row = tvShowList.tvShow[indexPath.row]
        
        
        // Assets 이미지 파일명 파싱
        let postImageTitle = row.title.lowercased().replacingOccurrences(of: " ", with: "_")
        
        cell.titleLabel?.text = row.title
        cell.rateLabel?.text = String(row.rate)
        cell.posterImage?.image = UIImage(named: postImageTitle)

        
        
        return cell
    }
    
    
}
