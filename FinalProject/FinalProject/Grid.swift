//
//  Grid.swift
//  FinalProject
//
//  Created by Micah Reid on 7/29/16.
//  Copyright © 2016 Micah Reid. All rights reserved.
//

import Foundation

struct Grid: GridProtocol{
    
    typealias Position = (row: Int, col: Int)
    typealias Cell = (position: Position, state: CellState)
    
    var rows: Int
    var cols: Int
    var cells: [Cell]
    
    init(rows: Int, cols: Int){
        self.rows = rows
        self.cols = cols
        self.cells = (0..<rows*cols).map {
            let pos = Position($0/cols, $0%cols)
            return Cell(pos, CellState.Empty)
        }

    }
    
    let offsets:[Position] = [
        (-1, -1), (-1, 0), (-1, 1),
        ( 0, -1),          ( 0, 1),
        ( 1, -1), ( 1, 0), ( 1, 1)
    ]
    func neighbors(pos: Position) -> [Position] {
        return offsets.map { Position((pos.row + rows + $0.row) % rows,
            (pos.col + cols + $0.col) % cols) }
    }
    
    subscript (i:Int, j:Int) -> CellState {
        get {
            return cells[i*cols+j].state
        }
        set {
            cells[i*cols+j].state = newValue
        }
    }
    
    func livingNeighbors(pos: Position) -> Int {
        var temp: CellState = StandardEngine.sharedInstance.grid[pos.0, pos.1]
        print(temp)
        return neighbors(pos).reduce(0) {
                StandardEngine.sharedInstance.grid[$1.row,$1.col].isLiving() ? $0 + 1 : $0
        }
    }
    
    
}
