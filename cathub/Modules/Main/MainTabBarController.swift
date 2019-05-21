//
//  MainTabBarController.swift
//  cathub
//
//  Created by  moma on 2019/2/14.
//  Copyright © 2019 yifans. All rights reserved.
//

import RxCocoa
import UIKit

class MainTabBarController: TabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .white
        tabBar.barTintColor = .black
        tabBar.backgroundColor = .black
    } 
}
