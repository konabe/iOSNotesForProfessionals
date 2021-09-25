//
//  ViewController.swift
//  Chapter59_UIKitDynamics
//
//  Created by 小鍋涼太 on 2021/09/20.
//

import UIKit

// UIKit DynamicsはUIKitに統合されている物理エンジン

class ViewController: UIViewController {
    @IBOutlet weak var presentButton: UIButton!
    let magnitudeMultiplier: CGFloat = 0.0008
    // このUIDynamicAnimatorにBehaviorを追加していくイメージ？
    lazy var dynamicAnimator: UIDynamicAnimator = {
        .init(referenceView: self.view)
    }()
    lazy var gravity: UIGravityBehavior = {
        .init(items: [self.orangeView])
    }()
    lazy var collision: UICollisionBehavior = {
        let collision = UICollisionBehavior(items: [self.orangeView])
        collision.translatesReferenceBoundsIntoBoundary = true
        return collision
    }()
    lazy var fieldBehaviors: [UIFieldBehavior] = {
        var fieldBehaviors = [UIFieldBehavior]()
        for _ in 0 ..< 2 {
            let field = UIFieldBehavior.springField()
            field.addItem(self.orangeView)
            fieldBehaviors.append(field)
        }
        return fieldBehaviors
    }()
    lazy var itemBehavior: UIDynamicItemBehavior = {
        let itemBehavior = UIDynamicItemBehavior(items: [self.orangeView])
        itemBehavior.density = 0.01
        itemBehavior.resistance = 10
        itemBehavior.friction = 0.0
        itemBehavior.allowsRotation = false
        return itemBehavior
    }()
    lazy var orangeView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.backgroundColor = .orange
        self.view.addSubview(view)
        return view
    }()
    // ドラッグしたときのジェスチャー
    lazy var panGesture: UIPanGestureRecognizer = {
        .init(target: self, action: #selector(handlePan(sender:)))
    }()
    lazy var attachment: UIAttachmentBehavior = {
        .init(item: self.orangeView, attachedToAnchor: .zero)
    }()
    var presentingAnimator: ShadeAnimator!
    var dismissingAnimator: ShadeAnimator!
    let shadeVC: UIViewController = {
        let vc = UIViewController()
        vc.view.frame = CGRect(x: 0, y: 0, width: 300, height: 600)
        vc.modalPresentationStyle = .custom
        vc.view.backgroundColor = .yellow
        return vc
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // §59.1 Flick View Based on Gesture Velocity
        dynamicAnimator.addBehavior(gravity)
        dynamicAnimator.addBehavior(collision)
        orangeView.addGestureRecognizer(panGesture)
        
        // §59.2 Sticky Corners Effect Using UIFieldBehaviors
        dynamicAnimator.addBehavior(itemBehavior)
        for field in fieldBehaviors {
            dynamicAnimator.addBehavior(field)
        }
        
        // §59.3 UIDynamicBehavior Driven Custom Transition
        presentButton.addAction(.init { _ in
            let modal = ModalViewController()
            modal.view.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
            modal.modalPresentationStyle = .custom
            modal.transitioningDelegate = modal
            self.present(modal, animated: true)
        }, for: .touchUpInside)
        
        // §59.4 Shade Transition with Real-World Physics Using UIDynamicBehaviors
        // iOSの通知画面のようなものを作る。
        // TODO: 失敗
        label.text = "Swipe Down From Top"
        presentingAnimator = ShadeAnimator(isAppearing: true, presentingVC: self, presentedVC: shadeVC, transitionDelegate: self)
        dismissingAnimator = ShadeAnimator(isAppearing: false, presentingVC: self, presentedVC: shadeVC, transitionDelegate: self)
        
        // TODO: - 面倒なのでやってない
        // §59.5 Map Dynamic Animation Position Changes to Bounds
        // §59.6 The Falling Square
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        orangeView.center = view.center
        dynamicAnimator.updateItem(usingCurrentState: orangeView)
        
        for (index, field) in fieldBehaviors.enumerated() {
            field.position = CGPoint(x: view.bounds.midX, y: view.bounds.height * (0.25 + 0.5 * CGFloat(index)))
            field.region = UIRegion(size: CGSize(width: view.bounds.width, height: view.bounds.height * 0.5))
            
            // UIFieldBehaviotrの範囲の描画
            let fieldBehaviorRegionView = UIView(frame: CGRect(x: field.position.x, y: field.position.y, width: view.bounds.width, height: view.bounds.height))
            fieldBehaviorRegionView.layer.borderWidth = 1
            fieldBehaviorRegionView.layer.borderColor = UIColor.green.cgColor
            self.view.addSubview(fieldBehaviorRegionView)
        }
    }
    
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        let location = sender.location(in: view)
        let velocity = sender.velocity(in: view)
        let magnitude = sqrt((velocity.x*velocity.x) + (velocity.y*velocity.y))
        switch sender.state {
        case .began:
            attachment.anchorPoint = location
            dynamicAnimator.addBehavior(attachment)
        case .changed:
            attachment.anchorPoint = location
        case .cancelled, .ended, .failed, .possible:
            let push = UIPushBehavior(items: [self.orangeView], mode: .instantaneous)
            push.pushDirection = CGVector(dx: velocity.x, dy: velocity.y)
            push.magnitude = magnitude * magnitudeMultiplier
            itemBehavior.addLinearVelocity(velocity, for: self.orangeView)
            dynamicAnimator.removeBehavior(attachment)
            dynamicAnimator.addBehavior(push)
        @unknown default:
            fatalError()
        }
    }

}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        EmptyAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        EmptyAnimator()
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        presentingAnimator
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        dismissingAnimator
    }
}

