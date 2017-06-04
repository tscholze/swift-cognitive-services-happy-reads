## What's this?
This is a simple use case and play-around app to use the [Microsoft Cogntive Service](https://www.microsoft.com/cognitive-services/en-us/apis) Text Analytics API. It parses the English version of the [Deutsche Welle](http://www.dw.com/en/top-stories/s-9097) news and calculates the individual happiness of each article.

## Features
1. It compiles
1. It will split the news into *happy* and *unhappy* ones

## How to run
1. Create a (free) [Microsoft Cognitive Services account](https://www.microsoft.com/cognitive-services/en-us/sign-up)
1. Create a trail [Text Analytics API](https://www.microsoft.com/cognitive-services/en-us/text-analytics-api) key
1. Copy and paste the Text Analytics API service key to the `ApiKey` property in the `CognitiveService.swift` file
1. Run `pod install` to install external dependencies
1. Run the project

## How it looks

<a href="https://raw.githubusercontent.com/tscholze/swift-cognitive-services-happy-reads/develop/docs/loading-scene.png">
<img src="https://raw.githubusercontent.com/tscholze/swift-cognitive-services-happy-reads/develop/docs/loading-scene.png" height="300px" /></a>

<a href="https://github.com/tscholze/swift-cognitive-services-happy-reads/blob/develop/docs/happy-scene.png?raw=true">
<img src="https://github.com/tscholze/swift-cognitive-services-happy-reads/blob/develop/docs/happy-scene.png?raw=true" height="300px" /></a>
    
<a href="https://github.com/tscholze/swift-cognitive-services-happy-reads/blob/develop/docs/unhappy-scene.png?raw=true">
<img src="https://github.com/tscholze/swift-cognitive-services-happy-reads/blob/develop/docs/unhappy-scene.png?raw=true" height="300px" /></a>

<a href="https://github.com/tscholze/swift-cognitive-services-happy-reads/blob/develop/docs/info-scene.png?raw=true">
<img src="https://github.com/tscholze/swift-cognitive-services-happy-reads/blob/develop/docs/info-scene.png?raw=true" height="300px" /></a>


## Thanks to
* [@codeprincess](https://twitter.com/codePrincess) for creating awesome tutorials about the Cogntive Services and motivating me to play around with it
* [@trikkser](https://twitter.com/trikkser) for posting great tweets with links and backgroud information about this topic
* [GDJ](https://openclipart.org/user-cliparts/GDJ) for the icons

## License 
Quotes is licensed under [MIT](https://en.wikipedia.org/wiki/MIT_License) License. Icon and external dependencies may differ. 

## Others
PS: If you find any API key in the repository's git history, the key will not work.
