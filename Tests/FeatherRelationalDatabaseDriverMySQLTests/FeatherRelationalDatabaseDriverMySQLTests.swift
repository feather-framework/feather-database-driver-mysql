//
//  FeatherSQLDatabaseTests.swift
//  FeatherSQLDatabaseTests
//
//  Created by Tibor Bodecs on 2023. 01. 16..
//

import FeatherComponent
import FeatherRelationalDatabase
import FeatherRelationalDatabaseDriverMySQL
import MySQLKit
import NIO
import XCTest

final class FeatherRelationalDatabaseDriverMySQLTests: XCTestCase {

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

        let configuration = MySQLConfiguration(
            hostname: host,
            username: user,
            password: pass,
            database: db,
            // TODO: restore tls?
//            tlsConfiguration: .clientDefault
            tlsConfiguration: .forClient(
                certificateVerification: .none
            )
        )
        let connectionSource = MySQLConnectionSource(
            configuration: configuration
        )
        let pool = EventLoopGroupConnectionPool<MySQLConnectionSource>
            .init(
                source: connectionSource,
                on: eventLoopGroup
            )

        try await registry.addRelationalDatabase(
            MySQLRelationalDatabaseComponentContext(pool: pool)
        )

        let dbComponent = try await registry.relationalDatabase()
        let db = try await dbComponent.connection()

        do {
            struct Galaxy: Codable {
                let id: Int
                let name: String
            }

            try await db
                .create(table: "galaxies")
                .ifNotExists()
                // TODO: figure out how to auto increment
                .column("id", type: .int, .primaryKey(autoIncrement: false))
                .column("name", type: .text)
                .run()

            try await db.delete(from: "galaxies").run()

            try await db
                .insert(into: "galaxies")
                .columns("id", "name")
                .values(SQLBind(1), SQLBind("Milky Way"))
                .values(SQLBind(2), SQLBind("Andromeda"))
                .run()

            let galaxies =
                try await db
                .select()
                .column("*")
                .from("galaxies")
                .all(decoding: Galaxy.self)

            print("------------------------------")
            for galaxy in galaxies {
                print(galaxy.id, galaxy.name)
            }
            print("------------------------------")
        }
        catch {
            throw error
        }

        pool.shutdown()
        try await eventLoopGroup.shutdownGracefully()
        try await threadPool.shutdownGracefully()
    }
}
