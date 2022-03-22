//
//  XmarkView.swift
//  Crypto
//
//  Created by T D on 2022/3/15.
//

import SwiftUI

struct XmarkView: View {
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        
        Button {
            presentationMode.wrappedValue.dismiss()
            print("click")
        } label: {
            
            Image(systemName: "xmark")
                .font(.headline)
        }

 
            
    }
}

struct XmarkView_Previews: PreviewProvider {
    static var previews: some View {
        XmarkView()
    }
}
