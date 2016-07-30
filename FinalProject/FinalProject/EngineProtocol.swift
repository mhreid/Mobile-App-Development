//
//  EngineProtocol.swift
//  FinalProject
//
//  Created by Micah Reid on 7/29/16.
//  Copyright © 2016 Micah Reid. All rights reserved.
//

import Foundation

protocol EngineProtocol {
    
    weak var delegate: EngineDelegate? { get set }
    var grid: GridProtocol { get }
    var refreshRate:  Double { get set }
    var refreshTimer: NSTimer? { get set }
    var rows: Int { get set }
    var cols: Int { get set }
    init(rows: Int, cols: Int)
    func step() -> GridProtocol

}