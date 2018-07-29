//
//  MetersDataInteractor.swift
//  Kvarplata
//
//  Created by Александр Смородов on 29.07.2018.
//  Copyright © 2018 Александр Смородов. All rights reserved.
//

import SQLite

class MetersDataInteractor {
    
    static func createTable(db: Connection?) throws {
        let users = Table("MetersData")
        
        try db?.run(users.create(ifNotExists: true) { t in
            t.column(Expression<Int64>("id"), primaryKey: .autoincrement)
            
            t.column(Expression<Int64?>("month"))
            t.column(Expression<Int64?>("year"))
            
            t.column(Expression<Int64?>("cold_kitchen"))
            t.column(Expression<Int64?>("hot_kitchen"))
            
            t.column(Expression<Double?>("cold_bath"))
            t.column(Expression<Double?>("hot_bath"))
            
            t.column(Expression<Int64?>("light_1"))
            t.column(Expression<Int64?>("light_2"))
        })
    }
}
