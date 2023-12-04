//
//  SQLDatabaseContext.swift
//  FeatherServiceTests
//
//  Created by Tibor Bodecs on 18/11/2023.
//

import FeatherService
@preconcurrency import MySQLKit

public struct MySQLRelationalDatabaseServiceContext: ServiceContext {

    let eventLoopGroup: EventLoopGroup
    let connectionSource: MySQLConnectionSource

    public init(
        eventLoopGroup: EventLoopGroup,
        connectionSource: MySQLConnectionSource
    ) {
        self.eventLoopGroup = eventLoopGroup
        self.connectionSource = connectionSource
    }

    public func make() throws -> ServiceBuilder {
        MySQLRelationalDatabaseServiceBuilder(context: self)
    }
}
