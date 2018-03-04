//
//  MemberDetailViewController.swift
//  Westeros
//
//  Created by Cristian Blazquez Bustos on 4/3/18.
//  Copyright © 2018 Cbb. All rights reserved.
//

import UIKit

class MemberDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var aliasLabel: UILabel!
    @IBOutlet weak var houseLabel: UILabel!
    @IBOutlet weak var sigilImageView: UIImageView!
    @IBOutlet weak var wordsLabel: UILabel!
    
    // MARK: - Properties
    var model: Person
    
    // MARK: - Initialization
    init(model: Person) {
        self.model = model
        
        // Si se pasa nil en nibname, usará por defecto los que tengan el mismo nombre de la clase
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        syncModelWithView()
        
        // Alta en notificaciones
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(houseDidChange), name: Notification.Name(HOUSE_DID_CHANGE_NOTIFICATION_NAME), object: nil)
    }
    
    deinit {
        // Baja en notificaciones
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Sync
    func syncModelWithView() {
        title = model.fullName
        
        // Model -> View
        nameLabel.text = (model.fullName)
        if (model.alias != "") {
            aliasLabel.text = model.alias
        } else {
            aliasLabel.text = ""
        }
        
        houseLabel.text = "House \(model.house.name)"
        sigilImageView.image = model.house.sigil.image
        wordsLabel.text = model.house.words
        
    }
    
    // MARK: - Notifications
    @objc func houseDidChange(notification: Notification) {
        // Hago pop para volver al VC anterior
        navigationController?.popViewController(animated: true)
        
    }

}
