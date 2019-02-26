//
//  Scene.swift
//  Papr
//
//  Created by Joan Disho on 31.10.17.
//  Copyright © 2017 Joan Disho. All rights reserved.
//

import UIKit

/**
     Refers to a screen managed by a view controller.
     It can be a regular screen, or a modal dialog.
     It comprises a view controller and a view model.
 */

protocol TargetScene {
    var transition: SceneTransitionType { get }
}

enum Scene {
    // 主入口页面
    case main
}

extension Scene: TargetScene {
    
    var transition: SceneTransitionType {
        switch self {
        case .main:
            let mainTabBarController = MainTabBarController()
            // HomeViewController
            var homeVC = HomeViewController(collectionViewLayout: PinterestLayout(numberOfColumns: 2))
            let homeViewModel = HomeViewModel()
            let rootHomeVC = NavigationController(rootViewController: homeVC)
            homeVC.bind(to: homeViewModel)
            
            rootHomeVC.tabBarItem = UITabBarItem(
                title: "Cats",
                image: R.image.photoWhite()!,
                tag: 0
            )
            
            mainTabBarController.viewControllers = [
                rootHomeVC
            ]
            return .tabBar(mainTabBarController)
        }
    }
}
