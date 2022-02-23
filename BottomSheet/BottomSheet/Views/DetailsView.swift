//
//  DetailsView.swift
//  BottomSheet
//
//  Created by Volodymyr Seredovych on 21.02.2022.
//

import SwiftUI

struct DetailsView: View {
    @Binding var model: DetailsModel?

    var body: some View {
        ScrollView {
            VStack {
                title
                sections
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }//.frame(maxWidth: .infinity, maxHeight: 200)
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
