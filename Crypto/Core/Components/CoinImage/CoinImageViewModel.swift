//
//  CoinImageViewModel.swift
//  Crypto
//
//  Created by T D on 2022/3/5.
//

import SwiftUI
import Foundation
import Combine
class CoinImageViewModel:ObservableObject{
    
    @Published var isLoading:Bool = false
    
    @Published var image:UIImage? = nil
    
    private let coin:CoinModel
    private let dataService:CoinImageService
    private var cancellables = Set<AnyCancellable>()
    
    
    init(coin:CoinModel){
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        self.isLoading = true
        self.addSubscribers()
    }
    
    func addSubscribers(){
        dataService.$image
            .sink { [weak self]_ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
            }
            .store(in: &cancellables)
            
    }
    

}
