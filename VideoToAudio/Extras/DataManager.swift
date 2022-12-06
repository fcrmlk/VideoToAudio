//
//  DataManager.swift
//  Vocab
//
//  Created by HaiDer's Macbook Pro on 26/12/2021.
//

import Foundation
import UIKit

class DataManager {
    
    static let shared = DataManager()
    
    
    //MARK: - Is User Subscribed?
    
    func setSubscription(value: Bool) {
        UserDefaults.standard.set(value, forKey: "isSubscribe")
    }
    
    func getSubscription() -> Bool? {
        return UserDefaults.standard.bool(forKey: "isSubscribe")
    }
    
    func removeSubscription() {
        UserDefaults.standard.removeObject(forKey: "isSubscribe")
    }


}
