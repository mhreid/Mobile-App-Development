//
//  GridProtocol.swift
//  Assignment4
//
//  Created by Micah Reid on 7/16/16.
//  Copyright © 2016 Micah Reid. All rights reserved.
//

import Foundation

enum CellState: String {
        case Living = "Living"
        case Born = "Born"
        case Empty = "Empty"
        case Died = "Died"
    
}

protocol GridProtocol {
    init(rows: Int, cols: Int)
    var rows: Int{get}
    var cols: Int{get}

    
    var grid: [[CellState]]{get set}
    func neighbors(coordinates: (Int, Int)) -> [(Int,Int)]
    
    subscript(coordinates: (Int, Int)) -> CellState {get set}
    
}