//
//  ImageDataService.swift
//  Crypto
//
//  Created by T D on 2022/3/5.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService{
    
    @Published var image: UIImage? = nil
    
    let manager = LocalFileManager.instance
    let folderName = "coin_images"
    
    private let coin:CoinModel
    private let imageName:String
    
    var imageSubscription: AnyCancellable?
    
    
    init(coin:CoinModel){
        self.coin = coin
        self.imageName = coin.id
        getCoinImage(imageName: imageName, folderName: folderName)
    }
    
    private func getCoinImage(imageName:String,folderName:String){
        if let savedImage = manager.getImage(imageName: imageName, folderName: folderName){
            image = savedImage
        }
        else{
            downloadImage()
        }
    }
    
    private func downloadImage(){
        guard
            let url = URL(string: coin.image) else {return}
        
        imageSubscription = NetworkManage.download(url: url)
            .tryMap({ (data)->UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkManage.handleCompletion , receiveValue: { [weak self] returnedData in
                guard let self = self, let downloadImage = returnedData else {return}
                self.image = downloadImage
                self.manager.saveImage(image: downloadImage, imageName: self.imageName, folderName: self.folderName)
                self.imageSubscription?.cancel()
                
            })
    }
    
}
