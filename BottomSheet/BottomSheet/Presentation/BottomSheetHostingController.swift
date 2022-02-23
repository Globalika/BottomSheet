//
//  BottomSheetHostingController.swift
//  BottomSheet
//
//  Created by Volodymyr Seredovych on 22.02.2022.
//

import UIKit
import SwiftUI

class BottomSheetHostingController<Content: View>: UIViewController {
    var onDismiss: (() -> Void)?
    var content: Content
    
    override func viewDidDisappear(_ animated: Bool) {
        onDismiss?()
    }
    
    init(content: Content) {
        self.content = content
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var scrollableContent: UIScrollView = {
        let view = UIScrollView()
        view.alwaysBounceVertical = true
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
    
    func setDismissButtonConstraints() {
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
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
        dragableIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dragableIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dragableIndicator.topAnchor.constraint(equalTo: view.topAnchor, constant: 6),
            dragableIndicator.widthAnchor.constraint(equalToConstant: 30),
            dragableIndicator.heightAnchor.constraint(equalToConstant: 6),
        ])
    }
    
//    func setupScrollabelView() {
//        view.addSubview(scrollableContent)
//        setScrollabelViewConstraints()
//    }
//
//    func setScrollabelViewConstraints() {
//        scrollableContent.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            scrollableContent.topAnchor.constraint(equalTo: self.dismissButton.bottomAnchor),
//            scrollableContent.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -24),
//            scrollableContent.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
//            scrollableContent.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24)
//        ])
//    }
    
    func addChildView() {
        let child = UIHostingController<Content>(rootView: content)
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
