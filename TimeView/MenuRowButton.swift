//
//  MenuRowButton.swift
//  TimeView
//
//  Created by Pedro Henrique on 25/10/26.
//

import SwiftUI

struct MenuRowButton: View {
    let title: String
    let action: () -> Void
    @State private var isHovered = false
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 8)
                .padding(.vertical, 2)
                .background(isHovered ? Color.primary.opacity(0.08) : .clear, in: .capsule)
                .contentShape(.capsule)
        }
        .buttonStyle(.plain)
        .onHover { isHovered = $0 }
    }
}
