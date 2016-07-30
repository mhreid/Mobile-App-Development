//
//  GridProtocol.swift
//  Assignment4
//
//  Created by Micah Reid on 7/16/16.
//  Copyright © 2016 Micah Reid. All rights reserved.
//

import Foundation



protocol GridProtocol {
    /*init(rows: Int, cols: Int)
    var rows: Int{get}
    var cols: Int{get}

    
    var grid: [[CellState]]{get set}
    func neighbors(coordinates: (Int, Int)) -> [(Int,Int)]
    
    subscript(coordinates: (Int, Int)) -> CellState {get set}*/
    //my version from old code
    associatedtype Cell = (position: Position, state: CellState)
    associatedtype Position = (row:Int, col: Int)

    var rows: Int { get }
    var cols: Int { get }
    var cells: [Cell] { get set}
    
    var living: Int { get }
    var dead:   Int { get }
    var alive:  Int { get }
    var born:   Int { get }
    var died:   Int { get }
    var empty:  Int { get }
    
    subscript (i:Int, j:Int) -> CellState { get set }
    
    func neighbors(pos: Position) -> [Position]
    func livingNeighbors(position: Position) -> Int
    //from project prototype
    
}