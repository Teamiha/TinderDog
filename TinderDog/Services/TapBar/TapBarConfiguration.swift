//
//  TapBarConfiguration.swift
//  TinderDog
//
//  Created by Михаил Светлов on 31.08.2022.
//

import Foundation
import UIKit

final class TabBarConfigurator {

    // MARK: - Private property

    private let allTab: [TabBarModel] = [.main, .favorite, .recomendation]

    // MARK: - Internal Methods

    func configure() -> UITabBarController {
        return getTabBarController()
    }

}


// MARK: - Private Methods

private extension TabBarConfigurator {
    

    func getTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        let appearance = UITabBarAppearance()
        
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        tabBarController.tabBar.standardAppearance = appearance
        tabBarController.tabBar.scrollEdgeAppearance = tabBarController.tabBar.standardAppearance
        
        tabBarController.tabBar.tintColor = .white
        tabBarController.tabBar.unselectedItemTintColor = .lightGray

        tabBarController.viewControllers = getViewControllers()

        return tabBarController
    }

    func getViewControllers() -> [UIViewController] {
        var viewControllers = [UIViewController]()

        allTab.forEach { tab in
            let controller = getCurrentViewController(tab: tab)
            let navigationController = UINavigationController(rootViewController: controller)
            setupNavigationController()
            let tabBarItem = UITabBarItem(title: tab.title, image: tab.image, selectedImage: tab.selectedImage)
            controller.tabBarItem = tabBarItem
            viewControllers.append(navigationController)
        }

        return viewControllers
    }

    func getCurrentViewController(tab: TabBarModel) -> UIViewController {
        switch tab {
        case .main:
            return MainViewController()
        case .favorite:
            return FavoriteTableViewController()
        case .recomendation:
            return RecomendationViewController()
        }
    }
    
// MARK: - NavigationController
    
    func setupNavigationController() {
        UINavigationBar.appearance().tintColor = .black
    }
    

}

