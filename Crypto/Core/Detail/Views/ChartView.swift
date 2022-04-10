//
//  ChartView.swift
//  Crypto
//
//  Created by T D on 2022/4/3.
//

import SwiftUI

struct ChartView: View {
    private let prices:[Double]
    
    private let priceMax:Double
    private let priceMin:Double
    private let lineColor:Color
    private let startDate:Date
    private let endDate:Date
    
    @State private var percentage:Double = 0
    
    
    init(coin:CoinModel){
        prices = coin.sparklineIn7D?.price ?? []
        
        priceMax = prices.max() ?? 0
        priceMin = prices.min() ?? 0
        
        let priceChange = priceMax - priceMin
        lineColor = priceChange > 0 ? Color.theme.green : Color.theme.red

        endDate = Date(coinGeckoString: coin.lastUpdated ?? "")
        startDate = endDate.addingTimeInterval(-7*86400)
    }
    var body: some View {
        VStack{
            chartView
                .frame(height:200)
                .background(chartBackground)
                .overlay(
                    chartYAxis.padding(.horizontal)
                    ,alignment: .leading
                )
            
            chartXAxis.padding(.horizontal)
        }
        .font(.caption)
        .foregroundColor(.theme.secondaryText)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                
                withAnimation(.linear(duration: 2.0)) {
                    percentage = 1.0
                }
            }
            
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: dev.coin)
    }
}

extension ChartView{
    var chartBackground : some View{
        VStack{
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    var chartView : some View{
        GeometryReader{ geometry in
            Path{ path in
                for index in prices.indices{
                    let xPosition =  geometry.size.width / CGFloat(prices.count) * CGFloat(index + 1)
                    
                    let yAxis = (priceMax - priceMin)
                    
                    let yPosition = CGFloat(1-(prices[index]-priceMin) / yAxis) * geometry.size.height
                    
                    if index == 0{
                        path.move(to: CGPoint(x:xPosition , y:yPosition ))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                    
                }
                
            }
            .trim(from: 0, to: percentage)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 2.0, lineCap: .round, lineJoin: .round))
            .shadow(color: lineColor.opacity(0.8), radius: 10, x: 0, y: 10)
            .shadow(color: lineColor.opacity(0.5), radius: 10, x: 0, y: 20)
          
        }
    }
    
    var chartYAxis : some View{
        
        VStack{
            Text(priceMax.formattedWithAbbreviations())
            Spacer()
            Text(((priceMax-priceMin) / 2).formattedWithAbbreviations())
            Spacer()
            Text(priceMin.formattedWithAbbreviations())
        }
    }
    var chartXAxis : some View{
        HStack{
            Text(startDate.asShortDateString())
            Spacer()
            Text(endDate.asShortDateString())
        }
    }
}
