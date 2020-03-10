import Leaf
import Vapor
import Fluent
import FluentSQLite

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    // Register providers first
    try services.register(LeafProvider())

    // Find current Directory
    let directoryConfig = DirectoryConfig.detect()
    services.register(directoryConfig)
      
    // Register FluentSQLite
    try services.register(FluentSQLiteProvider())
    
    // Set up SQLiteDatabase and Create the Database
    var databaseConfig = DatabasesConfig()
    let db = try SQLiteDatabase(storage: .file(path: "\(directoryConfig.workDir)portfolio.db"))
    databaseConfig.add(database: db, as: .sqlite)
    services.register(databaseConfig)
    
    // Handles Migration
    var migrationConfig = MigrationConfig()
    migrationConfig.add(model: Post.self, database: .sqlite)
    services.register(migrationConfig)


    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)
    
    // Use Leaf for rendering views
    config.prefer(LeafRenderer.self, for: ViewRenderer.self)
    
  
    

    // Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)
}
