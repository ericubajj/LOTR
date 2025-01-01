//
//  IconGrid.swift
//  LOTR
//
//  Created by Eri on 28.12.24.
//

import SwiftUI

struct IconGrid: View {
    @Binding var currency: Currency
    
    var body: some View {
        // Currency Icons
        LazyVGrid(columns: [GridItem(), GridItem(),GridItem()]) {
            ForEach(Currency.allCases) { currency in
                if self.currency == currency {
                    CurrencyIcon(currencyImage: currency.image  , currencyName: currency.name)
                        .shadow(color: .black, radius: 10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 25).stroke(lineWidth: 3)
                                .opacity(0.5)
                        }
                } else {
                    CurrencyIcon(currencyImage: currency.image, currencyName: currency.name)
                        .onTapGesture {
                            self.currency = currency
                            print("IconGrid Currency: \(self.currency)")
                        }
                }
            }
        }
    }
        
    }
    #Preview {
        @Previewable @State var currency: Currency = .silverPiece
        
        IconGrid(currency: $currency)
    }
    
