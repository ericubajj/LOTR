//
//  CurrencyIcon.swift
//  LOTR
//
//  Created by Eri on 28.12.24.
//

import SwiftUI

struct CurrencyIcon: View {
    let currencyImage: ImageResource
    let currencyName: String
    
    
    var body: some View {
        
        // Currency Icons
        ZStack(alignment: .bottom) {
            // Currency Image
            Image(currencyImage)
                .resizable()
                .scaledToFit()
            
            // Currency Name
            Text(currencyName)
                .padding(3)
                .font(.caption)
                .frame(maxWidth: .infinity)
                .background(.brown.opacity(0.75))
        }
        .padding(3)
        .frame(width: 100,height: 100)
        .background(.brown)
        .clipShape(.rect(cornerRadius: 25))
    }
}
    #Preview {
        CurrencyIcon(currencyImage: .goldpiece, currencyName: "Gold Piece")
    }
    