class ModalViewController: UIViewController {
    lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        button.setTitle("Dismiss", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.addTarget(self, action: #selector(didPressDismiss), for: .touchUpInside)
        view.backgroundColor = .red
        view.layer.cornerRadius = 15.0
    }
    
    @objc func didPressDismiss() {
        dismiss(animated: true)
    }
}

extension ModalViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        DropOutAnimator(duration: 1.5, isAppearing: true)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        DropOutAnimator(duration: 4.0, isAppearing: false)
    }
}

class DropOutAnimator: UIDynamicBehavior {
    let duration: TimeInterval
    let isAppearing: Bool
    
    var transitionContext: UIViewControllerContextTransitioning?
    var hasElapsedTimeExceededDuration = false
    var finishTime: TimeInterval = 0.0
    var collisionBehavior: UICollisionBehavior?
    var attachmentBehavior: UIAttachmentBehavior?
    var animator: UIDynamicAnimator?
    
    init(duration: TimeInterval = 1.0, isAppearing: Bool) {
        self.duration = duration
        self.isAppearing = isAppearing
        super.init()
    }
}

extension DropOutAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
              let toVC = transitionContext.viewController(forKey: .to),
              let fromView = fromVC.view,
              let toView = toVC.view else {
            return
        }
        let containerView = transitionContext.containerView
        let duration = self.transitionDuration(using: transitionContext)
        // 完了通知のために、参照を保持
        self.transitionContext = transitionContext
        
        let animator = UIDynamicAnimator(referenceView: containerView)
        animator.delegate = self
        self.animator = animator
        
        if self.isAppearing {
            fromView.isUserInteractionEnabled = false
            let fromViewInitialFrame = transitionContext.initialFrame(for: fromVC)
            var toViewInitialFrame = toView.frame
            toViewInitialFrame.origin.y -= toViewInitialFrame.height
            toViewInitialFrame.origin.x = fromViewInitialFrame.width * 0.5 - toViewInitialFrame.width
            toView.frame = toViewInitialFrame
            containerView.addSubview(toView)
            
            // 回転しないようにして、弾むようにする
            let bodyBehavior = UIDynamicItemBehavior(items: [toView])
            bodyBehavior.elasticity = 0.7
            bodyBehavior.allowsRotation = false
            // 重力
            let gravityBehavior = UIGravityBehavior(items: [toView])
            gravityBehavior.magnitude = 10.0
            // 衝突
            let collisionBehavior = UICollisionBehavior(items: [toView])
            let insets = UIEdgeInsets(top: toViewInitialFrame.minY, left: 0.0, bottom: fromViewInitialFrame.height * 0.5 - toViewInitialFrame.height * 0.5, right: 0.0)
            collisionBehavior.setTranslatesReferenceBoundsIntoBoundary(with: insets)
            self.collisionBehavior = collisionBehavior
            
            self.finishTime = duration + (self.animator?.elapsedTime ?? 0.0)
            
            self.action = { [weak self] in
                guard let strongSelf = self,
                      (strongSelf.animator?.elapsedTime ?? 0.0) >= strongSelf.finishTime else {
                          return
                      }
                strongSelf.hasElapsedTimeExceededDuration = true
                strongSelf.animator?.removeBehavior(strongSelf)
            }
            
            self.addChildBehavior(collisionBehavior)
            self.addChildBehavior(bodyBehavior)
            self.addChildBehavior(gravityBehavior)
            
            self.animator?.addBehavior(self)
        } else {
            // 回転しないようにして、弾むようにする
            let bodyBehavior = UIDynamicItemBehavior(items: [fromView])
            bodyBehavior.elasticity = 0.8
            bodyBehavior.angularResistance = 5.0
            bodyBehavior.allowsRotation = true
            // 重力
            let gravityBehavior = UIGravityBehavior(items: [fromView])
            gravityBehavior.magnitude = 10.0
            // 衝突
            let collisionBehavior = UICollisionBehavior(items: [fromView])
            let insets = UIEdgeInsets(top: 0.0, left: -1000, bottom: -225, right: -1000)
            collisionBehavior.setTranslatesReferenceBoundsIntoBoundary(with: insets)
            self.collisionBehavior = collisionBehavior
            
            let offset = UIOffset(horizontal: 70.0, vertical: fromView.bounds.height * 0.5)
            var anchorPoint = CGPoint(x: fromView.bounds.maxX - 40.0, y: fromView.bounds.minY)
            anchorPoint = containerView.convert(anchorPoint, to: fromView)
            let attachmentBehavior = UIAttachmentBehavior(item: fromView, offsetFromCenter: offset, attachedToAnchor:  anchorPoint)
            attachmentBehavior.frequency = 3.0
            attachmentBehavior.damping = 3.0
            self.attachmentBehavior = attachmentBehavior
            
            self.addChildBehavior(collisionBehavior)
            self.addChildBehavior(bodyBehavior)
            self.addChildBehavior(gravityBehavior)
            self.addChildBehavior(attachmentBehavior)
            
            self.animator?.addBehavior(self)
            
            self.finishTime = (2.0/3.0) * duration + (self.animator?.elapsedTime ?? 0.0)
            
            self.action = { [weak self] in
                guard let strongSelf = self,
                      (strongSelf.animator?.elapsedTime ?? 0.0) >= strongSelf.finishTime else {
                          return
                      }
                strongSelf.hasElapsedTimeExceededDuration = true
                strongSelf.animator?.removeBehavior(strongSelf)
            }
        }
    }
    
}

