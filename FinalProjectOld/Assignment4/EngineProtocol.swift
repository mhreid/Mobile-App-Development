//
//  EngineProtocol.swift
//  Assignment4
//
//  Created by Micah Reid on 7/17/16.
//  Copyright © 2016 Micah Reid. All rights reserved.
//

import Foundation

protocol EngineProtocol {
    
    /*var delegate : EngineDelegate {get set}
    var grid :GridProtocol {get set}
    var refreshRate: Double {get set}
    var refreshTimer: NSTimer {get set}
    var rows: Int {get}
    var cols: Int {get}
    
    init(rows:Int, cols:Int, refreshRate: Double, grid: GridProtocol)
    
    func step() -> GridProtocol*/
    //my version from old code
    
    var rows: Int { get set }
    var cols: Int { get set }
    var grid: Grid { get }
    var delegate: EngineDelegate? { get set }
    
    var refreshRate:  Double { get set }
    var refreshTimer: NSTimer? { get set }
    
    func step() -> Grid
    //new version from sample code
    
}