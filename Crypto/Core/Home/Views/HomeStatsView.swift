//
//  HomeStatsView.swift
//  Crypto
//
//  Created by T D on 2022/3/13.
//

import SwiftUI

struct HomeStatsView: View {
    
    @Binding var showPortfolio:Bool
    
    @EnvironmentObject var vm:HomeViewModel
    
    var body: some View {
       
     
        
        HStack{
            ForEach(vm.stats) { stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width, alignment: showPortfolio ? .trailing : .leading)
        
    }
}

struct HomeStatsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatsView(showPortfolio: .constant(true))
            .environmentObject(dev.vm)
    }
}
