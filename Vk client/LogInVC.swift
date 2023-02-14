//
//  LogInVC.swift
//  Vk client
//
//  Created by Ярослав on 28.01.2023.
//

import UIKit
import WebKit

class LogInVC: UIViewController {
    
    let session = Session.instance

    @IBOutlet weak var webView: WKWebView! {
        didSet{
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var urlCons = URLComponents()
        urlCons.scheme = "https"
        urlCons.host = "oauth.vk.com"
        urlCons.path = "/authorize"
        urlCons.queryItems = [
            URLQueryItem(name: "client_id", value: "51438573"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "scope", value: "photos")
        ]
        let request = URLRequest(url: urlCons.url!)
        webView.load(request)

    
    }

}

extension LogInVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment() else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map{$0.components(separatedBy: "=")}
            .reduce([String:String]()) {result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        
        session.token = params["access_token"] ?? ""
        session.userId = Int(params["user_id"] ?? "0") ?? 0
        
        performSegue(withIdentifier: "showMenu", sender: nil)
        decisionHandler(.cancel)
    }
}
