//
//  ViewController.swift
//  Chapter24_UITextView
//
//  Created by 小鍋涼太 on 2021/09/04.
//

import UIKit

// Chapter24: UITextView

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var htmlTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // §24.1 Set attributed text
        let attributedText = NSMutableAttributedString(attributedString: textView.attributedText!)
        let text = textView.text! as NSString
        let iwatoveRange = text.range(of: NSLocalizedString("イーハトーヴォ", comment: ""))
        attributedText.addAttribute(.foregroundColor, value: UIColor.green, range: iwatoveRange)
        let morioRange = text.range(of: NSLocalizedString("モリーオ", comment: ""))
        attributedText.addAttribute(.backgroundColor, value: UIColor.red, range: morioRange)
        textView.attributedText = attributedText
        
        // §24.2 Change font
        textView.font = .systemFont(ofSize: 20)
        
        // §24.3 Auto Detect Links, Address, Dates, and more
        // UIDataDetector
        textView.dataDetectorTypes = [.link, .phoneNumber]
        textView.isEditable = false
        textView.isSelectable = true
        
        // §24.4 Change text
        // textView.text = "Hello, world"
        
        // §24.5 Change text alignment
        textView.textAlignment = .right
        
        // §24.6 UITextViewDelegate methods
        // Delegateでできること: 編集の通知、テキストの変更、URLへの反応
        
        // §24.7 Change text color
        // textView.textColor = .purple
        
        // §24.8 Remove extra paddings to fit to a precisely measured text
        // UITextViewはデフォルトで余分なパディングが入っている。
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = 0
        // パディングを消せば以下のような計算も心配せずにできる
        let attributeString = textView.attributedText!
        let textSize = attributeString.boundingRect(with: CGSize(width: 200, height: 20), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil).size
        textView.frame.size = textSize
        
        // §24.9 Getting and Setting the Cursor Position
        // UITextFieldでも同じことができる。
        let startPosiiton: UITextPosition = textView.beginningOfDocument
        if let selectedRange = textView.selectedTextRange {
            let cursorPosition = textView.offset(from: startPosiiton, to: selectedRange.start)
            print(cursorPosition)
        }
        let rangeStartPosition = textView.position(from: startPosiiton, in: .right, offset: 2)
        let rangeEndPosition = textView.position(from: startPosiiton, in: .right, offset: 9)
        textView.selectedTextRange = textView.textRange(from: rangeStartPosition!, to: rangeEndPosition!)
        
        // これでカーソルを出すことができる。
        textView.becomeFirstResponder()
        
        // §24.10 UITextView with HTML text
        let htmlString = "<h1>Title</h1><p>This is content.</p>"
        let attrString = try! NSMutableAttributedString(
            data: htmlString.data(using: .utf8)!,
            options: [
                .documentType: NSAttributedString.DocumentType.html
            ],
            documentAttributes: nil
        )
        htmlTextView.attributedText = attrString
        
        // §24.11 Check to see if empty or nil
        if let text = htmlTextView.text, !text.isEmpty {
            print("nilでも空白でもない時の処理")
        }
    }

    // §24.9
    @IBAction func insertIwate(_ sender: Any) {
        textView.insertText("岩手")
    }
    
}

