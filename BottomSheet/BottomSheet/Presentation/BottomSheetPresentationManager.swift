//
//  BottomSheetPresentationManager.swift
//  BottomSheet
//
//  Created by Volodymyr Seredovych on 21.02.2022.
//

import UIKit

class BottomSheetPresentationManager: NSObject, UIViewControllerTransitioningDelegate {
    private let interactionController = BottomSheetInteractionController()
    
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        interactionController.link(to: presented)
        
        let presentationController = BottomSheetPresentationController(presentedViewController: presented,
                                                                       presenting: presenting ?? source)
        presentationController.interactionController = interactionController
        return presentationController
    }
    
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentAnimation()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimation()
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactionController
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactionController
    }
}
