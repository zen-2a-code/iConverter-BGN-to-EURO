//
//  ContentView.swift
//  iEuro&BGN
//
//  Created by Stoyan Hristov on 4.01.26.
//

import SwiftUI

struct ContentView: View {
    @State private var bgnAmount: String = ""
    @State private var euroAmount: String = ""
    @FocusState private var isBGNFocused: Bool
    @FocusState private var isEuroFocused: Bool
    private var rate = 1.95583 // 1 Еuro to BGN
    
    private let formatter = NumberFormatter()
    private var isAnyFieldFoccused: Bool { isBGNFocused || isEuroFocused }

    var body: some View {
        ZStack {
            ZStack {
                Image("Flag_of_Bulgaria")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .scaleEffect(1.30)
                
                Image("euFlag")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .scaleEffect(1.02)
                    .offset(y: 4)
                    .overlay {
                        Rectangle()
                            .fill(.regularMaterial)
                            .blendMode(.color)
                    }
                    .mask(
                        LinearGradient(
                            colors: [.black, .clear],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
            }
            .ignoresSafeArea()
            .ignoresSafeArea(.keyboard)
                
            VStack {
                OutlinedText(text: "Euro&BGN converter")
                Spacer()
                    
                VStack(alignment: .leading, spacing: 10) {
                    CurrencyView(currencyName: "Bulgarian Lev:", currencyISO: "BGN", amount: $bgnAmount, isAmountFocused: $isBGNFocused)
                        
                    CurrencyView(currencyName: "Euro:", currencyISO: "Euro", amount: $euroAmount, isAmountFocused: $isEuroFocused)
                }
                .onChange(of: bgnAmount) { _, newValue in
                    if isBGNFocused {
                        performBgnToEuroConversion(newValue)
                    }
                }
                .onChange(of: euroAmount) { _, newValue in
                    if isEuroFocused {
                        performEuroToBgnConversion(newValue)
                    }
                }
            }
        }
        .colorScheme(.dark)
        .onTapGesture {
            isBGNFocused = false
            isEuroFocused = false
        }
    }
    
    func performBgnToEuroConversion(_ newValue: String) {
        formatter.decimalSeparator = "."
        
        guard let bgnValue = formatter.number(from: newValue.replacingOccurrences(of: ",", with: ".")) else {
            euroAmount = ""
            return
        }
        euroAmount = String(format: "%.5f", bgnValue.doubleValue / rate)
    }
    
    func performEuroToBgnConversion(_ newValue: String) {
        formatter.decimalSeparator = "."
        
        guard let euroValue = formatter.number(from: newValue.replacingOccurrences(of: ",", with: ".")) else {
            bgnAmount = ""
            return
        }
        bgnAmount = String(format: "%.5f", euroValue.doubleValue * rate)
        print("The value is: \(bgnAmount)")
    }
}

#Preview {
    ContentView()
}
