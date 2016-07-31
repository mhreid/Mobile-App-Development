//
//  CellState.swift
//  FinalProject
//
//  Created by Micah Reid on 7/29/16.
//  Copyright © 2016 Micah Reid. All rights reserved.
//

import Foundation

enum CellState {
    case Empty
    case Died
    case Born
    case Alive
    
    func isLiving() -> Bool {
        switch self {
        case .Alive, .Born: return true
        case .Died, .Empty: return false
        }
    }
    
    func toggle() -> CellState{
        switch self {
        case .Alive, .Born: return .Empty
        case .Died, .Empty: return .Alive
        }
    }
}