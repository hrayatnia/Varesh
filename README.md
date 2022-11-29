# Weather App (Varesh)


### developed package

* Klarna Core Network (KCNetwork)
* Klarna Design System (KDesignSystem)
* Klarna Weather Service (KWeatherService)
* Klarna Util package for Test (KUtilTest)


third party modules: 

* stinsen
* netshear (it's a open source tool that I used to develop)


minimum requirement:

* iOS 14.0 +/ iPad OS
* xcode 14.1


### Design patterns 

* mainly the Idea behind the whole architecture was to keep everything in its own place with less effort, since I was bounded to two workday limitations, I couldn't clean up at the end.

* for the presentation layer I used MVVMCF, and tried to separate most of the server-side behaviour.

* The reason I picked iOS 14 was to have more challenges such as searchable, list, etc. and at the same time have less memory leak from swiftUI components. but choosing iOS 14.0 the app can support a wide range of users as well.

* for the network layer I used an adapter, builder pattern, etc. to make the package totally reusable and extendable.

* for the test package you can modify the config file through the env variable by using it every section test can be separated easily.


### notes:

* Xcode cloud is enabled
* The push back to the home view controller is not covered intentionally.
* Still there's room for improvement. 


wish list:

* fixing minor bugs such as multiple ID issue in search.
* adding transition to card view
* adding more info to the view
* cleaning view
