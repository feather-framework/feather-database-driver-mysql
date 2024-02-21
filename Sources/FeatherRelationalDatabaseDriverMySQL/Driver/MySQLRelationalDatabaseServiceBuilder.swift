//
//  SQLDatabaseDriver.swift
//  FeatherComponentTests
//
//  Created by Tibor Bodecs on 18/11/2023.
//

import FeatherComponent
import AsyncKit
import MySQLKit

struct MySQLRelationalDatabaseComponentBuilder: ComponentBuilder {

    let context: MySQLRelationalDatabaseComponentContext
    let pool: EventLoopGroupConnectionPool<MySQLConnectionSource>

    init(context: MySQLRelationalDatabaseComponentContext) {
        self.context = context

        self.pool = EventLoopGroupConnectionPool(
            source: context.connectionSource,
            on: context.eventLoopGroup
        )
    }

    func build(using config: ComponentConfig) throws -> Component {
        MySQLRelationalDatabaseComponent(config: config, pool: pool)
    }

    func shutdown() throws {
        pool.shutdown()
    }
}
