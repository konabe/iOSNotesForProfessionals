//
//  ViewController.swift
//  Chapter38_UICollectionView
//
//  Created by 小鍋涼太 on 2021/09/11.
//

import UIKit

// Chapter38 UICollectionView

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tapEventLabel: UILabel!
    var data = [
        ["one", "three", "five", "seven", "nine",
         "eleven", "thirteen", "fifthteen", "seventeen", "nineteen",
        "21", "23", "25", "27", "29"],
        ["two", "four", "six"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // (§38.1 Create a UICollecitonView)
        // §38.6 Create a Collection View Programmatically
        let layout = UICollectionViewFlowLayout()
        _ = UICollectionView(frame: CGRect(x: 0, y: 0, width: 200, height: 21), collectionViewLayout: layout)
        
        // §38.2 UICollectionView - Datasource
        // Datasourceオブジェクトがないといけない。
        collectionView.register(UINib(nibName: "MyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "numberCell")
        
        // §38.3 Basic Swift example of a Collection View
        // View階層のところで、Collection Viewを右クリックしてDelegateの登録とかをやればいい。
        
        // §38.4 Manage Multiple Collection view with DataSource and Flowlayout
        
        // §38.5 UICollectionViewDelegate setup and item selection
        
        // §38.8 Performing batch updates
    }
    
    // §38.8
    @IBAction func insertBtn(_ sender: Any) {
        // アニメーションしたいときはこれで囲む
        collectionView.performBatchUpdates({
            collectionView.moveItem(at: IndexPath(row: 0, section: 0), to: IndexPath(row: 1, section: 0))
            collectionView.moveItem(at: IndexPath(row: 2, section: 0), to: IndexPath(row: 6, section: 0))
        }, completion: nil)
    }
    
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "numberCell", for: indexPath) as! MyCollectionViewCell
        cell.myLabel.text = data[indexPath.section][indexPath.row]
        cell.view.backgroundColor = .green
        return cell
    }
    
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tapEventLabel.text = "You selected cell #\(indexPath)"
        let cell = collectionView.cellForItem(at: indexPath) as! MyCollectionViewCell
        cell.view.backgroundColor = .yellow
    }
}

// §38.4
// §38.7
extension ViewController: UICollectionViewDelegateFlowLayout {
    // セルの大きさ
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = collectionView.bounds.width
        let itemWidth = collectionWidth / 5 - 1
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    // セクションのマージン
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 20, left: 5, bottom: 20, right: 5)
    }
    
    // セルの連結部分の長さ
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    // セルの折返しの間隔
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
}
