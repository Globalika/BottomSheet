//
//  BottomSheetPresentationController.swift
//  BottomSheet
//
//  Created by Volodymyr Seredovych on 21.02.2022.
//

import UIKit

class BottomSheetPresentationController: PresentationController {
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        containerView?.insertSubview(dimmView, at: 0)
        performAlongsideTransitionIfPossible { [unowned self] in
            self.dimmView.alpha = 1
        }
    }
    override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)
    
        if !completed {
            self.dimmView.removeFromSuperview()
        }
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
    
        performAlongsideTransitionIfPossible { [unowned self] in
            self.dimmView.alpha = 0
        }
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        super.dismissalTransitionDidEnd(completed)
    
        if completed {
            self.dimmView.removeFromSuperview()
        }
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        dimmView.frame = containerView!.frame
    }
    
    private func performAlongsideTransitionIfPossible(_ block: @escaping () -> Void) {
        guard let coordinator = self.presentedViewController.transitionCoordinator else {
            block()
            return
        }
    
        coordinator.animate(alongsideTransition: { (_) in
            block()
        }, completion: nil)
    }
    
    @objc func handleTap(recognizer: UITapGestureRecognizer) {
        presentedViewController.dismiss(animated: true)
    }
    
    private lazy var dimmView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        view.alpha = 0
        let recognizer = UITapGestureRecognizer(target: self,
                                                action: #selector(handleTap(recognizer:)))
        view.addGestureRecognizer(recognizer)
        return view
    }()
}
