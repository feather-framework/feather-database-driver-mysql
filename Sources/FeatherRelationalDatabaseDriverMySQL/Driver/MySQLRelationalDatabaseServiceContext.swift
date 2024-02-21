//
//  SQLDatabaseContext.swift
//  FeatherComponentTests
//
//  Created by Tibor Bodecs on 18/11/2023.
//

import FeatherComponent
@preconcurrency import MySQLKit

public struct MySQLRelationalDatabaseComponentContext: ComponentContext {

    let eventLoopGroup: EventLoopGroup
    let connectionSource: MySQLConnectionSource

    public init(
        eventLoopGroup: EventLoopGroup,
        connectionSource: MySQLConnectionSource
    ) {
        self.eventLoopGroup = eventLoopGroup
        self.connectionSource = connectionSource
    }

    public func make() throws -> ComponentBuilder {
        MySQLRelationalDatabaseComponentBuilder(context: self)
    }
}
