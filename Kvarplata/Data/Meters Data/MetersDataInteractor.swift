//
//  MetersDataInteractor.swift
//  Kvarplata
//
//  Created by Александр Смородов on 29.07.2018.
//  Copyright © 2018 Александр Смородов. All rights reserved.
//

import SQLite

class MetersDataInteractor : BaseInteractor {
    
    override class var table : Table {
        return Table("MetersData")
    }
    
    static let month = Expression<Int64?>("month")
    static let year = Expression<Int64?>("year")
    
    static let cold_kitchen = Expression<Double?>("cold_kitchen")
    static let hot_kitchen = Expression<Double?>("hot_kitchen")
    
    static let cold_bath = Expression<Double?>("cold_bath")
    static let hot_bath = Expression<Double?>("hot_bath")
    
    static let light_1 = Expression<Double?>("light_1")
    static let light_2 = Expression<Double?>("light_2")
    
    static let creation_date = Expression<Int64?>("creation_date")
    
    public static func createTable() throws {
        
        try DbConnection.db?.run(table.create(ifNotExists: true) { t in
            t.column(id, primaryKey: .autoincrement)
            t.column(month)
            t.column(year)
            t.column(cold_kitchen)
            t.column(hot_kitchen)
            t.column(cold_bath)
            t.column(hot_bath)
            t.column(light_1)
            t.column(light_2)
            t.column(creation_date)
        })
    }
    
    static func getAll() -> [MetersData] {
        guard let db = DbConnection.db else {
            return []
        }
        
        do {
            var list : [MetersData] = []
            for row in try db.prepare(table) {
                let item = MetersData()
                item.month = row[month]
                item.year = row[year]
                item.cold_kitchen = row[cold_kitchen]
                item.hot_kitchen = row[hot_kitchen]
                item.cold_bath = row[cold_bath]
                item.hot_bath = row[hot_bath]
                item.light_1 = row[light_1]
                item.light_2 = row[light_2]
                item.creation_date = row[creation_date]
                
                list.append(item)
            }
            return list
        } catch {
            return []
        }
    }
}
