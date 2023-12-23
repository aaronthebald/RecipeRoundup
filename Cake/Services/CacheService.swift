//
//  CacheService.swift
//  Cake
//
//  Created by Aaron Wilson on 12/12/23.
//

import Foundation
import SwiftUI

protocol CacheServiceProtocol {
    var imageCache: NSCache<NSString, NSData> { get set }
    func addImage(imageData: NSData, thumbURL: String)
    func getImage(thumbURL: String) -> NSData?
}

class CacheService: ObservableObject, CacheServiceProtocol {
    
    deinit {
        imageCache.removeAllObjects()
    }
    
    var imageCache: NSCache<NSString, NSData> = {
        let cache = NSCache<NSString, NSData>()
         cache.countLimit = 50
         cache.totalCostLimit = 1024 * 1024 * 100 // 100mb
         return cache
    }()
    
    func addImage(imageData: NSData, thumbURL: String) {
        imageCache.setObject(imageData, forKey: thumbURL as NSString)
    }
    
    func getImage(thumbURL: String) -> NSData? {
        if let data = imageCache.object(forKey: thumbURL as NSString) {
            return data
        }
        return nil
    }
}
