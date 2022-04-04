# TestNABWeather
1. Software development princibles: Follow by SOLID.
2. Pattern: Singleton, FactoryPattern.
3. Follow by MVVM.
4. Structure:
    a.Utils: Some common functions.
    b.Font: Folder of font source.
    c.Service: Networking service.
    d.Screens: ViewController followed by MVVM.
    e.Extensions: Some extensions of classes.
5. Libraries in Pods:
    -  Kingfisher: Load uiimageview from online
    -  MBProgressHUD: Show progress loading
    -  Alamofire: Load restfull API
    -  ESPullToRefresh: Pull to refresh of UITableView.
6. Step: Download this project from develop branch and run, to change some config, go to setting screen from setting button in the top of uinavigation bar.
7. To check Error handle, change value from 30 to 0.1 in SessionBuilder file a below:
        config.timeoutIntervalForRequest = 0.1
        config.timeoutIntervalForResource = 0.1
8. Check list done: 1, 2, 3, 4, 5, 6, 7, 8a, 10. 
