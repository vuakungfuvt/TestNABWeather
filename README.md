# TestNABWeather
1. Software development princibles: Follow by SOLID (define the protocol to init ViewController followed by MVVM structure)
2. Pattern: Singleton, FactoryPattern.
3. Follow by MVVM.
4. Structure:
    a.Utils: Some common functions.
        +Configuration.swift: including some funtions to save and get local data
        +Constant.swift: Store some constant
    b.Font: Folder of font source
    c.Service: Networking service.
        +RequestBuilder.swift, SessionBuilder.swift: Store some protocol to define the full api resful service.
        +Networkingable: The typealias of request and responsed file
        +When calling 1 api, we will define in Operation folder and implement BaseOperation<GenericModelType>, inside each file we have the method, parameters and the response type.
    d.Screens: ViewController followed by MVVM.
        +When init of 1 viewController, the view has the reponsibiity to setup the view. All of the logic handlecd inside the viewModels class(private attributes), and the view has get the data from the viewModel to show off to the User.
    e.Extensions: Some extensions of classes.
    f.TestNABWeatherTest: The Test of ViewModel
    g.TestNABWeatherUITestsZ: The Test of UI
5. Libraries in Pods:
    -  Kingfisher: Load uiimageview from online
    -  MBProgressHUD: Show progress loading
    -  Alamofire: Load restfull API
    -  ESPullToRefresh: Pull to refresh of UITableView.
    -  IQKeyboardManagerSwift: handle keyboard event
6. Step: Download this project from develop branch and run, to change some config, go to setting screen from setting button in the top of uinavigation bar.
7. To check Error handle, change value from 30 to 0.1 in SessionBuilder file a below:
        config.timeoutIntervalForRequest = 0.1
        config.timeoutIntervalForResource = 0.1
8. Check list done: 1, 2, 3, 4, 5, 6, 7, 8a, 10. 
