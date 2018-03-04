//
//  SeasonDetailViewController.swift
//  Westeros
//
//  Created by Cristian Blazquez Bustos on 4/3/18.
//  Copyright © 2018 Cbb. All rights reserved.
//

import UIKit

class SeasonDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var seasonNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var episodeCountLabel: UILabel!
    
    // MARK: - Properties
    var model: Season
    
    // MARK: - Initialization
    init(model: Season) {
        self.model = model
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupUI()
        syncModelWithView()
    }
    
    // MARK: - UI
    func setupUI() {
        // Crear botón Episodes
        let episodesButton = UIBarButtonItem(title: "Episodes", style: .plain, target: self, action: #selector(displayEpisodes))
        if model.sortedEpisodes.count == 0 {
            episodesButton.isEnabled = false
        }
    
        // Agregar botones a la barra
        navigationItem.rightBarButtonItems = [episodesButton]
    }

    // MARK: - Sync
    func syncModelWithView() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"

        title = model.name
        seasonNameLabel.text = model.name
        releaseDateLabel.text = "Release Date (Spain): \(dateFormatter.string(from: model.releaseDate))"
        episodeCountLabel.text = "Total Episodes: \(model.count)"
    }
    
    @objc func displayEpisodes() {
        
        // Crear MemberListVC
        let episodeListViewController = EpisodeListViewController(model: model.sortedEpisodes)
        
        // Hacer push
        navigationController?.pushViewController(episodeListViewController, animated: true)
    }
    
}

// MARK: - SeasonListViewControllerDelegate
extension SeasonDetailViewController: SeasonListViewControllerDelegate {
    func seasonListViewController(_ vc: SeasonListViewController, didSelectSeason season: Season) {
        self.model = season
        syncModelWithView()
    }
    
    
}

