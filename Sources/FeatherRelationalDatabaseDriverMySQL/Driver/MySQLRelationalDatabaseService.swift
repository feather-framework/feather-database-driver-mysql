//
//  File 2.swift
//
//
//  Created by Tibor Bodecs on 03/12/2023.
//

import FeatherComponent
import FeatherRelationalDatabase
import SQLKit
import MySQLKit
@preconcurrency import AsyncKit

@dynamicMemberLookup
struct MySQLRelationalDatabaseComponent: RelationalDatabaseComponent {

    public let config: ComponentConfig
    let pool: EventLoopGroupConnectionPool<MySQLConnectionSource>

    subscript<T>(
        dynamicMember keyPath: KeyPath<MySQLRelationalDatabaseComponentContext, T>
    ) -> T {
        let context = config.context as! MySQLRelationalDatabaseComponentContext
        return context[keyPath: keyPath]
    }

    init(
        config: ComponentConfig,
        pool: EventLoopGroupConnectionPool<MySQLConnectionSource>
    ) {
        self.config = config
        self.pool = pool
    }

    public func connection() async throws -> SQLKit.SQLDatabase {
        pool.database(logger: self.logger).sql()
    }

}
