//
//  ViewController.swift
//  Chapter100_PDFCreationInIOS
//
//  Created by 小鍋涼太 on 2021/10/13.
//

import UIKit
import CoreFoundation
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var webview: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // §100.1 Create PDF
        
        let temporaryFile = "firstIOS.pdf"
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let fileName = path.appendingPathComponent(temporaryFile)
        print("PDFの保存場所: \(fileName)")
        UIGraphicsBeginPDFContextToFile(fileName, .zero, nil)
        UIGraphicsBeginPDFPageWithInfo(CGRect(x: 0, y: 0, width: 612, height: 792), nil)
        drawText()
        // §100.3 Multiple page PDF
        UIGraphicsBeginPDFPageWithInfo(CGRect(x: 0, y: 0, width: 612, height: 792), nil)
        drawText()
        UIGraphicsBeginPDFPageWithInfo(CGRect(x: 0, y: 0, width: 612, height: 792), nil)
        drawText()
        UIGraphicsBeginPDFPageWithInfo(CGRect(x: 0, y: 0, width: 612, height: 792), nil)
        drawText()
        UIGraphicsEndPDFContext()
        
        // §100.2 Show PDF
        webview.load(URLRequest(url: URL(fileURLWithPath: fileName)))
        
        // §100.4 Create PDF from any Microsoft Document loaded in UIWebview
        // TODO: 後でやる。
    }
    
    private func drawText() {
        let textToDraw = "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
        let currentText = CFAttributedStringCreate(kCFAllocatorDefault, NSString(string: textToDraw), nil)!
        let frameSetter = CTFramesetterCreateWithAttributedString(currentText)
        let frameRect = CGRect(x: 0, y: 0, width: 300, height: 100)
        let framePath = CGMutablePath()
        framePath.addRect(frameRect)
        let currentRange = CFRange(location: 0, length: 0)
        let frameRef = CTFramesetterCreateFrame(frameSetter, currentRange, framePath, nil)
        let currentContext = UIGraphicsGetCurrentContext()
        currentContext?.textMatrix = .identity
        currentContext?.translateBy(x: 0, y: 450)
        currentContext?.scaleBy(x: 2, y: -2)
        CTFrameDraw(frameRef, currentContext!)
    }
    

}

