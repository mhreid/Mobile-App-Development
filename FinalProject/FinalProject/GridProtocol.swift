//
//  GridProtocol.swift
//  FinalProject
//
//  Created by Micah Reid on 7/29/16.
//  Copyright © 2016 Micah Reid. All rights reserved.
//

import Foundation

typealias Position = (row: Int, col: Int)
typealias Cell = (position: Position, state: CellState)

protocol GridProtocol {
    var cells: [Cell] { get set}

    init(rows: Int, cols: Int)
    var rows: Int {get}
    var cols: Int {get}
    var alive:  Int {get}
    func neighbors(pos: Position) -> [Position]
    func livingNeighbors(pos: Position) -> Int
    subscript(i: Int, j: Int) -> CellState {get set}
}