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
        HStack(alignment: .center, spacing: 14.0) {
            ZStack {
                Circle()
                    .fill(Color(colorScheme == .dark ? .systemBackground : .secondarySystemBackground))
                if #available(iOS 16.1, *) {
                    Text("\(index)")
                        .opacity(0.65)
                        .font(.system(size: 22.0).monospacedDigit().weight(.regular))
                        .fontDesign(.rounded)
                        .padding(12.0)
                } else {
                    Text("\(index)")
                        .opacity(0.65)
                        .font(.system(size: 22.0).monospacedDigit().weight(.light))
                        .padding(12.0)
                }
            }
            .fixedSize()
            Text(bodyText)
            Spacer(minLength: 0)
        }
        .padding()
        .background(Color(colorScheme == .dark ? .secondarySystemBackground : .systemBackground))
        .cornerRadius(32.0)
        .padding([.top, .bottom], 4)
//        .padding([.leading, .trailing], 8)
        .shadow(color: colorScheme == .dark ? Color.clear : Color(red: 0, green: 0, blue: 0, opacity: 0.06), radius: 16, x: 0, y: 4)
        .opacity(isVisible ? 1.0 : 0.0)
        .offset(x: isVisible ? 0.0 : -300.0)
        .onAppear {
            guard let transitionAfter else {
                isVisible = true
                return
            }
            withAnimation(.bouncy(duration: 0.65).delay(transitionAfter)) {
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
