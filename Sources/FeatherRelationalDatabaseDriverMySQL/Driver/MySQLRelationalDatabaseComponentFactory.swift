//
//  SQLDatabaseDriver.swift
//  FeatherComponentTests
//
//  Created by Tibor Bodecs on 18/11/2023.
//

import AsyncKit
import FeatherComponent
import MySQLKit

struct MySQLRelationalDatabaseComponentFactory: ComponentFactory {

    let context: MySQLRelationalDatabaseComponentContext

    func build(using config: ComponentConfig) throws -> Component {
        MySQLRelationalDatabaseComponent(config: config)
    }
}
