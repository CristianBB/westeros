//
//  EpisodeDetailViewController.swift
//  Westeros
//
//  Created by Cristian Blazquez Bustos on 4/3/18.
//  Copyright © 2018 Cbb. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var seasonNameLabel: UILabel!
    @IBOutlet weak var episodeTitleLabel: UILabel!
    @IBOutlet weak var broadcastDateLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    // MARK: - Properties
    var model: Episode
    
    // MARK: - Initialization
    init(model: Episode) {
        self.model = model
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        syncModelWithView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        syncModelWithView()
        
        // Alta en notificaciones
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(seasonDidChange), name: Notification.Name(SEASON_DID_CHANGE_NOTIFICATION_NAME), object: nil)
    }
    
    deinit {
        // Baja en notificaciones
        NotificationCenter.default.removeObserver(self)
    }

    
    // MARK: - Sync
    func syncModelWithView() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        title = model.title
        
        seasonNameLabel.text = model.season?.name
        episodeTitleLabel.text = model.title
        broadcastDateLabel.text = "Broadcast Date (Spain): \(dateFormatter.string(from: model.broadcastDate))"
        synopsisLabel.text = model.synopsis
    }
    
    // MARK: - Notifications
    @objc func seasonDidChange(notification: Notification) {
        // Hago pop para volver al VC anterior
        navigationController?.popViewController(animated: true)
        
    }

}
