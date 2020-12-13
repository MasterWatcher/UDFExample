//
//  Actions.swift
//  AppModel
//
//  Created by Anton Goncharov on 06.12.2020.
//

import Foundation
import UDF

public enum Actions: Action {
    case nameDidChange(String?)
    case pincodeDidChange(String?)
    case dogNameDidChange(String?)
}
