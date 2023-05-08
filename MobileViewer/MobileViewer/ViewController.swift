//
//  ViewController.swift
//  MobileViewer
//
//  Created by CHEEBOW on 2020/08/27.
//  Copyright © 2020 CHEEBOW. All rights reserved.
//

import UIKit

import UIKit
import WebKit

class ViewController: UIViewController {
    let siteURL = "https://backnumber.rittor-music.co.jp"

    private var webView: WKWebView! = {
       let configuration = WKWebViewConfiguration()
        let webview = WKWebView(frame: .zero, configuration: configuration)
        webview.backgroundColor = UIColor.white
        return webview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        webView.navigationDelegate = self
        webView.uiDelegate = self
        view.addSubview(webView)

        guard let url = URL(string: siteURL) else {
            return
        }
        let request = URLRequest(url: url)

        webView.load(request)
    }

    override func viewDidLayoutSubviews() {
        webView.frame = view.bounds
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension ViewController: WKNavigationDelegate {
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        preferences: WKWebpagePreferences,
        decisionHandler: @escaping (WKNavigationActionPolicy, WKWebpagePreferences
    ) -> Void) {
        preferences.preferredContentMode = .mobile
        decisionHandler(.allow, preferences)
    }
}

extension ViewController: WKUIDelegate {
    func webView(
        _ webView: WKWebView,
        createWebViewWith configuration: WKWebViewConfiguration,
        for navigationAction: WKNavigationAction,
        windowFeatures: WKWindowFeatures
    ) -> WKWebView? {
        guard let targetFrame = navigationAction.targetFrame, targetFrame.isMainFrame else {
            webView.load(navigationAction.request)
            return nil
        }
        return nil
    }
}
