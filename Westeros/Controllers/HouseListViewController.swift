//
//  HouseListViewController.swift
//  Westeros
//
//  Created by Cristian Blazquez Bustos on 15/2/18.
//  Copyright © 2018 Cbb. All rights reserved.
//

import UIKit

let HOUSE_DID_CHANGE_NOTIFICATION_NAME = "HouseDidChange"
let HOUSE_KEY = "HouseKey"
let LAST_HOUSE = "LAST_HOUSE"

protocol HouseListViewControllerDelegate: class {
    func houseListViewController(_ vc: HouseListViewController, didSelectHouse: House)
}

class HouseListViewController: UITableViewController {
    
    // MARK: - Properties
    let model:[House]
    weak var delegate: HouseListViewControllerDelegate?
    
    // MARK: - Initialization
    init(model: [House]) {
        self.model = model
        super.init(style: .plain)
        title = "Westeros"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Solo para iPad
        if UIDevice.current.userInterfaceIdiom == .pad {
            let lastRow = UserDefaults.standard.integer(forKey: LAST_HOUSE)
            let indexPath = IndexPath(row: lastRow, section: 0)
            
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .top)
        }
        
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return model.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cellId = "HouseCell"

        // Descubre que celda tiene que mostrar
        let house = model[indexPath.row]

        //Crear una celda
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        // Sincronizar house (modelo) con la celda (vista)
        cell?.imageView?.image = house.sigil.image
        cell?.textLabel?.text = house.name
        
        return cell!
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Averiguar que casa han pulsado
        let house = model[indexPath.row]
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            // Navegación exclusiva para iPads
            
            // Avisa al delegado
            delegate?.houseListViewController(self, didSelectHouse: house)
            
            // Mando la misma informacion a traves de notificaciones
            let notificationCenter = NotificationCenter.default
            let notification = Notification(name: Notification.Name(HOUSE_DID_CHANGE_NOTIFICATION_NAME), object: self, userInfo: [HOUSE_KEY: house])
            notificationCenter.post(notification)
            
            // Guardar las coordenadas (section, row) de la ultima casa seleccionada
            saveLastSelectedHouse(at: indexPath.row)
        
        } else {
            let houseDetailVC = HouseDetailViewController(model: house)
            navigationController?.pushViewController(houseDetailVC, animated: true)
        }
        
        
    }
}

extension HouseListViewController {
    func saveLastSelectedHouse(at row: Int) {
        let defaults = UserDefaults.standard
        defaults.set(row, forKey: LAST_HOUSE)
        
        // Por si acaso nos aseguramos que guarde la configuracion
        defaults.synchronize()
    }
    
    func lastSelectedHouse() -> House {
        // Extraer la fila del UserDefaults
        let row = UserDefaults.standard.integer(forKey: LAST_HOUSE)
        
        // Averiguar la casa de esa fila
        let house = model[row]
        
        // Devolverla
        return house
    }
}

