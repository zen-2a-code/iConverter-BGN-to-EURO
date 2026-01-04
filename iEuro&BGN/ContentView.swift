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

    var body: some View {
        ZStack {
            LinearGradient(
                stops: [
                    .init(color: .white, location: 0.3),
                    .init(color: Color(red: 0.0, green: 0.59, blue: 0.35), location: 0.5),
                    .init(color: .red, location: 0.5),
                    .init(color: Color.clear, location: 0.7)
                ],
                startPoint: .top,
                endPoint: .bottomTrailing
            )
            
            Image("euFlag")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .scaleEffect(1.1)
                .offset(y: 4)
                .mask {
                    RadialGradient(stops: [
                        .init(color: .clear, location: 0.8),
                        .init(color: .black, location: 0.9) // Fades the flag in
                    ], center: .center, startRadius: 1, endRadius: 300)
                }
                .ignoresSafeArea()
            
            Rectangle()
                .fill(.regularMaterial.blendMode(.color))
                .overlay {
                    Color.blue.opacity(0.15)
                }
                .ignoresSafeArea()
            
            VStack {
                
                OutlinedText(text: "Euro ↔ BGN converter")
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
        euroAmount = String(format: "%.5f", (bgnValue.doubleValue / rate))
    }
    
    func performEuroToBgnConversion(_ newValue: String) {
        formatter.decimalSeparator = "."
        
        guard let euroValue = formatter.number(from: newValue.replacingOccurrences(of: ",", with: ".")) else {
            bgnAmount = ""
            return
        }
        bgnAmount = String(format: "%.5f", (euroValue.doubleValue * rate))
        print("The value is: \(bgnAmount)")
    }
}

#Preview {
    ContentView()
}
