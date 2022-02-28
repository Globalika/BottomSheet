//
//  BottomSheetHostingController.swift
//  BottomSheet
//
//  Created by Volodymyr Seredovych on 22.02.2022.
//

import UIKit
import SwiftUI

class BottomSheetHostingController<Content: View>: UIViewController, UIScrollViewDelegate {
    var onDismiss: (() -> Void)?
    var content: Content
    
    override func viewDidDisappear(_ animated: Bool) {
        onDismiss?()
    }
    
    init(content: Content) {
        self.content = content
        hostingController = UIHostingController(rootView: content)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var hostingController: UIHostingController<Content>
    var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alwaysBounceVertical = false
        return view
    }()
    
    var contentView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.autoresizesSubviews = true
        return view
    }()
    
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
        view.translatesAutoresizingMaskIntoConstraints = false
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
        setupScrollView()
        addContentView()
    }
    
    func setupDismissButton() {
        view.addSubview(dismissButton)
        setDismissButtonConstraints()
    }
    
    func setDismissButtonConstraints() {
        NSLayoutConstraint.activate([
            dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dismissButton.topAnchor.constraint(equalTo: view.topAnchor),
            dismissButton.widthAnchor.constraint(equalToConstant: 24),
            dismissButton.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
    
    func setupDragableIndicator() {
        view.addSubview(dragableIndicator)
        setDragableIndicatorConstraints()
    }
    
    func setDragableIndicatorConstraints() {
        NSLayoutConstraint.activate([
            dragableIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dragableIndicator.topAnchor.constraint(equalTo: view.topAnchor, constant: 6),
            dragableIndicator.widthAnchor.constraint(equalToConstant: 30),
            dragableIndicator.heightAnchor.constraint(equalToConstant: 6),
        ])
    }

    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.backgroundColor = .clear
        setScrollViewConstraints()
        
    }

    func setScrollViewConstraints() {
        scrollView.backgroundColor = .white
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 24),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -24)
        ])
    }
    func addContentView() {
        hostingController.view.backgroundColor = .clear
        hostingController.willMove(toParent: self)
        self.addChild(hostingController)
        scrollView.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        print(hostingController.view.frame.height/2)
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            hostingController.view.firstBaselineAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            hostingController.view.lastBaselineAnchor.constraint(equalTo: scrollView.bottomAnchor),
            hostingController.view.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            hostingController.view.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
        hostingController.didMove(toParent: self)
    }
}
