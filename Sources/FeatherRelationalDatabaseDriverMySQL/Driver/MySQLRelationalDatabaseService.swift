//
//  File 2.swift
//
//
//  Created by Tibor Bodecs on 03/12/2023.
//

import FeatherService
import FeatherRelationalDatabase
import SQLKit
import MySQLKit
@preconcurrency import AsyncKit

@dynamicMemberLookup
struct MySQLRelationalDatabaseService: RelationalDatabaseService {

    public let config: ServiceConfig
    let pool: EventLoopGroupConnectionPool<MySQLConnectionSource>

    subscript<T>(
        dynamicMember keyPath: KeyPath<MySQLRelationalDatabaseServiceContext, T>
    ) -> T {
        let context = config.context as! MySQLRelationalDatabaseServiceContext
        return context[keyPath: keyPath]
    }

    init(
        config: ServiceConfig,
        pool: EventLoopGroupConnectionPool<MySQLConnectionSource>
    ) {
        self.config = config
        self.pool = pool
    }

    public func connection() async throws -> SQLKit.SQLDatabase {
        pool.database(logger: self.logger).sql()
    }

}
