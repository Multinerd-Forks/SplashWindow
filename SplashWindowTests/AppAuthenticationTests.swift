//
//  AppAuthenticationTests.swift
//  SplashWindow
//
//  Created by Hoa Zheng on 5/4/17.
//  Copyright © 2017 Hao Zheng. All rights reserved.
//

import XCTest
@testable import SplashWindow

class AppAuthenticationTests: XCTestCase {
    
    func testAppAuth() {
        let appAuth = FakeAppAuthentication()
        let storage = appAuth.fakeStorage
        
        //get TouchID - touchIDObjectInStorage: Bool?
        for (touchIDEnabledOnDevice, touchIDObjectInStorage, expectedTouchIDEnable) in [
            (false, true, false),
            (false, false, false),
            (true, nil, true),
            (true, true, true)
            ] {
                appAuth.fakeTouchIDEnabledOnDevice = touchIDEnabledOnDevice
                storage.fakeTouchIDObjectInStorage = touchIDObjectInStorage
                XCTAssertEqual(appAuth.touchIDEnabled, expectedTouchIDEnable)
                XCTAssertEqual(appAuth.touchIDEnabled, appAuth.authEnabled)
        }
        
        //set TouchID
        appAuth.fakeTouchIDEnabledOnDevice = true
        storage.fakeTouchIDObjectInStorage = true
        for enable in [true, false] {
            appAuth.setTouchID(enabled: enable)
            XCTAssertEqual(enable, appAuth.touchIDEnabled)
        }
    }
}

final class FakeAppAuthentication: AppAuthentication {
    
    var fakeStorage = FakeStorage()
    var fakeTouchIDEnabledOnDevice = false
    
    override var storage: SWStorage {
        return fakeStorage
    }
    
    override var touchIDEnabledOnDevice: Bool {
        return fakeTouchIDEnabledOnDevice
    }
}

class FakeStorage: SWStorage {
    
    var fakeTouchIDIsOn: Bool = false
    var fakePasscodeIsOn: Bool = false
    var fakeTouchIDEnable: Bool = false
    var fakePasscodeEnable: Bool = false
    
    var fakeTouchIDObjectInStorage: Bool?
    
    func passcodeEnabled() -> Bool {
        return fakePasscodeEnable
    }
    
    func setPasscode(_ passcode: String) {
        //not testing
    }
    
    func touchIDEnabled() -> Bool {
        return fakeTouchIDEnable
    }
    
    func touchIDObjectInStorage() -> Bool? {
        return fakeTouchIDObjectInStorage
    }
    
    func setTouchID(_ enable: Bool) {
        fakeTouchIDEnable = enable
    }
    
    func removeAllInfo() {
        
    }
}

