//
//  DetailsView.swift
//  BottomSheet
//
//  Created by Volodymyr Seredovych on 21.02.2022.
//

import SwiftUI

struct DetailsView: View {
    
    @Binding var model: DetailsModel?
    var onDismiss: (() -> Void)?
    
    @Environment(\.presentationMode) var presentation
    @State private var viewContentSize: CGSize = .zero
    @GestureState private var translation: CGFloat = .zero

    var body: some View {
        VStack {
            title
            sections
        }
    }
    
    @ViewBuilder
    var title: some View {
        Text("\(model?.title ?? "_-_-_-_")")
    }
    
    @ViewBuilder
    var sections: some View {
        VStack {
            if let sections = model?.sections {
                ForEach(sections, id: \.self) {
                    Text("\($0)")
                }
            }
        }
    }
}
