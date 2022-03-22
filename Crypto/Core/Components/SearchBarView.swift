//
//  SearchBarView.swift
//  Crypto
//
//  Created by T D on 2022/3/8.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    
    var body: some View {
        HStack{
            
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ? Color.theme.secondaryText : Color.theme.accent
                )
                
            TextField("Search by name or symbol", text: $searchText)
                .foregroundColor(Color.theme.accent)
                .disableAutocorrection(true)
                .overlay(
                
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x:10)
                        .foregroundColor(.theme.accent)
                        .onTapGesture {
                            searchText = ""
                            UIApplication.shared.endEditing()
                        }
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                    ,alignment: .trailing
                )
                
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(
                    color: Color.theme.accent.opacity(0.15), radius: 10,x: 0,y: 0
                )
        
        )
        .padding()
        
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            SearchBarView(searchText: .constant(""))
                .preferredColorScheme(.light)
            
            SearchBarView(searchText: .constant(""))
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
        
    }
}
