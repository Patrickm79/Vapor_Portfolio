//
//  Post.swift
//  App
//
//  Created by Patrick Millet on 3/9/20.
//
import FluentSQLite
import Foundation
import Vapor

struct Post: Content, SQLiteModel, Migration, Equatable, Hashable {
    var id: Int?
    var name: String
    var body: String
}