extension DropOutAnimator: UIDynamicAnimatorDelegate {
    func dynamicAnimatorDidPause(_ animator: UIDynamicAnimator) {
        if self.isAppearing {
            if self.hasElapsedTimeExceededDuration {
                let toView = self.transitionContext?.viewController(forKey: .to)?.view
                let containerView = self.transitionContext?.containerView
                toView?.center = containerView?.center ?? .zero
                self.hasElapsedTimeExceededDuration = false
            }
            self.transitionContext?.completeTransition(!(self.transitionContext?.transitionWasCancelled ?? false))
            self.childBehaviors.forEach { self.removeChildBehavior($0) }
            animator.removeAllBehaviors()
            self.transitionContext = nil
        } else {
            if let attachmentBehavior = self.attachmentBehavior {
                self.removeChildBehavior(attachmentBehavior)
                self.attachmentBehavior = nil
                animator.addBehavior(self)
                let duration = self.transitionDuration(using: self.transitionContext)
                self.finishTime = 1.0 / 3.0 * duration + animator.elapsedTime
            } else {
                let fromView = self.transitionContext?.viewController(forKey: .from)?.view
                let toView = self.transitionContext?.viewController(forKey: .to)?.view
                fromView?.removeFromSuperview()
                toView?.isUserInteractionEnabled = true
                self.transitionContext?.completeTransition(!(self.transitionContext?.transitionWasCancelled ?? false))
                self.childBehaviors.forEach { self.removeChildBehavior($0) }
                animator.removeAllBehaviors()
                self.transitionContext = nil
            }
        }
    }
}

