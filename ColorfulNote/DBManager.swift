//
//  DBManager.swift
//  ColorfulNote
//
//  Created by TakanoriMatsumoto on 2015/01/28.
//  Copyright (c) 2015年 TakanoriMatsumoto. All rights reserved.
//

import Foundation

class DBManager {
    init() {
        
    }
    func resetText(id: Int) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setValue("", forKey: getKey(id))
    }
    func getText(id: Int) -> String? {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        return userDefaults.valueForKey(getKey(id)) as String?
    }
    func saveText(id: Int, text: String) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setValue(text, forKey: getKey(id))
    }
    private func getKey(id: Int) -> String {
        return "text_\(id)"
    }
}