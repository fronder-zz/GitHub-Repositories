//
//  User.swift
//  GitHub Repositories
//
//  Created by Hasan on 7/25/19.
//  Copyright © 2019 Hasan. All rights reserved.
//

import Foundation
import SwiftyJSON

struct User {
    
    var login: String?
    var userId: Int = 0
    var nodeId: String?
    var avatarUrl: String?
    var gravatarUrl: String?
    var url: String?
    var htmlUrl: String?
    var followersUrl: String?
    var followingUrl: String?
    var gistsUrl: String?
    var starredUrl: String?
    var subscriptionsUrl: String?
    var organizationsUrl: String?
    var repposUrl: String?
    var eventsUrl: String?
    var receivedEventsUrl: String?
    var type: String?
    var siteAdmin: Bool = false
    
    init(json: [String: JSON]) {
        if let value = json["login"]?.string {self.login = value}
        if let value = json["id"]?.int {self.userId = value}
        if let value = json["node_id"]?.string {self.nodeId = value}
        if let value = json["avatar_url"]?.string {self.avatarUrl = value}
        if let value = json["gravatar_id"]?.string {self.gravatarUrl = value}
        if let value = json["url"]?.string {self.url = value}
        if let value = json["html_url"]?.string {self.htmlUrl = value}
        if let value = json["followers_url"]?.string {self.followersUrl = value}
        if let value = json["following_url"]?.string {self.followingUrl = value}
        if let value = json["gists_url"]?.string {self.gistsUrl = value}
        if let value = json["starred_url"]?.string {self.starredUrl = value}
        if let value = json["subscriptions_url"]?.string {self.subscriptionsUrl = value}
        if let value = json["organizations_url"]?.string {self.organizationsUrl = value}
        if let value = json["repos_url"]?.string {self.repposUrl = value}
        if let value = json["events_url"]?.string {self.eventsUrl = value}
        if let value = json["received_events_url"]?.string {self.receivedEventsUrl = value}
        if let value = json["type"]?.string {self.type = value}
        if let value = json["site_admin"]?.bool {self.siteAdmin = value}
    }
}
