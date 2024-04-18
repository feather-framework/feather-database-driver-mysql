// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "feather-database-driver-mysql",
    platforms: [
        .macOS(.v13),
        .iOS(.v16),
        .tvOS(.v16),
        .watchOS(.v9),
        .visionOS(.v1),
    ],
    products: [
        .library(name: "FeatherDatabaseDriverMySQL", targets: ["FeatherDatabaseDriverMySQL"]),
    ],
    dependencies: [
        .package(url: "https://github.com/feather-framework/feather-database", .upToNextMinor(from: "0.4.0")),
        .package(url: "https://github.com/vapor/mysql-kit", from: "4.7.0"),
    ],
    targets: [
        .target(
            name: "FeatherDatabaseDriverMySQL",
            dependencies: [
                .product(name: "FeatherDatabase", package: "feather-database"),
                .product(name: "MySQLKit", package: "mysql-kit"),
            ]
        ),
        .testTarget(
            name: "FeatherDatabaseDriverMySQLTests",
            dependencies: [
                .product(name: "FeatherDatabaseTesting", package: "feather-database"),
                .target(name: "FeatherDatabaseDriverMySQL"),
            ]
        ),
    ]
)
