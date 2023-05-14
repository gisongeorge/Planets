#  Planets 

Sample iOS app for listing the Planets

## Architecture concepts

* This project uses MVVM Architecture considering the testability and re-usability
* Dependency Injection
* Data Binding

## Other concepts

* Application with a single view controller contains a table view which will load the planets names.
* Application consumes the use of planet API (https://swapi.dev/api/planets/) and load the data into the table view
* For HTTP networking, we are using the native class URLSession
* The data is saved in offline by using Core Data
* Minimum OS Version is iOS 15
* Test cases are added for view model and service classes
* PlanetsServiceProtocol is created and injected so that the PlanetsService can be mocked for writing test cases for view model
* PlanetsDBServiceProtocol is created and injected so that the PlanetsDBService can be mocked for writing test cases for view model
* Third party libraries are not used.
* Basic Dark mode support
* Universal Application

## Remarks

It is created only for the purpose of iOS Recruitment Challenge. Only basic concepts are used

## Prerequisites

* Xcode 14.2

## Author

Gisonmon george - gisongeorge@gmail.com

