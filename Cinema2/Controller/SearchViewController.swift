//
//  HomeViewController.swift
//  Cinema2
//
//  Created by BeeCon on 7/5/25.
//

import UIKit

class SearchViewController: UIViewController {
    
    private let homeFeedTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        tableView.register(CollectionView2TableViewCell.self, forCellReuseIdentifier: CollectionView2TableViewCell.identifier)
        
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        view.addSubview(homeFeedTable)
        
        // Đổi màu tab bar
        if let tabBar = self.tabBarController?.tabBar {
            
//            tabBar.backgroundColor = UIColor(red: 22/255, green: 18/255, blue: 43/255, alpha: 1.0)
            tabBar.tintColor = UIColor(red: 0/255, green: 74/255, blue: 144/255, alpha: 1.0)
            tabBar.unselectedItemTintColor = .white
            tabBar.isTranslucent = false
        }
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        
        
        //        dùng autolayout
        //        homeFeedTable.translatesAutoresizingMaskIntoConstraints = false
        //
        //            NSLayoutConstraint.activate([
        //                homeFeedTable.topAnchor.constraint(equalTo: view.topAnchor),
        //                homeFeedTable.leftAnchor.constraint(equalTo: view.leftAnchor),
        //                homeFeedTable.rightAnchor.constraint(equalTo: view.rightAnchor),
        //                homeFeedTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        //            ])
    }
    
    //    Thiết lập thủ công bằng frame
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        homeFeedTable.frame = CGRect(x: 16, y: 0, width: view.bounds.width - 32, height: view.bounds.height)
        
        
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            // Section 0 dùng CollectionViewTableViewCell
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
                return UITableViewCell()
            }
            return cell
        } else {
            // Section 1 dùng CollectionView2TableViewCell
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionView2TableViewCell.identifier, for: indexPath) as? CollectionView2TableViewCell else {
                return UITableViewCell()
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return section == 0 ? "Phim đề cử" : "Phim mới nhất"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            headerView.textLabel?.textColor = .white
//            headerView.contentView.backgroundColor = .black
//            headerView.textLabel?.frame.origin.x = 16
            headerView.textLabel?.frame = CGRect(x: tableView.layoutMargins.left, y: 0, width: 200, height: 40)

        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 280
        } else {
            return 100
        }
        
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
}

