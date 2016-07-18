//
//  EngineProtocol.swift
//  Assignment4
//
//  Created by Micah Reid on 7/17/16.
//  Copyright © 2016 Micah Reid. All rights reserved.
//

import Foundation

protocol EngineProtocol {
    
    var delegate : EngineDelegateProtocol {get set}
    var grid :GridProtocol {get set}
    var refreshRate: Double {get set}
    var refreshTimer: NSTimer {get set}
    var rows: Int {get}
    var cols: Int {get}
    
    init(rows:Int, cols:Int, refreshRate: Double)
    //I added the refreshRate parameter so it could access the outlet from the uiview
    
    func step() -> GridProtocol
    
}