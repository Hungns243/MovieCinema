//
//  ViewController.swift
//  Cinema2
//
//  Created by BeeCon on 7/5/25.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 22/255, green: 18/255, blue: 43/255, alpha: 1.0)
        
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        vc1.tabBarItem.image = UIImage(systemName: "film")
        
        let vc2 = UINavigationController(rootViewController: SearchViewController())
        vc2.tabBarItem.image = UIImage(systemName: "icloud.and.arrow.down")
        
        let vc3 = UINavigationController(rootViewController: AccountViewController())
        vc3.tabBarItem.image = UIImage(systemName: "bookmark")
        
        let vc4 = UINavigationController(rootViewController: DownloadViewController())
        vc4.tabBarItem.image = UIImage(systemName: "person")
        
        vc1.title = "Home"
        vc2.title = "Download"
        vc3.title = "Bookmark"
        vc4.title = "Account"
        
        tabBar.tintColor = .label
        
        
        
        setViewControllers([vc1, vc2, vc3, vc4],animated: true)
    }


}

