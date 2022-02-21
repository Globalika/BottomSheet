//
//  BottomSheetModifier.swift
//  BottomSheet
//
//  Created by Volodymyr Seredovych on 21.02.2022.
//

import SwiftUI

struct BottomSheetModifier<SheetContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    var sheetContent: SheetContent
    var onDismiss: (() -> Void)?
    
    func body(content: Content) -> some View {
        content
        .background( ZStack {
            if isPresented {
                BottomSheetContainer(content: sheetContent, isPresented: isPresented, onDismiss: onDismiss)
            }
        })
    }
}

private struct BottomSheetContainer<Content: View>: UIViewControllerRepresentable {
    let content: Content
    @State var isPresented: Bool = false
    var onDismiss: (() -> Void)?
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<BottomSheetContainer>) -> UIViewController {
        let proxyController = BottomSheetPresenter<Content>()
        proxyController.onDismiss = onDismiss
        proxyController.hostingController = UIHostingController(rootView: content)
        return proxyController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) { }
    
    static func dismantleUIViewController(_ uiViewController: UIViewController, coordinator: ()) {
        guard let controller = uiViewController as? BottomSheetPresenter<Content> else { return }
        controller.hostingController?.dismiss(animated: true, completion: nil)
    }
}
