//
//  ContentView.swift
//  BottomSheet
//
//  Created by Volodymyr Seredovych on 21.02.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var isPresented = false
    @State private var chosenModel: DetailsModel?
    let models = DetailsModel.models

    var body: some View {
        VStack {
            ForEach(models, id: \.self) { model in
                Text("\(model.title ?? "- - - -")")
                .padding()
                .onTapGesture {
                    self.chosenModel = model
                    isPresented.toggle()
                }
            }
        }
        .bottomSheet(isPresented: $isPresented, onDismiss: { isPresented = false }) {
            DetailsView(model: $chosenModel)
        }
    }
}
