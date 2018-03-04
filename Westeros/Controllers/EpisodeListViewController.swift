//
//  EpisodeListViewController.swift
//  Westeros
//
//  Created by Cristian Blazquez Bustos on 4/3/18.
//  Copyright © 2018 Cbb. All rights reserved.
//

import UIKit

class EpisodeListViewController: UITableViewController {
        
    // MARK: - Properties
    var model:[Episode]
    
    // MARK: - Initialization
    init(model: [Episode]) {
        self.model = model
        super.init(style: .plain)
        title = "Episodios"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Alta en notificaciones
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(seasonDidChange), name: Notification.Name(SEASON_DID_CHANGE_NOTIFICATION_NAME), object: nil)
        
    }
    
    deinit {
        // Baja en notificaciones
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Notifications
    @objc func seasonDidChange(notification: Notification) {
        
        // Extraer el userInfo de la notificacion
        guard let info = notification.userInfo else {
            return
        }
        
        // Sacar la casa de userInfo haciendo un cast (con "as")
        let season = info[SEASON_KEY] as? Season
        
        // Actualizar el modelo
        model = season!.sortedEpisodes
        
        // Actualiza el botón back
        let backItem = UIBarButtonItem()
        backItem.title = model.first?.season?.name
        navigationItem.backBarButtonItem = backItem
        
        // Sincronizar la vista
        tableView.reloadData()
        
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "EpisodeCell"
        
        // Descubre que celda tiene que mostrar
        let episode = model[indexPath.row]
        
        //Crear una celda
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
    
        // Sincronizar house (modelo) con la celda (vista)
        cell?.textLabel?.text = episode.title
        cell?.detailTextLabel?.text = "Broadcast Date: \(dateFormatter.string(from: episode.broadcastDate))"
        
        return cell!
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Averiguar que casa han pulsado
        let episode = model[indexPath.row]
        
        // Crea EpisodeDetailVC
        let episodeDetailVC = EpisodeDetailViewController(model: episode)
        
        // Hacer push del detalle
        navigationController?.pushViewController(episodeDetailVC, animated: true)
        
    }
}
