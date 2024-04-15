//
//  File 2.swift
//
//
//  Created by Tibor Bodecs on 03/12/2023.
//

import AsyncKit
import FeatherComponent
import FeatherRelationalDatabase
import MySQLKit
import SQLKit

@dynamicMemberLookup
struct MySQLRelationalDatabaseComponent: RelationalDatabaseComponent {

    public let config: ComponentConfig

    subscript<T>(
        dynamicMember keyPath: KeyPath<
            MySQLRelationalDatabaseComponentContext, T
        >
    ) -> T {
        let context = config.context as! MySQLRelationalDatabaseComponentContext
        return context[keyPath: keyPath]
    }

    public func connection() async throws -> SQLKit.SQLDatabase {
        self.pool.database(logger: self.logger).sql()
    }
}
