import Vapor


/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Opens Home HTML Page
    router.get() { req -> Future<View> in
        return Post.query(on: req).all().flatMap(to: View.self) { posts in
            return try req.view().render("home", ["posts": posts])
        }
    }
    
    // Adds a post to the DB
    router.post(Post.self, at: "add") { req, post -> Future<Response> in
        return post.save(on: req).map(to: Response.self) { post in
            return req.redirect(to: "/")
        }
    }
}
