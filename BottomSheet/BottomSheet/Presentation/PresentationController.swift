//
//  PresentationController.swift
//  BottomSheet
//
//  Created by Volodymyr Seredovych on 22.02.2022.
//

import UIKit

class PresentationController: UIPresentationController {
   override var frameOfPresentedViewInContainerView: CGRect {
       guard let containerView = containerView, let presentedView = presentedView else { return .zero }
       let safeAreaFrame = containerView.bounds.inset(by: containerView.safeAreaInsets)
          let targetWidth = safeAreaFrame.width
       let fittingSize = CGSize(
           width: targetWidth,
           height: UIView.layoutFittingCompressedSize.height
       )
       let targetHeight = presentedView.systemLayoutSizeFitting(
           fittingSize,
           withHorizontalFittingPriority: .required,
           verticalFittingPriority: .defaultLow
       ).height
          var frame = safeAreaFrame
       let originY = max(containerView.frame.height - targetHeight - 20, containerView.frame.height/2)
       frame.origin.y += originY
       frame.size.width = targetWidth
       frame.size.height = targetHeight
       return frame
   }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        containerView?.addSubview(presentedView!)
        
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    var interactionController: BottomSheetInteractionController!
    override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)
        
        if completed {
            interactionController.direction = .dismiss
        }
    }
}
