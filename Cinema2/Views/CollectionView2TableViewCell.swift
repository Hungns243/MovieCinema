//
//  CollectionView2TableViewCell.swift
//  Cinema2
//
//  Created by BeeCon on 7/5/25.
//

import UIKit

class CollectionView2TableViewCell: UITableViewCell {

    static let identifier = "CollectionView2TableViewCell"
     
     private let collectionView2: UICollectionView = {
         let layout = UICollectionViewFlowLayout()
         
         layout.itemSize = CGSize(width: 100, height: 100)
         layout.scrollDirection = .horizontal
         layout.minimumLineSpacing = 30
         
         let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
         collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
         collectionView.backgroundColor = .systemBackground
         return collectionView
     }()
     
     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         contentView.backgroundColor = .systemPink
         contentView.addSubview(collectionView2)
         
         collectionView2.delegate = self
         collectionView2.dataSource = self
     }
     
     required init(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     override func layoutSubviews() {
         super.layoutSubviews()
         collectionView2.frame = contentView.bounds
         collectionView2.backgroundColor = .black
     }
     
 }

 extension CollectionView2TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
         cell.backgroundColor = .green
         return cell
     }
     
     
     //set thanh 5 item
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return 5
     }

}
