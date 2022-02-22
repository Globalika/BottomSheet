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
    
    override func viewDidLoad() {
        //addDismissButton()
    }
    
    @objc func dismissSelf() {
        self.dismiss(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        onDismiss?()
    }
}

class BottomSheetHostingController<Content>: UIHostingController<Content> where Content: View {
    var onDismiss: (() -> Void)?
    
    var dismissButton: UIButton = {
        var button = UIButton()
        button.setTitle("X", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.scalesLargeContentImage = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(dismissSelf), for: .touchUpInside)
        return button
    }()

    var dragableIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 3
        view.layer.masksToBounds = true
        return view
    }()
    
    override func viewDidLoad() {
        configureController()
    }
    
    @objc func dismissSelf() {
        self.dismiss(animated: true)
    }

    func configureController() {
        view.backgroundColor = .lightGray
        funcSetupSubViews()
    }
    
    func funcSetupSubViews() {
        setupDismissButton()
        setupDragableIndicator()
        addChildView()
    }
    
    func setupDismissButton() {
        view.addSubview(dismissButton)
        setDismissButtonConstraints()
    }
    
    func setupDragableIndicator() {
        view.addSubview(dragableIndicator)
        setDragableIndicatorConstraints()
    }
    
    func setDismissButtonConstraints() {
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dismissButton.topAnchor.constraint(equalTo: view.topAnchor),
            dismissButton.widthAnchor.constraint(equalToConstant: 24),
            dismissButton.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
    
    func setDragableIndicatorConstraints() {
        dragableIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dragableIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dragableIndicator.topAnchor.constraint(equalTo: view.topAnchor, constant: 6),
            dragableIndicator.widthAnchor.constraint(equalToConstant: 30),
            dragableIndicator.heightAnchor.constraint(equalToConstant: 6),
        ])
    }
    
    func addChildView() {
        let child = UIHostingController<Content>(rootView: self.rootView)
        child.view.backgroundColor = .white
        self.addChild(child)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(child.view)
        child.didMove(toParent: self)
        NSLayoutConstraint.activate([
            child.view.topAnchor.constraint(equalTo: self.dismissButton.bottomAnchor),
            child.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -24),
            child.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            child.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24)
        ])
    }
}
