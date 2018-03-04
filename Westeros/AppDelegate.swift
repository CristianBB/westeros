//
//  AppDelegate.swift
//  Westeros
//
//  Created by Cristian Blazquez Bustos on 8/2/18.
//  Copyright © 2018 Cbb. All rights reserved.
//

import UIKit

@UIApplicationMain


class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private var detailNavigationController: [UINavigationController]!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Crea la window
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Asigna color de fondo
        window?.backgroundColor = .cyan
        
        // Hazla visible
        window?.makeKeyAndVisible()
        
        // Crear modelos
        let houses = Repository.local.houses
        let seasons = Repository.local.seasons

        // Crear los controladores (master)
        let houseListViewController = HouseListViewController(model: houses)
        let seasonListViewController = SeasonListViewController(model: seasons)
        
        // Crea tabBarController (master)
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [houseListViewController.wrappedInNavigation(), seasonListViewController.wrappedInNavigation()]
        tabBarController.delegate = self
        
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            // Navegación exclusiva para iPads
            
            // Recupera ultimas selecciones del usuario
            let lastSelectedHouse = houseListViewController.lastSelectedHouse()
            let lastSelectedSeason = seasonListViewController.lastSelectedSeason()
            
            // Crea los Navigation Controller (detail)
            let houseDetailVC = HouseDetailViewController(model: lastSelectedHouse)
            let seasonDetailVC = SeasonDetailViewController(model: lastSelectedSeason)
            detailNavigationController = [houseDetailVC.wrappedInNavigation(), seasonDetailVC.wrappedInNavigation()]
            
            // Asignar delegados
            houseListViewController.delegate = houseDetailVC
            seasonListViewController.delegate = seasonDetailVC
            
            let splitViewController = UISplitViewController()
            splitViewController.viewControllers = [tabBarController, detailNavigationController[0], detailNavigationController[1]]
            splitViewController.preferredDisplayMode = .allVisible
            splitViewController.delegate = self
            
            // Asigna combinador al rootVC
            window?.rootViewController = splitViewController
        
        } else {
            // Navegacion exclusiva para iPhones
            window?.rootViewController = tabBarController
        }
        
        return true
    }

}

// MARK: - UITabBarControllerDelegate
extension AppDelegate: UITabBarControllerDelegate {
    
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        // Obtiene acceso al splitViewController del controlador raiz
        let splitViewController = window?.rootViewController as? UISplitViewController
        
        // Cambia el VC de detalle por el que corresponda según se la selección del tabBarController
        splitViewController?.showDetailViewController(detailNavigationController[tabBarController.selectedIndex], sender: self)

    }
    
}

// MARK: - UISplitViewControllerDelegate
extension AppDelegate: UISplitViewControllerDelegate {
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}


