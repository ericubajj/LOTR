//
//  SelectCurrency.swift
//  LOTR
//
//  Created by Eri on 28.12.24.
//

import SwiftUI

struct SelectCurrency: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var topCurrency: Currency
    @Binding var bottomCurrency: Currency
    
    var body: some View {
        ZStack {
            // Parchment Background Image
            Image(.parchment)
                .resizable()
                .ignoresSafeArea()
                .background(.brown)
            
            VStack{
                // Text
                Text("Select the currency you are starting with:")
                    .fontWeight(.bold)
                    
                
                // Currency Icons
                IconGrid(currency: $topCurrency)
                
                
                
                // Text
                Text("Select the currency you would like to convert to:")
                    .fontWeight(.bold)
                    .padding(.top)
                
                // Currency Icons
                IconGrid(currency: $bottomCurrency)
                // Done Button
                Button("Done"){
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.brown.mix(with: .black, by: 0.2))
                .font(.largeTitle)
                .padding()
                .foregroundStyle(.white)
            }
            .padding()
            .multilineTextAlignment(.center)
            .foregroundStyle(.black)
        }
    }

}
    #Preview {
        @Previewable @State var topCurrency: Currency = .silverPenny
        @Previewable @State var bottomCurrency: Currency = .goldPenny
        
        SelectCurrency(topCurrency: $topCurrency, bottomCurrency: $bottomCurrency)
    }
    
