//
//  MetersData.swift
//  Kvarplata
//
//  Created by Александр Смородов on 29.07.2018.
//  Copyright © 2018 Александр Смородов. All rights reserved.
//

import SQLite

class MetersData {
    
    public var month : Int64?
    public var year : Int64?
    
    public var cold_kitchen : Double?
    public var hot_kitchen : Double?
    
    public var cold_bath : Double?
    public var hot_bath : Double?
    
    public var light_1 : Double?
    public var light_2 : Double?
    
    public var creation_date : Int64?
}
