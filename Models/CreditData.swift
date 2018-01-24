//
//  CreditData.swift
//  BoozeYourCredit
//
//  Created by Martijn Blauw on 24-01-18.
//  Copyright © 2018 Martijn Blauw. All rights reserved.
//

import Foundation
import Firebase

struct Credit {
    
    let key: String
    let ref: DatabaseReference?
    let credit: Int
    
    init(name: String, credit: Int, key: String = "") {
        self.key = key
        self.ref = nil
        self.credit = credit
    }
    
    init(snapshot: DataSnapshot){
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        ref = snapshot.ref
        credit = snapshotValue["credit"] as! Int
    }
    
    func toAnyObject() -> Any {
        return [
            "credit": credit
        ]
    }
}
