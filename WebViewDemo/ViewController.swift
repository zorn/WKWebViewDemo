import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet var webView: WKWebView?
    
    override func viewDidLoad() {
        webView?.navigationDelegate = self
        webView?.uiDelegate = self 
        loadWebContent()
    }

    private func loadWebContent() {
        guard let webView = webView else {
            assertionFailure("webView is missing")
            return
        }
        
        // If loading something other than https,
        // need to add that domain to plist for security whitelisting
        let url = URL(string: "https://clubhouse.host")!
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

extension ViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("webView didFinish navigation")
        webView.evaluateJavaScript("navigator.userAgent", completionHandler: { result, error in
            if let userAgent = result as? String {
                print("userAgent: \(userAgent)")
            }
        })
    }
}

extension ViewController: WKUIDelegate {

}
