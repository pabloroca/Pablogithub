# Pablogithub

## How to build / run / test

1. You need to have Carthage installed. There are multiple options for installing Carthage, see https://github.com/Carthage/Carthage#installing-carthage:

2. **Build dependencies**. Open a terminal window in the project folder and execute this command:

```
carthage update --platform iOS
```

3. **Run the app**. Open Pablogithub.xcodeprojworkspace and Command Key + R


4. **Running tests**. Open Pablogithub.xcworkspace, select Scheme Debug or Stubs and Command Key + U


## With more time

- Build a sleeker UI. I mostly concentrate my efforts in Architecture.
- I would cache data and store it locally
- remove KingFisher and make own image cache solution
- Fixes in UI tests
- Revamp network layer removing AlamoFire and using latest iOS enhancements like waitsForConnectivity, multipath and so on.

## About github API

- There is no API call to retrieve the trending repositories in github as per v3 of their API.
- Looks like the trending is done by starts count per day descending (plus some other minor checks)
- I have found an alternative way to retrieve the trending using this https://github.com/huchenme/github-trending-api, but it does not allow to search. It returns the topmost 25 results who i think is enoguh for this exercise
- to retrieve the user avatar I use the github search API for users like https://api.github.com/search/users?q=userlogin%20in:login&amp;per_page=1 limiting the search to one user
- for the authorization / token I have created a github account and I am using the personal access token I got from developer settings
- for retrieving the README I should use the Github API, like detailed here https://developer.github.com/v3/repos/contents/#get-the-readme, problem is that my Network Layer wrapper only works with JSON results and GitHub API results for custom media type application/vnd.github.VERSION.object does not produce reliable Base64 encoded content. So for reading the readme I am using a plain URLSession data task.

## Architecture

- Using Swift 4.2 / XCode 10

- I like to use as few external libraries as possible. They introduce code who is a bit outside our control.

- Anyhow, for network request I will be using Alamofire. Nowadays all network layer can be done withouth Alamofire and using URLSession class, but Alamofire is a long established network layer library and for this exercise I prefer using it.

- No SwiftyJSON or object parser, as data is in simple format, I don´t feel the need to use it. Also in Swift 4 this can be done easily with the Decodable protocol.

- Kingfisher for Image caching.

- In an ideal scenario I would use SSL Pinning, HTTPS is not just enough security, all requests must be SSL pinned, this could be done with the Alamofire feature it has for this.

- Using MVVM architecture with Coordinators (MVVM-C). I know VIPER Architecture too, but fits only in few scenarios, requires many coding and fits in scenarios that requirements does not change often. As for Coordinators I am following sample presentacion that Soroush Khanlou did in NSSpain about Presenting Coordinators.

- Sorry but no ReactiveCocoa. Probably I prefer RXSwift instead. Anyhow I am not a fan of introducing libraries for very core features.

- All data in memory, no local storage. Enabling local storage could be nice for caching information. If requirements asked for local storage I would use Realm encrypted, no CoreData here.

- Tests. I am also a fan of testing, things should be tested. Implemented ViewModel tests.

- UI Color and Fonts. Using Zeplin style.

- UI. UI By code, using Apple AutoLayour. No Storyboards or NIBs

- Code styling. Using SwiftLint (updated to version 0.29.2). I am a firm believer of unified coding styles.

- Dependency manager Carthage. I am familiar with Cocoapods and Carthage, but I prefer Carthage as it does not "pollute" the project files.  

- Warnings as Errors. I treat warnings as errors, an app should not have even any warning.

- Static analizer. I run always static analyzer for detecting any potential issue

- Delayed search with a timer

- for code Quality I would use SonarQube (https://www.sonarqube.org). Who is an amazing platform to inspect source doce quality 

- using inmutable objects as much as possible

- Icons from Official GitHub Icons https://octicons.github.com

- as per rendering the README, I would like to use  https://github.com/M2Mobi/Marky-Mark but has a problem with Carthage integration, so I decided to use https://github.com/keitaoouchi/MarkdownView. Anyhow this lib is producing some issues when rendering certains images, I think is a bug in the library as per https://github.com/keitaoouchi/MarkdownView/issues/32 (probably a CORS issue)

- Different targets (Debug / Stubs / Release) with tests for each case

## Network Layer

- Networking. I will be using my wrapper on top of Alamofire. I already have it done for Swift 4 at https://github.com/pabloroca/PR2StudioSwift. Installed automatically via a Carthage dependency

- EndPoints encrypted with AES128, using my utility obfuscateapi, located at https://github.com/pabloroca/obfuscateapi, files APIConstants.swift and AESKeyClass.swift

- Networking. If needed a second request, I would use Concurrent (with DispatchGroup) as it should perform better or serial using NSOperation dependencies

- Network requests recursively repeated if temporary error (increasing delay till 30 second)

- Network requests applied Apple recommendations (make always the request, don´t timeout, ...)

- Network Log network requests/responses to console with different logs levels

- Networking. automatic cache by Alamofire is disabled for security reasons.


## Data Model

All data model is held in memory, I think it´s pointless to store it locally. If I needed to store it locally I would use an encrypted Realm data store, with that we can avoid reverse engineering of the results. 


## Sorting the project file

Using the pbxproj-sort.pl script included in the Scripts directly to sort the project file with keep the project in order as well as help demystify merge conflicts in the project file. 

To run the sorting script, use:

`./Scripts/pbxproj-sort.pl Pablogithub.xcodeproj/project.pbxproj`
