//
//  ViewController.swift
//  Chapter29_UIScrollView
//
//  Created by 小鍋涼太 on 2021/09/05.
//

import UIKit

// Chapter29 UIScrollView

class ViewController: UIViewController {

    @IBOutlet weak var contentview: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageScrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // §29.1 Scrolling content with Auto Layout enabled
        // - UIScrollViewは一つだけのサブビューを持つべき。
        // - 水平スクロールの場合は、ContentViewと高さを合わせる。(垂直なら幅）
        // - すべてのコンテンツは幅を固定し、側面と固定する。
        
        // 1. ViewControllerのSimulated SizeをFreedomにして横長（スクロール方向に長く）にする
        // 2. 1つだけ Content Viewを追加する。
        //    Content Layout Guideに接続
        // 3. Equal Heightsをつける。
        //    Frame Layout Guideに接続 (Layout Guideが出るまでは、UIScrollViewの親と接続）
        // 4. コンテンツを追加する。（複数でもいい）（幅は決まっている必要あり）
        
        // §29.2 Create a UIScrollView
        _ = UIScrollView(frame: CGRect(x: 0, y: 0, width: 320, height: 400))
        
        // §29.3 ScrollView with AutoLayout
        // 縦横のスクロールができるようにしたい→コンテンツの高さと幅は決めること
        // ↑　横の長さが確定した場合は、横方向の制約を外して幅を合わせる。
        // ↑　スクロール方向が縦じゃなくて横と言われたら、Undoして縦方向の制約を外して高さを合わせる
        
        // §29.4 Detecting when UIScrollView finished scrolling with delegate methods
        scrollView.delegate = self
        
        // §29.5 Enable/Disable Scrolling
        scrollView.isScrollEnabled = true
        
        // §29.6 Zoom In/Out UIImageView
        imageScrollView.minimumZoomScale = 0.5
        imageScrollView.maximumZoomScale = 4.0
        imageScrollView.zoomScale = 1.0
        imageScrollView.delegate = self
        
        // §29.7 Scroll View Content Size
        // TODO: やってみたが、よくわからない。
        imageScrollView.contentSize = CGSize(width: 2000, height: 2000)
        
        // §29.8 Restrict scrolling direction
        // 方向を限定できる。
    }
}

extension ViewController: UIScrollViewDelegate {
    // §29.4
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            contentview.backgroundColor = .black
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        contentview.backgroundColor = .black
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == imageScrollView, scrollView.contentOffset.y != 0 {
            scrollView.contentOffset.y = 0
        }
    }
    
    // §29.6
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        if scrollView == imageScrollView {
            return imageView // これはすでにあるUIViewの参照をそのまま返さないといけない
        }
        return nil
    }
}
