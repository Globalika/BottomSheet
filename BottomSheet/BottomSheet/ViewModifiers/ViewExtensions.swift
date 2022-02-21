//
//  ViewExtensions.swift
//  BottomSheet
//
//  Created by Volodymyr Seredovych on 21.02.2022.
//

import SwiftUI

extension View {
    func bottomSheet<Content: View>(isPresented: Binding<Bool>, onDismiss: (() -> Void)? = nil, @ViewBuilder content: () -> Content) -> some View {
        ModifiedContent(content: self, modifier: BottomSheetModifier(isPresented: isPresented, sheetContent: content(), onDismiss: onDismiss))
    }
}
