//
//  BottomSheetPresenter.swift
//  BottomSheet
//
//  Created by Volodymyr Seredovych on 21.02.2022.
//

import UIKit
import SwiftUI

class BottomSheetPresenter<Content: View>: UIViewController {
    lazy var transition = BottomSheetPresentationManager()
    var hostingController: CustomUIHostingController<Content>?
    var onDismiss: (() -> Void)?

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let hostingController = hostingController else { return }
        hostingController.onDismiss = onDismiss
        hostingController.transitioningDelegate = transition
        hostingController.modalPresentationStyle = .custom
        hostingController.view.backgroundColor = UIColor(.white)
        present(hostingController, animated: true, completion: nil)
    }
}

class CustomUIHostingController<Content>: UIHostingController<Content> where Content: View {
    var onDismiss: (() -> Void)?
    override func viewWillDisappear(_ animated: Bool) {
        onDismiss?()
    }
}
