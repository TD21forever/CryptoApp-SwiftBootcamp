//
//  StatisticModel.swift
//  Crypto
//
//  Created by T D on 2022/3/12.
//

import Foundation


struct StatisticModel:Identifiable {
    
    var id: String = UUID().uuidString
    var title: String
    var value: String
    var percentageChange: Double?
    
    init(title: String,value: String,percentageChange: Double? = nil){
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
    
}



