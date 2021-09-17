//
//  ExpandedKeyBezierPath.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 9/16/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import SwiftUI

struct ExpandedKeyBezierPath: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.width / 4 + 4, y: rect.maxY))
        path.addQuadCurve(to: CGPoint(x: rect.width / 4, y: rect.maxY - 4), control: CGPoint(x: rect.width / 4, y: rect.maxY))
        
        path.addLine(to: CGPoint(x: rect.width / 4, y: 16 * rect.height / 24))
        path.addQuadCurve(to: CGPoint(x: rect.width / 8, y: 13 * rect.height / 24), control: CGPoint(x: rect.width / 4, y: 15 * rect.height / 24))
        path.addQuadCurve(to: CGPoint(x: rect.minX, y: 10 * rect.height / 24), control: CGPoint(x: rect.minX, y: 11 * rect.height / 24))
        
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + 12))
        path.addQuadCurve(to: CGPoint(x: rect.minX + 12, y: rect.minY), control: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - 12, y: rect.minY))
        path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.minY + 12), control: CGPoint(x: rect.maxX, y: rect.minY))
        
        path.addLine(to: CGPoint(x: rect.maxX, y: 10 * rect.height / 24))
        path.addQuadCurve(to: CGPoint(x: 7 * rect.width / 8, y: 13 * rect.height / 24), control: CGPoint(x: rect.maxX, y: 11 * rect.height / 24))
        path.addQuadCurve(to: CGPoint(x: 3 * rect.width / 4, y: 16 * rect.height / 24), control: CGPoint(x: 3 * rect.width / 4, y: 15 * rect.height / 24))
        
        path.addLine(to: CGPoint(x: 3 * rect.width / 4, y: rect.maxY - 4))
        path.addQuadCurve(to: CGPoint(x: 3 * rect.width / 4 - 4, y: rect.maxY), control: CGPoint(x: 3 * rect.width / 4, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        return path
    }
}

struct ExpandedKeyBezierPathView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var titleText: String
    var baseWidth: CGFloat
    var baseHeight: CGFloat
    
    var body: some View {
        ZStack {
            ExpandedKeyBezierPath()
                .stroke(Color(white: 0, opacity: 0.5), lineWidth: 0.5)
                .background(
                    ZStack {
                        if colorScheme == .dark {
                            VisualEffectView(effect: UIBlurEffect(style: .regular))
                            .clipShape(
                                ExpandedKeyBezierPath()
                            )
                        }
                        ExpandedKeyBezierPath()
                            .fill(colorScheme == .dark ? Color(white: 1, opacity: 0.3) : .white)
                    }
                )
                .frame(width: baseWidth * 2, height: baseHeight * 3, alignment: .bottom)
                .transformEffect(.init(translationX: 0, y: -baseHeight))
                .shadow(color: Color(white: 0, opacity: 0.3), radius: baseWidth * 0.25, x: 0, y: 0)
            Text(titleText)
                .font(.system(size: baseHeight * 1.25))
                .transformEffect(.init(translationX: 0, y: -baseHeight * 1.65))
        }
    }
}

struct ExpandedKeyBezierPath_Preview: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 4) {
            HStack {
                KeyButtonView(delegate: KeyButtonViewDelegate(title: "∅"))
                    .frame(width: 38, height: 38)
                ExpandedKeyBezierPathView(titleText: "∅", baseWidth: 38, baseHeight: 38)
                    .frame(width: 38 * 3, height: 38 * 2)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.secondarySystemBackground))
    }
}
