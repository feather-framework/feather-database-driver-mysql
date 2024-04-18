//
//  SQLDatabaseDriver.swift
//  FeatherComponentTests
//
//  Created by Tibor Bodecs on 18/11/2023.
//

import AsyncKit
import FeatherComponent
import MySQLKit

struct MySQLDatabaseComponentFactory: ComponentFactory {

    let context: MySQLDatabaseComponentContext

    func build(using config: ComponentConfig) throws -> Component {
        MySQLDatabaseComponent(config: config)
    }
}
