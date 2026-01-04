//
//  OutlinedText.swift
//  iEuro&BGN
//
//  Created by Stoyan Hristov on 4.01.26.
//

import SwiftUI

struct OutlinedText: View {

    let text: String

    var body: some View {
        Text(text)
            .font(.largeTitle.weight(.heavy))
            .foregroundStyle(.secondary)
            .shadow(color: .black.opacity(0.8), radius: 1, x: 0, y: 0)
    }
}
