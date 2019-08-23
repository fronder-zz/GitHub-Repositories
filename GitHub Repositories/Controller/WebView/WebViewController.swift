//
//  WebViewController.swift
//  GitHub Repositories
//
//  Created by Hasan on 7/28/19.
//  Copyright © 2019 Hasan. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    // MARK: - Variables
    
    private lazy var webView: WKWebView = {
        let layer = WKWebView()
        layer.backgroundColor = .white
        layer.navigationDelegate = self
        layer.allowsBackForwardNavigationGestures = true

        return layer
    }()
    
    // MARK: - Lifecycle
    
    convenience init(urlString: String) {
        self.init()
        
        let request = URLRequest(url: URL(string: urlString)!)
        webView.load(request)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webView)
        
        webView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    
    // MARK: - WKNavigationDelegate
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showLoader()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        hideLoader()
    }
    
    private func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        hideLoader()
    }
}
