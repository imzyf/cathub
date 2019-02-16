//
//  MainTabBarController.swift
//  cathub
//
//  Created by  moma on 2019/2/14.
//  Copyright © 2019 yifans. All rights reserved.
//

import UIKit

class MainTabBarController: TabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [searchNav]
        selectedIndex = 0
    }

    fileprivate lazy var searchNav: NavigationController = {
        let ctrl = SearchViewController()
        ctrl.title = "Search"
        return NavigationController(rootViewController: ctrl)
    }()

}
