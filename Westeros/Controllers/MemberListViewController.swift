//
//  MemberListViewController.swift
//  Westeros
//
//  Created by Cristian Blazquez Bustos on 19/2/18.
//  Copyright © 2018 Cbb. All rights reserved.
//

import UIKit

class MemberListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var model: [Person]
    
    // MARK: - Initialization
    init(model: [Person]) {
        self.model = model
        
        super.init(nibName: nil, bundle: nil)
        title = "Members"
    }
    
    // Chapuza
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Asignamos el delegado del tableView
        tableView.delegate = self
        
        // Asignamos la fuente de datos
        tableView.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Alta en notificaciones
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(houseDidChange), name: Notification.Name(HOUSE_DID_CHANGE_NOTIFICATION_NAME), object: nil)
        
    }
    
    deinit {
        // Baja en notificaciones
        NotificationCenter.default.removeObserver(self)
        
    }
    
    // MARK: - Notifications
    @objc func houseDidChange(notification: Notification) {
        
        // Extraer el userInfo de la notificacion
        guard let info = notification.userInfo else {
            return
        }
        
        // Sacar la casa de userInfo haciendo un cast (con "as")
        let house = info[HOUSE_KEY] as? House
        
        // Actualizar el modelo
        model = house!.sortedMembers
        
        // Actualiza el botón back
        let backItem = UIBarButtonItem()
        backItem.title = model.first?.house.name
        navigationItem.backBarButtonItem = backItem
        
        // Sincronizar la vista
        tableView.reloadData()
        
    }

}

// MARK: - UITableViewDataSource
extension MemberListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "MemberCell"
        
        // Descubrir la persona que tenemos que mostrar
        let person = model[indexPath.row]
        
        // Preguntar por una celda para crearla
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        // Sincronizar celda y persona
        cell?.textLabel?.text = person.fullName
        
        // Devolver la celda
        return cell!
    }
    
}

extension MemberListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Averiguar que persona han pulsado
        let person = model[indexPath.row]
        
        let memberDetailVC = MemberDetailViewController(model: person)
        navigationController?.pushViewController(memberDetailVC, animated: true)
        
    }
}
