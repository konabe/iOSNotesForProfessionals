//
//  ViewController.swift
//  Chapter57_UIKitDynamicsWithUICollectionView
//
//  Created by 小鍋涼太 on 2021/09/18.
//

import UIKit

class ViewController: UIViewController {
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: DraggableLayout())
        collectionView.backgroundColor = UIColor.white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        return collectionView
    }()
    
    lazy var longPress: UILongPressGestureRecognizer = {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(sender:)))
        return longPress
    }()
    
    var selectedIndexPaths = [IndexPath]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // §57.1 Creating a Custom Dragging Behavior with UIDynamicAnimator
        // ドラッグ処理。長押し動作のアニメーション
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.addGestureRecognizer(longPress)
    }
    
    @objc func handleLongPress(sender: UILongPressGestureRecognizer) {
        guard let draggableLayout = collectionView.collectionViewLayout as? DraggableLayout else {
            return
        }
        let location = sender.location(in: collectionView)
        switch sender.state {
        case .began:
            draggableLayout.startDragging(indexPaths: selectedIndexPaths, from: location)
        case .changed:
            draggableLayout.updateDragLocation(location)
        case .ended, .failed, .cancelled:
            draggableLayout.endDragging()
        case .possible:
            break
        @unknown default:
            fatalError()
        }
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .gray
        if selectedIndexPaths.contains(indexPath) {
            cell.backgroundColor = .red
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let isSelected = !selectedIndexPaths.contains(indexPath)
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = isSelected ? .red : .gray
        if isSelected {
            selectedIndexPaths.append(indexPath)
        } else {
            selectedIndexPaths.remove(at: selectedIndexPaths.firstIndex(of: indexPath)!)
        }
    }
}

final class RectangleAttachmentBehavior: UIDynamicBehavior {
    init(item: UIDynamicItem, point: CGPoint) {
        let frequency: CGFloat = 1.0
        let damping: CGFloat = 1.0
        super.init()
        let points = self.attachmentPoints(for: point)
        let attachmentBehaviors: [UIAttachmentBehavior] = points.map {
            let attachmentBehavior = UIAttachmentBehavior(item: item, attachedToAnchor: $0)
            attachmentBehavior.frequency = frequency
            attachmentBehavior.damping = damping
            return attachmentBehavior
        }
        attachmentBehaviors.forEach {
            addChildBehavior($0)
        }
    }
    
    func updateAttachmentLocation(with point: CGPoint) {
        let points = attachmentPoints(for: point)
        let attachments = childBehaviors.compactMap {
            $0 as? UIAttachmentBehavior
        }
        let pairs = zip(points, attachments)
        pairs.forEach {
            $0.1.anchorPoint = $0.0
        }
    }
    
    func attachmentPoints(for point: CGPoint) -> [CGPoint] {
        let width: CGFloat = 40.0
        let height: CGFloat = 40.0
        let topLeft = CGPoint(x: point.x - width * 0.5, y: point.y - height * 0.5)
        let topRight = CGPoint(x: point.x - width * 0.5, y: point.y - height * 0.5)
        let bottomLeft = CGPoint(x: point.x - width * 0.5, y: point.y - height * 0.5)
        let bottomRight = CGPoint(x: point.x - width * 0.5, y: point.y - height * 0.5)
        let points = [topLeft, topRight, bottomLeft, bottomRight]
        return points
    }
}

final class DragBehavior: UIDynamicBehavior {
    init(items: [UIDynamicItem], point: CGPoint) {
        super.init()
        items.forEach {
            let rectAttachment = RectangleAttachmentBehavior(item: $0, point: point)
            self.addChildBehavior(rectAttachment)
        }
    }
    
    func updateDragLocation(with point: CGPoint) {
        self.childBehaviors.compactMap {
            $0 as? RectangleAttachmentBehavior
        }.forEach {
            $0.updateAttachmentLocation(with: point)
        }
    }
}

final class DraggableLayout: UICollectionViewFlowLayout {
    var indexPathForDraggingElements: [IndexPath]?
    var animator: UIDynamicAnimator?
    var dragBehavior: DragBehavior?
    var startDragPoint: CGPoint = .zero
    var isFinishedDragging = false
    
    func startDragging(indexPaths selectedIndexPaths: [IndexPath], from point: CGPoint) {
        indexPathForDraggingElements = selectedIndexPaths
        animator = UIDynamicAnimator(collectionViewLayout: self)
        animator?.delegate = self
        
        let draggableAttributes: [UICollectionViewLayoutAttributes] = selectedIndexPaths.compactMap {
            let attribute = super.layoutAttributesForItem(at: $0)
            attribute?.zIndex = 1
            return attribute
        }
        startDragPoint = point
        dragBehavior = DragBehavior(items: draggableAttributes, point: point)
        animator?.addBehavior(dragBehavior!)
    }
    
    func updateDragLocation(_ point: CGPoint) {
        dragBehavior?.updateDragLocation(with: point)
    }
    
    func endDragging() {
        isFinishedDragging = true
        dragBehavior?.updateDragLocation(with: startDragPoint)
    }
    
    func clearDraggingIndexPaths() {
        animator = nil
        indexPathForDraggingElements = nil
        isFinishedDragging = false
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let existingAttributes: [UICollectionViewLayoutAttributes] = super.layoutAttributesForElements(in: rect) ?? []
        var allAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in existingAttributes {
            if (indexPathForDraggingElements?.contains(attributes.indexPath) ?? false) == false {
                allAttributes.append(attributes)
            }
        }
        
        if let animator = self.animator {
            let animatorAttributes: [UICollectionViewLayoutAttributes] = animator.items(in: rect).compactMap {
                    $0 as? UICollectionViewLayoutAttributes
                }
            allAttributes.append(contentsOf: animatorAttributes)
        }
        return allAttributes
    }
}

extension DraggableLayout: UIDynamicAnimatorDelegate {
    func dynamicAnimatorDidPause(_ animator: UIDynamicAnimator) {
        if !isFinishedDragging{
            return
        }
        clearDraggingIndexPaths()
    }
}
