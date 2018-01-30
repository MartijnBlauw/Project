//
//  CreditData.swift
//  BoozeYourCredit
//
//  Save amount of credits 
//
//  Created by Martijn Blauw on 24-01-18.
//  Copyright © 2018 Martijn Blauw. All rights reserved.
//

import Foundation
import Firebase

struct Credit {
    
    let ref: DatabaseReference?
    let userid: String
    let credit: Int
    
    init(userid: String, credit: Int) {
        self.ref = nil
        self.userid = userid
        self.credit = credit
    }
    
    init(snapshot: DataSnapshot){
        let snapshotValue = snapshot.value as! [String: AnyObject]
        ref = snapshot.ref
        userid = snapshotValue["userid"] as! String
        credit = snapshotValue["credit"] as! Int
    }
    
    func toAnyObject() -> Any {
        return [
            "userid": userid,
            "credit": credit
        ]
    }
}
