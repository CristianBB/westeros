//
//  SeasonListViewController.swift
//  Westeros
//
//  Created by Cristian Blazquez Bustos on 4/3/18.
//  Copyright © 2018 Cbb. All rights reserved.
//

import UIKit

let SEASON_DID_CHANGE_NOTIFICATION_NAME = "SeasonDidChange"
let SEASON_KEY = "SeasonKey"
let LAST_SEASON = "LAST_SEASON"

protocol SeasonListViewControllerDelegate: class {
    func seasonListViewController(_ vc: SeasonListViewController, didSelectSeason: Season)
}

class SeasonListViewController: UITableViewController {
        
    // MARK: - Properties
    let model:[Season]
    weak var delegate: SeasonListViewControllerDelegate?
    
    // MARK: - Initialization
    init(model: [Season]) {
        self.model = model
        super.init(style: .plain)
        title = "Temporadas"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            let lastRow = UserDefaults.standard.integer(forKey: LAST_SEASON)
            let indexPath = IndexPath(row: lastRow, section: 0)
            
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .top)
        }
        
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "SeasonCell"
        
        // Descubre que celda tiene que mostrar
        let season = model[indexPath.row]
        
        //Crear una celda
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        // Sincronizar house (modelo) con la celda (vista)
        cell?.textLabel?.text = season.name
        
        return cell!
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Averiguar que Season han pulsado
        let season = model[indexPath.row]
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            // Navegación exclusiva para iPads
            
            // Avisa al delegado
            delegate?.seasonListViewController(self, didSelectSeason: season)
            
            // Mando la misma informacion a traves de notificaciones
            let notificationCenter = NotificationCenter.default
            let notification = Notification(name: Notification.Name(SEASON_DID_CHANGE_NOTIFICATION_NAME), object: self, userInfo: [SEASON_KEY: season])
            notificationCenter.post(notification)
            
            // Guardar las coordenadas (section, row) de la ultima season seleccionada
            saveLastSelectedSeason(at: indexPath.row)
            
        } else {
            // Navegación exclusiva para iPhones
            let seasonDetailVC = SeasonDetailViewController(model: season)
            navigationController?.pushViewController(seasonDetailVC, animated: true)
        }
        
    }
    
}

extension SeasonListViewController {
    func saveLastSelectedSeason(at row: Int) {
        let defaults = UserDefaults.standard
        defaults.set(row, forKey: LAST_SEASON)
        
        // Por si acaso nos aseguramos que guarde la configuracion
        defaults.synchronize()
    }
    
    func lastSelectedSeason() -> Season {
        // Extraer la fila del UserDefaults
        let row = UserDefaults.standard.integer(forKey: LAST_SEASON)
        
        // Averiguar la Season de esa fila
        let season = model[row]
        
        // Devolverla
        return season
    }
}
