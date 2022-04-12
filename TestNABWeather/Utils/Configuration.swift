//
//  Configuration.swift
//  TestNABWeather
//
//  Created by tungphan on 01/04/2022.
//

import UIKit

class Configuration: NSObject {
    static let shared = Configuration()
    
    var setting: Setting! {
        didSet {
            saveSetting(setting: setting)
        }
    }
    
    override init() {
        super.init()
        if let setting = getSetting() {
            self.setting = setting
        } else {
            setting = Setting(fontSize: 14, countDay: 7, unitTemp: UnitTemp.Celsius.rawValue)
            self.saveSetting(setting: setting)
        }
    }
    
    func saveSetting(setting: Setting) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(setting) {
            UserDefaults.standard.set(encoded, forKey: settingKey)
        }
    }
    
    func getSetting() -> Setting? {
        if let settingData = UserDefaults.standard.object(forKey: settingKey) as? Data {
            let decoder = JSONDecoder()
            guard let loadedSetting = try? decoder.decode(Setting.self, from: settingData) else {
                return nil
            }
            return loadedSetting
        }
        return nil
    }
    
    func saveCity(city: CityEntity?) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(city) {
            UserDefaults.standard.set(encoded, forKey: cityEntityKey)
        }
    }
    
    func getCityEntity() -> CityEntity? {
        if let cityData = UserDefaults.standard.object(forKey: cityEntityKey) as? Data {
            let decoder = JSONDecoder()
            guard let loadedSetting = try? decoder.decode(CityEntity.self, from: cityData) else {
                return nil
            }
            return loadedSetting
        }
        return nil
    }
}
