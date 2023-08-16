//
//  InstructionsListItem.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 7/11/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import SwiftUI

struct InstructionsListItem: View {
    @Environment(\.colorScheme) var colorScheme
    
    var index: Int
    var bodyText: LocalizedStringKey
    var transitionAfter: TimeInterval?
    
    @State private var isVisible = false
    
    var body: some View {
        HStack(alignment: .top) {
            Text("\(index).")
                .font(.title2.monospacedDigit().weight(.semibold))
            Text(bodyText)
                .padding([.top], 5)
            Spacer()
        }
        .padding()
        .background(Color(colorScheme == .light ? .systemBackground : .secondarySystemBackground))
        .cornerRadius(12.0)
        .padding([.top, .bottom], 4)
        .padding([.leading, .trailing], 8)
        .shadow(color: colorScheme == .light ? Color(red: 0, green: 0, blue: 0, opacity: 0.1) : Color.clear, radius: 16, x: 0, y: 4)
        .opacity(isVisible ? 1.0 : 0.0)
        .offset(x: isVisible ? 0.0 : -300.0)
        .onAppear {
            guard let transitionAfter else {
                isVisible = true
                return
            }
            withAnimation(.easeOut(duration: 0.8).delay(transitionAfter)) {
                isVisible = true
            }
        }
        .onDisappear {
            isVisible = false
        }
    }
}

struct InstructionsListItem_Previews: PreviewProvider {
    static private let loremIpsum: LocalizedStringKey = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque convallis ultrices enim, in porttitor ante tincidunt nec. Morbi ullamcorper lectus placerat, egestas tellus eget, condimentum arcu. Etiam cursus lacus ipsum, ac iaculis ligula lobortis et. Nulla et ultrices ipsum. Etiam suscipit auctor nisi sed vestibulum. Curabitur ac tempus lacus. Nam sit amet arcu massa."
    
    static var previews: some View {
        VStack(alignment: .leading) {
            InstructionsListItem(index: 1, bodyText: "Colorless green ideas sleep furiously.", transitionAfter: 0.5)
            InstructionsListItem(index: 2, bodyText: Self.loremIpsum)
        }
        .padding()
    }
}
