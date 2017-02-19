# Hubchat iOS Task

## Description of the task

Implement a small iOS application that displays a list of Posts of the Photography community, using the Hubchat API. You don’t need any authentication for this task, the data is public. Also, you don’t need to include any functionality or action, just display the data that the API returns. We expect you to show at least:

Forum header (header image, logo, title, description)
List of posts
Post text
User (avatar, username)
Images (from entities)
Upvotes

The API endpoints return a JSON response with the data needed for the task. 

Do not try too much, do not over engineer and keep it simple. We are not interested of fancy animations, cool blurring or other ui candy. We just want to see that you are able to implement an app that meets the minimum requirements. We are also interested to see what kind of code you write and what kind of architectural decisions you make. 

Requirements

You must use at least these techniques/libraries:

Swift 3.0
Alamofire
SnapKit
CocoaPods
A JSON parser of your choice

You must use the MVVM (Model-View-ViewModel) architecture. All UI layouts must be done in code using auto layout constraints (no xibs or storyboards allowed). The deployment target must be iOS 9. The code formatting must follow these guidelines:

https://github.com/raywenderlich/swift-style-guide

Time schedule

You have 72 hours to learn more about all these libraries and the theory and solve the task. After that we’ll have an interview to talk more about the code you’ve written, the architecture of the software and the challenges you’ve found.

After we receive the task we will review it within 24 hours and set a meeting with CTO, if we decide to proceed.

Deliverables

You should deliver a link to the code repository in Github. Remember to make your Git history clean and readable. The project must compile without any changes and must run in both the simulator and an actual device.

API endpoints

Post list: https://api.hubchat.com/v1/forum/photography/post
Forum: https://api.hubchat.com/v1/forum/photography
More info about our API: https://api.hubchat.com/v1/apidocs/api/

Extra bonus

Implement some Unit Tests. Show us your testing skills!
