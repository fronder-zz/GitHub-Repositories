//
//  Repository.swift
//  GitHub Repositories
//
//  Created by Hasan on 7/25/19.
//  Copyright © 2019 Hasan. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Repository {
    
    var user: User!
    var repoId: Int = 0
    var nodeId: String?
    var name: String?
    var fullName: String?
    var privatre: Bool = false
    var htmlUrl: String?
    var description: String?
    var fork: Bool = false
    var url: String?
    var forksUrl: String?
    var keysUrl: String?
    var collaborationsUrl: String?
    var teamsUrl: String?
    var hooksUrl: String?
    var issueEventsUrl: String?
    var eventsUrl: String?
    var assigneesUrl: String?
    var branchesUrl: String?
    var tagsUrl: String?
    var blobsUrl: String?
    var gitTagsUrl: String?
    var gitRefsUrl: String?
    var treesUrl: String?
    var statusesUrl: String?
    var languagesUrl: String?
    var stargazersUrl: String?
    var contributorsUrl: String?
    var subscribersUrl: String?
    var subscriptionsUrl: String?
    var commitsUrl: String?
    var gitCommitsUrl: String?
    var commentsUrl: String?
    var issueCommentsUrl: String?
    var contentsUrl: String?
    var compareUrl: String?
    var mergesUrl: String?
    var archiveUrl: String?
    var downloadsUrl: String?
    var issuesUrl: String?
    var pullsUrl: String?
    var milestonesUrl: String?
    var notificationsUrl: String?
    var labelsUrl: String?
    var releasesUrl: String?
    var deploymentsUrl: String?
    var createdAt: String?
    var updatedAt: String?
    var pushedAt: String?
    var gitUrl: String?
    var sshUrl: String?
    var cloneUrl: String?
    var svnUrl: String?
    var homepage: String?
    var size: Int = 0
    var stargazersCount: Int = 0
    var watchersCount: Int = 0
    var language: String?
    var hasIssues: Bool = false
    var hasProjects: Bool = false
    var hasDownloads: Bool = false
    var hasWiki: Bool = false
    var hasPages: Bool = false
    var forksCount: Int = 0
    var mirrorUrl: String?
    var archived: Bool = false
    var disabled: Bool = false
    var openIssuesCount: Int = 0
    var forks: Int = 0
    var openIssues: Int = 0
    var watchers: Int = 0
    var defaultBranch: String?
    var score: Int = 0
    
    init(json: JSON) {
        
        if let value = json["owner"].dictionary {
            self.user = User(json: value)
        }
        if let value = json["id"].int {self.repoId = value}
        if let value = json["node_id"].string {self.nodeId = value}
        if let value = json["name"].string {self.name = value}
        if let value = json["full_name"].string {self.fullName = value}
        if let value = json["private"].bool {self.privatre = value}
        if let value = json["html_url"].string {self.htmlUrl = value}
        if let value = json["description"].string {self.description = value}
        if let value = json["fork"].bool {self.fork = value}
        if let value = json["url"].string {self.url = value}
        if let value = json["forks_url"].string {self.forksUrl = value}
        if let value = json["keys_url"].string {self.keysUrl = value}
        if let value = json["collaborators_url"].string {self.collaborationsUrl = value}
        if let value = json["teams_url"].string {self.teamsUrl = value}
        if let value = json["hooks_url"].string {self.hooksUrl = value}
        if let value = json["issue_events_url"].string {self.issueEventsUrl = value}
        if let value = json["assignees_url"].string {self.assigneesUrl = value}
        if let value = json["events_url"].string {self.eventsUrl = value}
        if let value = json["branches_url"].string {self.branchesUrl = value}
        if let value = json["tags_url"].string {self.tagsUrl = value}
        if let value = json["blobs_url"].string {self.blobsUrl = value}
        if let value = json["git_tags_url"].string {self.gitTagsUrl = value}
        if let value = json["git_refs_url"].string {self.gitRefsUrl = value}
        if let value = json["trees_url"].string {self.treesUrl = value}
        if let value = json["statuses_url"].string {self.statusesUrl = value}
        if let value = json["languages_url"].string {self.languagesUrl = value}
        if let value = json["stargazers_url"].string {self.stargazersUrl = value}
        if let value = json["contributors_url"].string {self.contributorsUrl = value}
        if let value = json["subscribers_url"].string {self.subscribersUrl = value}
        if let value = json["subscription_url"].string {self.subscriptionsUrl = value}
        if let value = json["commits_url"].string {self.commitsUrl = value}
        if let value = json["git_commits_url"].string {self.gitCommitsUrl = value}
        if let value = json["comments_url"].string {self.commentsUrl = value}
        if let value = json["issue_comment_url"].string {self.issueCommentsUrl = value}
        if let value = json["contents_url"].string {self.contentsUrl = value}
        if let value = json["compare_url"].string {self.compareUrl = value}
        if let value = json["merges_url"].string {self.mergesUrl = value}
        if let value = json["archive_url"].string {self.archiveUrl = value}
        if let value = json["downloads_url"].string {self.downloadsUrl = value}
        if let value = json["issues_url"].string {self.issuesUrl = value}
        if let value = json["pulls_url"].string {self.pullsUrl = value}
        if let value = json["milestones_url"].string {self.milestonesUrl = value}
        if let value = json["notifications_url"].string {self.notificationsUrl = value}
        if let value = json["labels_url"].string {self.labelsUrl = value}
        if let value = json["releases_url"].string {self.releasesUrl = value}
        if let value = json["deployments_url"].string {self.deploymentsUrl = value}
        if let value = json["created_at"].string {self.createdAt = value}
        if let value = json["updated_at"].string {self.updatedAt = value}
        if let value = json["pushed_at"].string {self.pushedAt = value}
        if let value = json["git_url"].string {self.gitUrl = value}
        if let value = json["ssh_url"].string {self.sshUrl = value}
        if let value = json["clone_url"].string {self.cloneUrl = value}
        if let value = json["svn_url"].string {self.svnUrl = value}
        if let value = json["homepage"].string {self.homepage = value}
        if let value = json["size"].int {self.size = value}
        if let value = json["stargazers_count"].int {self.stargazersCount = value}
        if let value = json["watchers_count"].int {self.watchersCount = value}
        if let value = json["language"].string {self.language = value}
        if let value = json["has_issues"].bool {self.hasIssues = value}
        if let value = json["has_projects"].bool {self.hasProjects = value}
        if let value = json["has_downloads"].bool {self.hasDownloads = value}
        if let value = json["has_wiki"].bool {self.hasWiki = value}
        if let value = json["has_pages"].bool {self.hasPages = value}
        if let value = json["forks_count"].int {self.forksCount = value}
        if let value = json["mirror_url"].string {self.mirrorUrl = value}
        if let value = json["archived"].bool {self.archived = value}
        if let value = json["disabled"].bool {self.disabled = value}
        if let value = json["open_issues_count"].int {self.openIssuesCount = value}
        if let value = json["forks"].int {self.forks = value}
        if let value = json["open_issues"].int {self.openIssues = value}
        if let value = json["watchers"].int {self.watchers = value}
        if let value = json["default_branch"].string {self.defaultBranch = value}
        if let value = json["score"].int {self.score = value}
    }
}
