//
//  Convertable.swift
//  Varesh
//
//  Created by Sam Ray on 2022-11-27.
//

import Foundation

protocol Convertable {
    associatedtype Entity
    func convert() -> Entity
    
    @discardableResult
    static func convert(_ model: Entity) -> Self
}
