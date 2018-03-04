//
//  HouseDetailViewController.swift
//  Westeros
//
//  Created by Cristian Blazquez Bustos on 12/2/18.
//  Copyright © 2018 Cbb. All rights reserved.
//

import UIKit

class HouseDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var houseNameLabel: UILabel!
    @IBOutlet weak var sigilImageView: UIImageView!
    @IBOutlet weak var wordsLabel: UILabel!
    
    // MARK: - Properties
    var model: House
    
    // MARK: - Initialization
    init(model: House) {
        self.model = model
        
        // Si se pasa nil en nibname, usará por defecto los que tengan el mismo nombre de la clase
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        
        title = model.name
    }
    
    // Chapuza de Apple relacionada con los nil
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupUI()
        syncModelWithView()
    }

    // MARK: - UI
    func setupUI() {
        // Crear botón wiki
        let wikiButton = UIBarButtonItem(title: "Wiki", style: .plain, target: self, action: #selector(displayWiki))
        
        // Crear botón miembros
        let membersButton = UIBarButtonItem(title: "Members", style: .plain, target: self, action: #selector(displayMembers))
        if model.sortedMembers.count == 0 {
            membersButton.isEnabled = false
        }
        
        // Agregar botones a la barra
        navigationItem.rightBarButtonItems = [wikiButton, membersButton]
    }
    
    // MARK: - Sync
    func syncModelWithView() {
        // Model -> View
        title = model.name
        
        houseNameLabel.text = "House \(model.name)"
        sigilImageView.image = model.sigil.image
        wordsLabel.text = model.words
    }
    
    @objc func displayWiki() {
        
        // Crear WikiVC
        let wikiViewController = WikiViewController(model: model)
        
        // Hacer push
        navigationController?.pushViewController(wikiViewController, animated: true)
        
    }
    
    @objc func displayMembers() {
        
        // Crear MemberListVC
        let memberListViewController = MemberListViewController(model: model.sortedMembers)
        
        // Hacer push
        navigationController?.pushViewController(memberListViewController, animated: true)
    }
}

// MARK: - HouseListViewControllerDelegate
extension HouseDetailViewController: HouseListViewControllerDelegate {
    func houseListViewController(_ vc: HouseListViewController, didSelectHouse house: House) {
        self.model = house
        syncModelWithView()
    }
    
    
}