class EmptyAnimator: NSObject {
    
}

extension EmptyAnimator: UIViewControllerAnimatedTransitioning {
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.0
    }
}

class ShadeAnimator: UIDynamicBehavior {
    let isAppearing: Bool
    weak var presentingVC: UIViewController?
    weak var presentedVC: UIViewController?
    weak var transitionDelegate: UIViewControllerTransitioningDelegate?
    let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
    var transitionContext: UIViewControllerContextTransitioning?
    var finishTime: TimeInterval = 4.0
    lazy var pan: UIPanGestureRecognizer = {
        .init(target: self, action: #selector(self.handlePan(sender:)))
    }()
    lazy var animator: UIDynamicAnimator! = {
        UIDynamicAnimator(referenceView: self.transitionContext!.containerView)
    }()
    
    init(isAppearing: Bool, presentingVC: UIViewController, presentedVC: UIViewController, transitionDelegate: UIViewControllerTransitioningDelegate) {
        self.isAppearing = isAppearing
        self.presentedVC = presentedVC
        self.presentingVC = presentingVC
        self.transitionDelegate = transitionDelegate
        super.init()
        self.impactFeedbackGenerator.prepare()
        if isAppearing {
            self.presentingVC?.view.addGestureRecognizer(pan)
        } else {
            self.presentedVC?.view.addGestureRecognizer(pan)
        }
    }
    
    func setupViewForTransition(with transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
              let toVC = transitionContext.viewController(forKey: .to),
              let toView = toVC.view else {
                  return
              }
        let containerView = transitionContext.containerView
        self.transitionContext = transitionContext
        if isAppearing {
            let fromViewInitialFrame = transitionContext.initialFrame(for: fromVC)
            var toViewInitialFrame = toView.frame
            toViewInitialFrame.origin.y -= toViewInitialFrame.height
            toViewInitialFrame.origin.x = fromViewInitialFrame.width * 0.5 - toViewInitialFrame.width * 0.5
            toView.frame = toViewInitialFrame
            
            containerView.addSubview(toView)
        } else {
            fromVC.view.addGestureRecognizer(pan)
        }
    }
    
    @objc
    func handlePan(sender: UIPanGestureRecognizer) {
        let location = sender.location(in: transitionContext?.containerView)
        let velocity = sender.velocity(in: transitionContext?.containerView)
        let fromVC = transitionContext?.viewController(forKey: .from)
        let toVC = transitionContext?.viewController(forKey: .to)
        
        let touchStartHeight: CGFloat = 0.0
        let touchLocationFromBottom: CGFloat = 0.0
        switch sender.state {
        case .began:
            let beginLocation = sender.location(in: sender.view)
            if isAppearing {
                guard beginLocation.y <= touchStartHeight,
                      let presentedVC = self.presentedVC else {
                          break
                      }
                presentedVC.modalPresentationStyle = .custom
                presentedVC.transitioningDelegate = transitionDelegate
                presentingVC?.present(presentedVC, animated: true)
            } else {
                guard beginLocation.y <= (sender.view?.frame.height ?? 0.0) - touchStartHeight else {
                    break
                }
                presentedVC?.dismiss(animated: true)
            }
        case .changed:
            guard let view = isAppearing ? toVC?.view : fromVC?.view else {
                return
            }
            UIView.animate(withDuration: 0.2) {
                view.frame.origin.y = location.y - view.bounds.height + touchLocationFromBottom
            }
            transitionContext?.updateInteractiveTransition(view.frame.maxY / view.frame.height)
        case .ended, .cancelled:
            guard let view = isAppearing ? toVC?.view : fromVC?.view else {
                return
            }
            let isCancelled = isAppearing ? (velocity.y < 0.5 || view.center.y < 0.0) : (velocity.y > 0.5 || view.center.y > 0.0)
            addAttachmentBehavior(with: view, isCancelled: isCancelled)
            addCollisionBehavior(with: view)
            addItemBehavior(with: view)
            
            animator.addBehavior(self)
            animator.delegate = self
            
            self.action = { [weak self] in
                guard let strongSelf = self else {
                    return
                }
                if strongSelf.animator.elapsedTime > strongSelf.finishTime {
                    strongSelf.animator.removeAllBehaviors()
                } else {
                    strongSelf.transitionContext?.updateInteractiveTransition(view.frame.maxY / view.frame.height)
                }
            }
        default:
            break
        }
    }
    
    func addCollisionBehavior(with view: UIView) {
        let collisionBehavior = UICollisionBehavior(items: [view])
        let insets = UIEdgeInsets(top: -view.bounds.height, left: 0.0, bottom: 0.0, right: 0.0)
        collisionBehavior.setTranslatesReferenceBoundsIntoBoundary(with: insets)
        collisionBehavior.collisionDelegate = self
        self.addChildBehavior(collisionBehavior)
    }
    
    func addAttachmentBehavior(with view: UIView, isCancelled: Bool) {
        let anchor: CGPoint
        switch (isAppearing, isCancelled) {
        case (true, true), (false, false):
            anchor = CGPoint(x: view.center.x, y: -view.frame.height)
        case (true, false), (false, true):
            anchor = CGPoint(x: view.center.x, y: view.frame.height)
        }
        let attachmentBehavior = UIAttachmentBehavior(item: view, attachedToAnchor: anchor)
        attachmentBehavior.damping = 0.1
        attachmentBehavior.frequency = 3.0
        attachmentBehavior.length = 0.5 * view.frame.height
        self.addChildBehavior(attachmentBehavior)
    }
    
    func addItemBehavior(with view: UIView) {
        let itemBehavior = UIDynamicItemBehavior(items: [view])
        itemBehavior.allowsRotation = false
        itemBehavior.elasticity = 0.6
        self.addChildBehavior(itemBehavior)
    }
}

extension ShadeAnimator: UIDynamicAnimatorDelegate {
    func dynamicAnimatorDidPause(_ animator: UIDynamicAnimator) {
        guard let transitionContext = self.transitionContext else {
            return
        }
        let fromVC = transitionContext.viewController(forKey: .from)
        let toVC = transitionContext.viewController(forKey: .to)
        guard let view = isAppearing ? toVC?.view : fromVC?.view else {
            return
        }
        switch (view.center.y < 0.0, isAppearing) {
        case (true, true), (true, false):
            view.removeFromSuperview()
            transitionContext.finishInteractiveTransition()
            transitionContext.completeTransition(!isAppearing)
        case (false, true):
            toVC?.view.frame = transitionContext.finalFrame(for: toVC!)
            transitionContext.finishInteractiveTransition()
            transitionContext.completeTransition(true)
        case (false, false):
            fromVC?.view.frame = transitionContext.initialFrame(for: fromVC!)
            transitionContext.cancelInteractiveTransition()
            transitionContext.completeTransition(false)
        }
        childBehaviors.forEach { removeChildBehavior($0) }
        animator.removeAllBehaviors()
        self.animator = nil
        self.transitionContext = nil
    }
}

extension ShadeAnimator: UICollisionBehaviorDelegate {
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        guard p.y > 0.0 else {
            return
        }
        impactFeedbackGenerator.impactOccurred()
    }
}

extension ShadeAnimator: UIViewControllerInteractiveTransitioning {
    func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        setupViewForTransition(with: transitionContext)
    }
}
