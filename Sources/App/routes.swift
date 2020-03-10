import Vapor


/// Register your application's routes here.
public func routes(_ router: Router) throws {
    //
    router.get { req -> Future<View> in
        return try req.view().render("hello")
    }

    // Opens AboutMe HTML Page
    router.get("aboutMe") { req -> Future<View> in
        let post1 = Post(id: 1, name: "This is a Vapor web app about my portfolio", body: "My name is Patrick and I am a Lambda School student and TL")
        return try req.view().render("aboutMe", ["posts": [post1]])
    }
    
    // Adds a post to the DB
    router.post(Post.self, at: "add") { req, post -> Future<Response> in
        return post.save(on: req).map(to: Response.self) { post in
            return req.redirect(to: "aboutMe")
        }
    } 
    
    
    
}
