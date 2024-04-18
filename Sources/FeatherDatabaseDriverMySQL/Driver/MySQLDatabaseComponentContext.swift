//
//  SQLDatabaseContext.swift
//  FeatherComponentTests
//
//  Created by Tibor Bodecs on 18/11/2023.
//

import FeatherComponent
@preconcurrency import MySQLKit

public struct MySQLDatabaseComponentContext: ComponentContext {

    let pool: EventLoopGroupConnectionPool<MySQLConnectionSource>

    public init(
        pool: EventLoopGroupConnectionPool<MySQLConnectionSource>
    ) {
        self.pool = pool
    }

    public func make() throws -> ComponentFactory {
        MySQLDatabaseComponentFactory(context: self)
    }
}
