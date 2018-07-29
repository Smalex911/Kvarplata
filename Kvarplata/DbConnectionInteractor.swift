//
//  DbConnectionInteractor.swift
//  Kvarplata
//
//  Created by Александр Смородов on 29.07.2018.
//  Copyright © 2018 Александр Смородов. All rights reserved.
//

import SQLite
import Foundation

class DbConnectionInteractor {
    
    public static var shared = DbConnectionInteractor()
    
    var db : Connection? = nil
    
    init() {
        let path = NSSearchPathForDirectoriesInDomains(
            .applicationSupportDirectory, .userDomainMask, true
            ).first! + "/Offline Data"
        
        do {
            try FileManager.default.createDirectory(
                atPath: path, withIntermediateDirectories: true, attributes: nil
            )
            
            db = try Connection("\(path)/db.sqlite")
            NSLog("DB PATH: \(path)/db.sqlite")
            
            try MetersDataInteractor.createTable(db: db)
        }
        catch let error as NSError {
            NSLog("\(error)")
        }
    }
}
