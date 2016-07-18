//
//  StandardEngine.swift
//  Assignment4
//
//  Created by Micah Reid on 7/17/16.
//  Copyright © 2016 Micah Reid. All rights reserved.
//

import Foundation
import UIKit

class StandardEngine: EngineProtocol{
    var delegate: EngineDelegateProtocol
    var grid: GridProtocol
    var refreshRate: Double
    var refreshTimer: NSTimer
    var rows: Int
    var cols: Int

    
    required init(rows: Int, cols: Int, refreshRate: Double, grid: Grid) {
        self.rows = rows
        self.cols = cols
        self.refreshRate = refreshRate
        self.delegate = SimulationViewController()
        var refreshTimer:NSTimer?
        var refreshInterval: NSTimeInterval = NSTimeInterval(refreshRate)/*{
            didSet {
                if refreshInterval != 0 {
                    if let refreshTimer = refreshTimer { refreshTimer.invalidate() }
                    let sel = #selector(Example.timerDidFire(_:))
                    refreshTimer = NSTimer.scheduledTimerWithTimeInterval(refreshInterval,
                                                               target: self,
                                                               selector: sel,
                                                               userInfo: ["name": "fred"],
                                                               repeats: true)
            }
            else if let refreshTimer = refreshTimer {
                refreshTimer.invalidate()
                self.refreshTimer = nil
            }
            }*/
            self.grid = grid
        }
    }
    
    


    

func step() -> GridProtocol {
        var cellLocal = grid
        var cellFinal = grid
        for x in 0...grid.rows - 1{
            for y in 0...grid.cols - 1{
                var neighborCount = 0
                var neighborCoordinates: [(Int, Int)] = Grid(rows: grid.rows, cols: grid.cols,chart: cellLocal.grid).neighbors(x,y)
                for q in 0...8{
                    switch cellLocal[neighborCoordinates[q]]{
                    case CellState.Living, CellState.Born:
                        neighborCount += 1
                    default:
                        break
                    }
                    
                }
                
                if cellLocal[x, y] == .Living || cellLocal[x, y] == .Born{
                    neighborCount -= 1
                }
                if cellLocal[x,y] == .Living || cellLocal[x, y] == .Born {
                    if neighborCount < 2 || neighborCount > 3 {
                        cellFinal [x, y] = .Died
                    } else {
                        cellFinal[x, y] = .Living
                    }
                    
                } else {
                    if neighborCount == 3 {
                        cellFinal [x, y] = .Born
                    } else {
                        cellFinal[x, y] = .Empty
                    }
                }
            }
        }
        
        
        return cellFinal

    }
    
    /*@objc func timerDidFire(timer:NSTimer) {
        //self.rows += 1
        Grid(rows: rows, cols: cols, chart: step().grid)
        let center = NSNotificationCenter.defaultCenter()
        let n = NSNotification(name: "ExampleNotification",
                               object: nil,
                               userInfo: ["name": "fred"])
        center.postNotification(n)
        print ("\(timer.userInfo?["name"] ?? "not fred")")
    }
 */

    
