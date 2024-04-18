//
//  FeatherSQLDatabaseTests.swift
//  FeatherSQLDatabaseTests
//
//  Created by Tibor Bodecs on 2023. 01. 16..
//

import FeatherComponent
import FeatherDatabase
import FeatherDatabaseDriverMySQL
import FeatherDatabaseTesting
import MySQLKit
import NIO
import XCTest

final class FeatherDatabaseDriverMySQLTests: XCTestCase {

    var host: String {
        ProcessInfo.processInfo.environment["MYSQL_HOST"]!
    }

    var user: String {
        ProcessInfo.processInfo.environment["MYSQL_USER"]!
    }

    var pass: String {
        ProcessInfo.processInfo.environment["MYSQL_PASS"]!
    }

    var db: String {
        ProcessInfo.processInfo.environment["MYSQL_DB"]!
    }

    func testExample() async throws {
        let registry = ComponentRegistry()

        let eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        let threadPool = NIOThreadPool(numberOfThreads: 1)
        threadPool.start()

        var config = TLSConfiguration.makeClientConfiguration()
        config.certificateVerification = .none

        let configuration = MySQLConfiguration(
            hostname: host,
            username: user,
            password: pass,
            database: db,
            tlsConfiguration: config
        )
        let connectionSource = MySQLConnectionSource(
            configuration: configuration
        )
        let pool = EventLoopGroupConnectionPool<MySQLConnectionSource>
            .init(
                source: connectionSource,
                on: eventLoopGroup
            )

        try await registry.addDatabase(
            MySQLDatabaseComponentContext(pool: pool)
        )

        let db = try await registry.database()
        let testSuite = DatabaseTestSuite(db)
        try await testSuite.testAll()

        pool.shutdown()
        try await eventLoopGroup.shutdownGracefully()
        try await threadPool.shutdownGracefully()
    }
}
