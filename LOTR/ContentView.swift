//
//  ContentView.swift
//  LOTR
//
//  Created by Eri on 25.12.24.
//

import SwiftUI
import TipKit

struct ContentView: View {
    @State var showExchangeInfo = false
    
    @State var leftAmount = ""
    @State var rightAmount = ""
    
    @FocusState var leftTyping
    @FocusState var rightTyping
    
    @State var showSelectCurrency = false
    
    @State var leftCurrency: Currency = .silverPiece
    
    @State var rightCurrency: Currency = .goldPiece
    
    let currencyTip = CurrencyTip()
    
    
    var body: some View {
        ZStack {
            //Background Image
            Image(.background)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                //Prancing Pony Image
                Image(.prancingpony)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                
                //Currency Exchange Text
                Text("Currency Exchange")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                
                //Conversion section
                HStack {
                    // Left Conversion Section
                    VStack {
                        // Currency
                        HStack {
                            // Currency Image
                            Image(leftCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33)
                            
                            // Currency Text
                            Text(leftCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                        }
                        
                        .padding(.bottom, -5)
                        .onTapGesture {
                            showSelectCurrency.toggle()
                            currencyTip.invalidate(reason: .actionPerformed)
                        }
                        // Text Field
                        TextField("Amount", text: $leftAmount)
                            .textFieldStyle(.roundedBorder)
                            .focused($leftTyping)
                        
                        
                        
                    }
                    .popoverTip(currencyTip, arrowEdge: .bottom)
                    
                    // Equal Sign
                    Image(systemName: "equal")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .symbolEffect(.pulse)
                    
                    // Right Conversion Section
                    VStack {
                        // Currency
                        HStack {
                            // Currency Text
                            Text(rightCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                            // Currency Image
                            Image(rightCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33)
                        }
                        .padding(.bottom, -5)
                        .onTapGesture {
                            showSelectCurrency.toggle()
                            currencyTip.invalidate(reason: .actionPerformed)
                        }
                        
                        // Text Field
                        TextField("Amount", text: $rightAmount)
                            .textFieldStyle(.roundedBorder)
                            .focused($rightTyping)
                            .multilineTextAlignment(.trailing)
                        
                    }
                }
                .padding()
                .background(.black.opacity(0.5))
                .clipShape(.capsule)
                .keyboardType(.decimalPad)
                
                Spacer()
                
                // Info Button
                HStack {
                    Spacer()
                    
                    Button {
                        showExchangeInfo.toggle()
                    } label: {
                        Image(systemName: "info.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                    }
                    .padding(.trailing)
                }
            }
        }
        .onTapGesture {
            leftTyping = false
            rightTyping = false
        }
        .task {
            try? Tips.configure()
        }
        .onChange(of: leftAmount) {
            if leftTyping == true {
                rightAmount = leftCurrency.convert(leftAmount, to: rightCurrency)
            }
        }
        .onChange(of: rightAmount) {
            if rightTyping == true {
                leftAmount = rightCurrency.convert(rightAmount, to: leftCurrency)}
        }
        .onChange(of: leftCurrency) {
            leftAmount = rightCurrency.convert(rightAmount, to: leftCurrency)
        }
        .onChange(of: rightCurrency) {
            rightAmount = leftCurrency.convert(leftAmount, to: rightCurrency)
        }
        .sheet(isPresented: $showExchangeInfo) {
            ExchangeInfo()
        }
        .sheet(isPresented: $showSelectCurrency) {
            SelectCurrency(topCurrency: $leftCurrency, bottomCurrency: $rightCurrency)
            //             .border(.blue)
        }
    }
}

#Preview {
    ContentView()
}
