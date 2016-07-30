//
//  CellState.swift
//  Assignment4
//
//  Created by Micah Reid on 7/27/16.
//  Copyright © 2016 Micah Reid. All rights reserved.
//

import Foundation

enum CellState: String {
    case Living = "Living"
    case Born = "Born"
    case Empty = "Empty"
    case Died = "Died"
    
    func isLiving() -> Bool {
        switch self {
        case .Living, .Born: return true
        case .Died, .Empty: return false
        }
    }
    
}