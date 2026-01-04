//
//  CurrencyView.swift
//  iEuro&BGN
//
//  Created by Stoyan Hristov on 4.01.26.
//

import SwiftUI

struct CurrencyView: View {
    var currencyName: String
    var currencyISO: String
    @Binding var amount: String
    var isAmountFocused: FocusState<Bool>.Binding
    var body: some View {
        
        HStack {
            Text(currencyName)
                .foregroundStyle(.primary)
            
            HStack {
                TextField(currencyISO, text: $amount)
                    .keyboardType(.decimalPad)
                    .frame(width: currencyName == "Euro:" ? 180 : 125, alignment: .leading)
                    .foregroundStyle(.secondary)
                    .focused(isAmountFocused)
                
                Spacer()
                if !amount.isEmpty {
                    Button {
                        amount = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .padding()
        .frame(width: 300, alignment: .leading)
        .glassEffect(.clear.tint(.blue.opacity(0.3)).interactive(), in: .rect(cornerRadius: 20))
    }
}

struct PreviewView: View {
    var currencyName: String
    var currencyISO: String
    @State var amount: String
    @FocusState var isAmountFocused: Bool
    var body: some View {
        CurrencyView(currencyName: currencyName, currencyISO: currencyISO, amount: $amount, isAmountFocused: $isAmountFocused)
    }
}



#Preview("BGN") {
    ZStack {
        Color.blue
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(edges: .all)
        
        PreviewView(currencyName: "Bulgarian Lev:", currencyISO: "BGN", amount: "")
            .background(Color.blue)
        
    }
    .colorScheme(ColorScheme.dark)
   
}

#Preview("Euro") {
    ZStack {
        Color.blue
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(edges: .all)
        
        PreviewView(currencyName: "Euro:", currencyISO: "Euro", amount: "")
            .colorScheme(ColorScheme.dark)
    }
}
