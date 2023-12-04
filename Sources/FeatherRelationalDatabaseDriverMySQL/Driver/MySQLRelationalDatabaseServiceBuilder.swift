//
//  SQLDatabaseDriver.swift
//  FeatherServiceTests
//
//  Created by Tibor Bodecs on 18/11/2023.
//

import FeatherService
import AsyncKit
import MySQLKit

struct MySQLRelationalDatabaseServiceBuilder: ServiceBuilder {

    let context: MySQLRelationalDatabaseServiceContext
    let pool: EventLoopGroupConnectionPool<MySQLConnectionSource>

    init(context: MySQLRelationalDatabaseServiceContext) {
        self.context = context

        self.pool = EventLoopGroupConnectionPool(
            source: context.connectionSource,
            on: context.eventLoopGroup
        )
    }

    func build(using config: ServiceConfig) throws -> Service {
        MySQLRelationalDatabaseService(config: config, pool: pool)
    }

    func shutdown() throws {
        pool.shutdown()
    }
}
