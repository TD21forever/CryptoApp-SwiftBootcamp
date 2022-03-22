//
//  PortfolioDataService.swift
//  Crypto
//
//  Created by T D on 2022/3/17.
//

import Foundation
import CoreData
import UIKit

class PortfolioDataService{
    
    var container:NSPersistentContainer
    @Published var savedData:[PortfolioEntity] = []
    
    init(){
        container = NSPersistentContainer(name: "PortfolioData")
        container.loadPersistentStores { (description,error) in
            if let error = error {
                print("Error loading persistent data\(error)")
            }
        }
        fetchData()
    }
    
    func updatePortfolioData(coin:CoinModel,amount:Double){
        // 如果这个coin已经在core data里面了
        if let portfolioEntity = savedData.first(where: {$0.coinID == coin.id}){
            if amount > 0 {
                update(entity: portfolioEntity, amount: amount)
            }
            else{
                delete(entity: portfolioEntity)
            }
        }
        else{
            add(coin: coin, amount: amount)
        }
    }
    
    private func add(coin:CoinModel,amount:Double){
        let newItem = PortfolioEntity(context: container.viewContext)
        newItem.coinID = coin.id
        newItem.amount = amount
        applyChange()
    }
    
    private func update(entity:PortfolioEntity,amount:Double){
        print(amount)
        entity.amount = amount
        applyChange()
    }
    
    private func delete(entity:PortfolioEntity){
        container.viewContext.delete(entity)
        applyChange()
    }
    
    private func save(){
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error Saving To Core Data\(error)")
        }
    }
    
    private func fetchData(){
        let request = NSFetchRequest<PortfolioEntity>(entityName: "PortfolioEntity")
        do {
             savedData =  try container.viewContext.fetch(request)
        } catch let error {
            print("Error Fetching Data \(error)")
        }
    }
    
    private func applyChange(){
        save()
        fetchData()
    }

}
