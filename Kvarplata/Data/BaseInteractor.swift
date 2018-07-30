//
//  BaseInteractor.swift
//  Kvarplata
//
//  Created by Александр Смородов on 30.07.2018.
//  Copyright © 2018 Александр Смородов. All rights reserved.
//

import SQLite

class BaseInteractor {
    
    class var table : Table {
        return Table("Table")
    }
    
    static let id = Expression<Int64>("id")
}
