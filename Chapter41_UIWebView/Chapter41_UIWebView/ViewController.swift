//
//  ViewController.swift
//  Chapter41_UIWebView
//
//  Created by 小鍋涼太 on 2021/09/12.
//

import UIKit

// Chapter41 UIWebView

class ViewController: UIViewController {
    
    private var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        // §41.1 Create a UIWebView instance
        webView = UIWebView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height / 2))
        view.addSubview(webView)
        
        // §41.2 Determining content size
        // テーブルビューセルにWebViewを仕込む場合、HTMLpageのコンテンツの大きさを決めるのは重要。デリゲートで取得する。
        // 制約がないとこれをやっても意味ないので、該当箇所はコメントアウトする。
        webView.delegate = self
        
        // §41.3 Load HTML String
        let html = "<html><body>Hello World</body></html>"
        webView.loadHTMLString(html, baseURL: nil)
        
        // §41.4 Making a URL request
        webView.loadRequest(URLRequest(url: URL(string: "https://www.google.com/")!))
        
        // §41.5 Load JavaScript
        // Javascriptの評価結果ももらえる
        // 同期的に待ちが発生する。WKWebViewだとその問題もないので、WKWebViewで対応すること。
        let value = webView.stringByEvaluatingJavaScript(from: "(() => { return Date() })()")
        print(value! as String)
        
        // 41.8 Load Document files like .pdf, .txt, .doc etc
        let localFilePath = Bundle.main.path(forResource: "sample", ofType: "pdf")
        let data = FileManager.default.contents(atPath: localFilePath!)
        webView.load(data!, mimeType: "application/pdf", textEncodingName: "UTF-8", baseURL: NSURL() as URL)
        
        // §41.9 Load local HTML file in webview
        webView.loadRequest(URLRequest(url: URL(fileURLWithPath: Bundle.main.path(forResource: "index", ofType: "html")!)))
        
        // §41.10 Make links That inside UIWebview clickable
        webView.dataDetectorTypes = UIDataDetectorTypes([
            .phoneNumber
        ])
    }
    
    // §41.6 Stop Loading Web Content
    // §41.7 Reload Current Web Content
    @IBAction func stopBtnTapped(_ sender: Any) {
        webView.stopLoading()
    }
    @IBAction func reloadBtnTapped(_ sender: Any) {
        webView.reload()
    }
    
}

extension ViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        // §41.2
//        var frame = webView.frame
//        // 高さを1にするのはトリック。
//        frame.size.height = 1
//        webView.frame = frame
//        var fittingSize = webView.sizeThatFits(.zero)
//        frame.size = fittingSize
//        webView.frame = frame
//
//        print("size: \(fittingSize.width), \(fittingSize.height)")
    }
}
