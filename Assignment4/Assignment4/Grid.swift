//
//  Grid.swift
//  Assignment4
//
//  Created by Micah Reid on 7/17/16.
//  Copyright © 2016 Micah Reid. All rights reserved.
//

import Foundation

class Grid: GridProtocol{

    
    @IBInspectable var cols: Int
    @IBInspectable var rows: Int
    
    required init(rows: Int, cols: Int) {
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
    }
    
}