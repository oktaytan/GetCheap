<a name="readme-top"></a>

<!-- PROJECT LOGO -->
<div align="center">
  <h1 align="center">GetCheap (with VIPER)</h1>
  <p align="center">The application that lists the discount deals of the games in the stores and is built with the VIPER architecture</p>
</div>

<!-- TABLE OF CONTENTS -->
<summary>Table of Contents</summary>
<ol>
  <li><a href="#about-the-project">About The Project</a></li>
  <li><a href="#screenshots">Screenshots</a></li>
  <li><a href="#built-with">Built With</a></li>
  <li>
    <a href="#getting-started">Getting Started</a>
    <ul>
      <li><a href="#prerequisites">Prerequisites</a></li>
      <li><a href="#installation">Installation</a></li>
    </ul>
  </li>
</ol>
<br />


<!-- ABOUT THE PROJECT -->
## About The Project

When the application is started, firstly, a screen with the list of deals is displayed. In the application, deals data were obtained by using [https://apidocs.cheapshark.com](https://apidocs.cheapshark.com)

When any deal is pressed, the application will navigate to that deal's website. The other screens are the screens where the games, stores are listed and the settings screen. The application is built using the VIPER programming architecture.

Providers have been added to fulfill the responsibilities of TableView and CollectionView structures in the Controller in the application. Each provider performs the TableView or CollectionView operations it is responsible for and notifies the Controller with the help of an event.

Kingfisher library was used for downloading and caching images.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- SCREENSHOTS -->
## Screenshots

<div>
  <img src="main_ss.png" width="200" height="390">  
  <img src="detail_ss.png" width="200" height="390">
  <img src="search_ss.png" width="200" height="390">
</div>
<br />

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- BUILD WITH -->
## Built With

* Swift, UIKit, VIPER
* Kingfisher - Image download and caches

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- GETTING STARTED -->
## Getting Started

In order to run the application, the following steps must be followed.

### Prerequisites

The app's dependencies must be installed with CocoaPods. Therefore, CocoaPods must be installed on your local computer. The current Xcode version is required to run the project.

* CocoaPods installation on terminal
  ```sh
  sudo gem install cocoapods
  ```

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/oktaytan/GetCheap.git
   ```
2. Install Pods packages
   ```sh
   pod install
   ```
3. Run project with Xcode

<p align="right">(<a href="#readme-top">back to top</a>)</p>
