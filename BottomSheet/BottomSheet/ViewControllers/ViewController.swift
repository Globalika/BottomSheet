//
//  ViewController.swift
//  BottomSheet
//
//  Created by Volodymyr Seredovych on 21.02.2022.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    var button: UIButton = {
        let button = UIButton()
        button.setTitle("price details", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.frame = CGRect(x: 15, y: -50, width: 300, height: 500)
        button.addTarget(self, action: #selector(showDetails), for: .touchUpInside)
        return button
    }()

    @objc
    func showDetails() {
        let rootView = RootView()
        let viewController = UIHostingController<RootView>(rootView: rootView)
        self.present(viewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        view.addSubview(button)
    }
}

struct RootView: View {
    var body: some View {
        ScrollView {
            VStack {
                Text("title")
                ContentView()
                Text("footer")
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }.background(.white)
    }
}
