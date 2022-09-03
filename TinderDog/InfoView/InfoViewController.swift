//
//  InfoViewController.swift
//  TinderDog
//
//  Created by Михаил Светлов on 03.09.2022.
//

import UIKit
import WebKit

class InfoViewController: UIViewController, WKUIDelegate {
    
    //MARK: - Views
    
    lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.isOpaque = false;
        webView.backgroundColor = UIColor.black
        
        return webView
    }()

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        setConstraints()
        loadRequest()
    }

}

private extension InfoViewController {
    
    //MARK: - Constraints
    
    func setConstraints() {
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                    webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                    webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                    ])
    }
    
    //MARK: - Networking
    
    func loadRequest() {
            guard let url = URL(string: "http://google.com") else { return }
            
            let urlRequest = URLRequest(url: url)
            
            webView.load(urlRequest)
        }
    
}

