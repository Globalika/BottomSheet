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
    var hostingController: BottomSheetHostingController<Content>?
    var onDismiss: (() -> Void)?

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let hostingController = hostingController else { return }
        hostingController.onDismiss = onDismiss
        hostingController.transitioningDelegate = transition
        hostingController.modalPresentationStyle = .custom
        present(hostingController, animated: true, completion: nil)
    }
}
