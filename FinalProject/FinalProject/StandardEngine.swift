//
//  StandardEngine.swift
//  FinalProject
//
//  Created by Micah Reid on 7/29/16.
//  Copyright © 2016 Micah Reid. All rights reserved.
//

import Foundation

class StandardEngine: EngineProtocol{
    typealias Position = (row: Int, col: Int)
    typealias Cell = (position: Position, state: CellState)
    
    private static var _sharedInstance: StandardEngine = StandardEngine(rows: 20, cols: 20)
    static var sharedInstance: StandardEngine { get { return _sharedInstance } }
    
    var mutate: Bool = false
    
    var grid: GridProtocol{
        didSet{
            GridView.gridView.grid = self.grid
        }
    }
    var refreshRate:  Double{
        didSet{
            refreshTimer?.invalidate()
            refreshTimer = NSTimer.scheduledTimerWithTimeInterval(refreshRate, target: self, selector: #selector(stepHelper), userInfo: nil, repeats: on)
        }
    }
    var refreshTimer: NSTimer?
    var rows: Int = 20 {
        didSet {
            grid = Grid(rows: self.rows, cols:  self.cols)
            if let delegate = delegate { delegate.engineDidUpdate(grid) }
        }
    }
    
    var cols: Int = 20 {
        didSet {
            grid = Grid(rows: self.rows, cols: self.cols)
            if let delegate = delegate { delegate.engineDidUpdate(grid) }
        }
    }
    var on: Bool{
        didSet{
            refreshTimer?.invalidate()
            refreshTimer = NSTimer.scheduledTimerWithTimeInterval(refreshRate, target: self, selector: #selector(stepHelper), userInfo: nil, repeats: on)
        }
    }
    
    weak var delegate: EngineDelegate?
    
    required init(rows: Int, cols: Int) {
        self.rows = rows
        self.cols = cols
        refreshRate = 1
        on = false
        self.grid = Grid(rows: rows,cols: cols)
        refreshTimer?.invalidate()
        //refreshTimer = NSTimer.scheduledTimerWithTimeInterval(0, target: self, selector: #selector(stepHelper), userInfo: nil, repeats: false)
    }
    
    @objc func stepHelper(){
        step()
    }
    

    
    func step() -> GridProtocol {
        var newGrid = Grid(rows: rows, cols: cols)
        newGrid.cells = grid.cells.map {
            switch grid.livingNeighbors($0.position) {
            case 2 where $0.state.isLiving(),
            3 where $0.state.isLiving():  return Cell($0.position, .Alive)
            case 3 where !$0.state.isLiving(): return Cell($0.position, .Born)
            case _ where $0.state.isLiving():  return Cell($0.position, .Died)
            default:                           return Cell($0.position, .Empty)
            }
        }
        if mutate {
            if arc4random_uniform(5) == 1{
                print("mutating")
                let y = arc4random_uniform(UInt32(rows))
                let x = arc4random_uniform(UInt32(cols))
                
                newGrid.cells[Int(x) * rows + Int(y)] = ((Int(x), Int(y)) , CellState.Alive)
            }
        }

        grid = newGrid
        if let delegate = delegate{ delegate.engineDidUpdate(grid) }
        return grid
    }
    
}