//
//  LocalFileManager.swift
//  Crypto
//
//  Created by T D on 2022/3/8.
//

import Foundation
import UIKit


class LocalFileManager{
    
    static let instance = LocalFileManager()
    
    private init(){
        
    }
    
    func saveImage(image:UIImage,imageName:String,folderName:String){
        
        createFolderIfNeed(folderName: folderName)
        
        guard
            let imageData = image.pngData(),
            let url = getURLForImage(imageName: imageName, folderName: folderName)
                
        else{
            return
        }
        
        do {
            try imageData.write(to: url)
        } catch let error {
            
            print("Error Writing Image \(error)")
        }

    }
    
    // 先获得图片的路径,再返回UIImage
    func getImage(imageName:String,folderName:String)->UIImage?{
        
        guard
            let url = getURLForImage(imageName: imageName, folderName: folderName)
        else{
            return nil
        }
        
        return UIImage(contentsOfFile: url.path)
        
    }
    
    private func createFolderIfNeed(folderName:String){
        guard let folderUrl = getURLForFolder(folderName: folderName) else { return }
        
        if !FileManager.default.fileExists(atPath: folderUrl.path){
            do {
                try FileManager.default.createDirectory(at: folderUrl, withIntermediateDirectories: true, attributes: nil)

            } catch let error {
                print("Error Creating Directory \(error)")
            }
        }
    }
    
    private func getURLForFolder(folderName:String)->URL?{
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        return url.appendingPathComponent(folderName)
    }
    
    private func getURLForImage(imageName:String,folderName:String)->URL?{
        guard let url = getURLForFolder(folderName: folderName) else {
            return nil }
        return url.appendingPathComponent(imageName)
    }
    
    
    
    
}
