//
//  ViewController.swift
//  Chapter14_UITableView
//
//  Created by 小鍋涼太 on 2021/08/28.
//

import UIKit

// Chapter 14: UITableView
// - １列の行のリストでデータを表現する
// - スクロール、コンテンツの選択

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var myArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myArray = (1...20).map {
            "Row Order \($0)"
        }
        
        // §14.1 Self-Sizing Cells
        // iOS8からself sizing cellが導入された。
        // Rowの高さは自動的に計算される。(rowHeightはUITableViewAutomaticDimensionになっている)
        // estimatedRowHeightプロパティを使う。
        // この場合、heightForRowAtIndePathは不要になる。
        // ここでは、Storyboardでの接続を試している。
//        tableView.delegate = self
//        tableView.dataSource = self
        
        // §14.2 Custom Cells
        // 特定のプロパティだけ更新、プロパティが変わったらインテーフェイスを変える。
        // アニメーション、描画
        // ユーザースクロールに応じた効率的なロード
        
        // xibを使わない場合
        // tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        // xibを使う場合
        tableView.register(UINib(nibName: CustomTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CustomTableViewCell.identifier)
        
        // §14.3 Separator Lines
        // すべてのセパレータを消したりできる。
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .blue
        // tableView.separatorStyle = .none
        // 余ったセルの余分なセパレータを消す（テーブルに対してセルが足りてないときに余る現象）
        tableView.tableFooterView = UIView()
        
        // §14.4 Delegate and Datasource
        // UITableViewDelegate: テーブルをどう表示するかを制御する
        // UITableViewDataSource: テーブルビューのデータを定義する
        
        // §14.5 Creating a UITableView
        // ストーリーボードに追加
        // DataSourceの作成
        // UITableViewDataSourceプロトコル
        // ViewControllerにデータソースを接続する (selfを渡すか、StoryboardのOutletパネルに設定する)
        // 行の選択をハンドリングする > UITableViewDelegate
        
        // §14.6 Swip to Delete Rows
        // スワイプで消せるのは古いOSだけかも。
        // editButtonItemは、setEditingに反応するボタン。
        navigationItem.rightBarButtonItem = editButtonItem
        
        // §14.7 Expanding & Collapsing UITableViewCells
        // TODO: Objective-Cで書かれているためパス
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.isEditing = editing
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        // §14.1 特定のセルだけ高さを変えたい場合
        case 1:
            return 100
        case 10:
            return 200
        default:
            return UITableView.automaticDimension
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // §14.4 デフォルトでは１
        1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // §14.4 セクションヘッダーのビューを定義
        // titleForHeaderInSectionを打ち消すので注意
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 22))
        view.backgroundColor = .red
        return view
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        // §14.4 セルの高さ
        100
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        // §14.4 フッターの高さ
        200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // §14.5 行の選択
        print("selected \(indexPath.row)")
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myArray.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // §14.3 willDisplayかcellForRowAtでこれをかけば、特定のセルだけセパレータの長さを設定できるようになる。
        if indexPath.row % 2 == 0 {
            cell.separatorInset = .zero
            // layoutMarignsはUIViewのプロパティ
            //cell.layoutMargins = .zero
        } else {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50)
            //cell.layoutMargins = .zero
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // §14.4 セクションヘッダーの文字
        "Section \(section)"
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        // §14.4 セクションフッターの文字
        "Footer \(section)"
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // §14.4 編集できるかどうか
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // §14.4 追加したり削除したりするとき
        // アニメーションしてセルを削除したり、データモデルから削除したりするときに必要
        switch editingStyle {
        case .insert:
            // ここにデータモデルへの追加処理をかく
        self.myArray.insert("新規", at: indexPath.row)
            tableView.insertRows(at: [indexPath], with: .automatic)
        case .delete:
            // ここにデータモデルへの削除処理をかく
            self.myArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // §14.4 行を右にスワイプしたときにボタンが出てくるようにできる (iOS11から)
        let editAction = UIContextualAction(style: .normal, title: "★") { _, _, completion in
            self.myArray[indexPath.row] = self.myArray[indexPath.row] + " ☆"
            tableView.reloadRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        return UISwipeActionsConfiguration(actions: [editAction])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // §14.4 行を右にスワイプしたときにボタンが出てくるようにできる (iOS11から)
        let deleteAction = UIContextualAction(style: .destructive, title: "削除") { _, _, completion in
            self.myArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // §14.2
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        cell.customLabel.text = myArray[indexPath.row]
        // §14.3 セパレータの長さを変更する
        cell.layoutMargins = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50)
        return cell
    }
}
