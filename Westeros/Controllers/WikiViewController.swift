//
//  wikiViewController.swift
//  Westeros
//
//  Created by Cristian Blazquez Bustos on 15/2/18.
//  Copyright © 2018 Cbb. All rights reserved.
//

import UIKit
import WebKit

class WikiViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    // MARK: - Properties
    var model: House
    
    // MARK: - Initialization
    init(model: House) {
        self.model = model
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        syncModelWithView()
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
    
    // MARK: - Sync
    func syncModelWithView() {
        // Actualiza el botón back
        let backItem = UIBarButtonItem()
        backItem.title = model.name
        navigationItem.backBarButtonItem = backItem
        
        title = model.name
        webView.load(URLRequest(url: model.wikiURL))
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
        model = house!
        
        // Sincronizar la vista
        syncModelWithView()
        
    }
}

// MARK: - WKNavigationDelegate
extension WikiViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        loadingView.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingView.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        let type = navigationAction.navigationType
        
        switch type {
        case .linkActivated, .formSubmitted:
            decisionHandler(.cancel)
        default:
            decisionHandler(.allow)
        }
        
    }
}
