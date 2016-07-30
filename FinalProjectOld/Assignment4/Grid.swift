//
//  Grid.swift
//  Assignment4
//
//  Created by Micah Reid on 7/17/16.
//  Copyright © 2016 Micah Reid. All rights reserved.
//

import Foundation

struct Grid: GridProtocol{

    
    /* cols: Int
    var rows: Int
    
    init(rows: Int, cols: Int) {
        self.rows = rows
        self.cols = cols
        self.grid = [[CellState]] (count: rows, repeatedValue: Array(count: cols, repeatedValue: .Empty))
    }
    //this other init is so that it doesnt get reset to 0 all the time
    init(rows: Int, cols: Int, chart: [[CellState]]){

            self.grid = chart
            self.rows = rows
            self.cols = cols

    }
    
    var grid: [[CellState]]
    
    func neighbors(coordinates: (Int,Int)) -> ([(Int, Int)]){
        var neighborCoordinates = [(Int,Int)]()
        for x in (-1)...1 {
            for y in (-1)...1 {
                var tempCoordinates = (coordinates.0 + x, coordinates.1 + y)
                tempCoordinates.0 = tempCoordinates.0 % rows
                tempCoordinates.1 = tempCoordinates.1 % cols
                if tempCoordinates.0 < 0{
                    tempCoordinates.0 = rows + tempCoordinates.0
                }
                if tempCoordinates.1 < 0{
                    tempCoordinates.1 = cols + tempCoordinates.1
                }
                
                neighborCoordinates += [tempCoordinates]
            }
        }
        return neighborCoordinates
    }
    
    subscript(coordinates: (Int, Int)) -> CellState{
        get{
            return grid[coordinates.0][coordinates.1]
        }
        set(state){
            grid[coordinates.0][coordinates.1] = state
        }
    }*/
    //my old code
    
    typealias Position = (row:Int, col: Int)
    typealias Cell = (position: Position, state: CellState)
    typealias CellInitializer = (Position) -> CellState

    private(set) var rows: Int
    private(set) var cols: Int
    var cells: [Cell]
    
    let minDimension: Int = 15
    let maxDimension: Int = 40
    //these are the minimum and maximum numbers of rows and columns, only changable within the program
    
    var living: Int { return cells.reduce(0) { return  $1.state.isLiving() ?  $0 + 1 : $0 } }
    var dead:   Int { return cells.reduce(0) { return !$1.state.isLiving() ?  $0 + 1 : $0 } }
    var alive:  Int { return cells.reduce(0) { return  $1.state == .Living  ?  $0 + 1 : $0 } }
    var born:   Int { return cells.reduce(0) { return  $1.state == .Born   ?  $0 + 1 : $0 } }
    var died:   Int { return cells.reduce(0) { return  $1.state == .Died   ?  $0 + 1 : $0 } }
    var empty:  Int { return cells.reduce(0) { return  $1.state == .Empty  ?  $0 + 1 : $0 } }
    //figure out what these lines of code mean
    
    init (_ rows: Int, _ cols: Int, cellInitializer: CellInitializer = {_ in .Empty }) {
        self.rows = rows
        self.cols = cols
        self.cells = (0..<rows*cols).map {
            let pos = Position($0/cols, $0%cols)
            return Cell(pos, cellInitializer(pos))
        }
    }
    
    subscript (i:Int, j:Int) -> CellState {
        get {
            return cells[i*cols+j].state
        }
        set {
            cells[i*cols+j].state = newValue
        }
    }
    
    private static let offsets:[Position] = [
        (-1, -1), (-1, 0), (-1, 1),
        ( 0, -1),          ( 0, 1),
        ( 1, -1), ( 1, 0), ( 1, 1)
    ]
    func neighbors(pos: Position) -> [Position] {
        return Grid.offsets.map { Position((pos.row + rows + $0.row) % rows,
            (pos.col + cols + $0.col) % cols) }
    }
    
    func livingNeighbors(position: Position) -> Int {
        return neighbors(position)
            .reduce(0) {
                self[$1.row,$1.col].isLiving() ? $0 + 1 : $0
        }
    }
    //new code from sample
    
}