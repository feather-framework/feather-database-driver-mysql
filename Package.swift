// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "feather-relational-database-driver-mysql",
    platforms: [
        .macOS(.v13),
        .iOS(.v16),
        .tvOS(.v16),
        .watchOS(.v9),
        .visionOS(.v1),
    ],
    products: [
        .library(name: "FeatherRelationalDatabaseDriverMySQL", targets: ["FeatherRelationalDatabaseDriverMySQL"]),
    ],
    dependencies: [
        .package(url: "https://github.com/feather-framework/feather-relational-database", .upToNextMinor(from: "0.3.0")),
        .package(url: "https://github.com/vapor/mysql-kit", from: "4.7.0"),
    ],
    targets: [
        .target(
            name: "FeatherRelationalDatabaseDriverMySQL",
            dependencies: [
                .product(name: "FeatherRelationalDatabase", package: "feather-relational-database"),
                .product(name: "MySQLKit", package: "mysql-kit"),
            ]
        ),
        .testTarget(
            name: "FeatherRelationalDatabaseDriverMySQLTests",
            dependencies: [
                .target(name: "FeatherRelationalDatabaseDriverMySQL"),
            ]
        ),
    ]
)
