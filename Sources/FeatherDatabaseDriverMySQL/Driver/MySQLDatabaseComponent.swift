//
//  File 2.swift
//
//
//  Created by Tibor Bodecs on 03/12/2023.
//

import AsyncKit
import FeatherComponent
import FeatherDatabase
import MySQLKit
import SQLKit

@dynamicMemberLookup
struct MySQLDatabaseComponent: DatabaseComponent {

    public let config: ComponentConfig

    subscript<T>(
        dynamicMember keyPath: KeyPath<
            MySQLDatabaseComponentContext, T
        >
    ) -> T {
        let context = config.context as! MySQLDatabaseComponentContext
        return context[keyPath: keyPath]
    }

    public func connection() async throws -> Database {
        .init(self.pool.database(logger: self.logger).sql())
    }
}
