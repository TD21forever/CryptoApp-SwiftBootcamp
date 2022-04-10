//
//  String.swift
//  Crypto
//
//  Created by T D on 2022/4/3.
//

import Foundation

extension String{
    
    var removingHTMLOccurances: String{
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
