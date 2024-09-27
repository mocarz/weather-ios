//
//  ObservableTypeUnitTests.swift
//  WeatherTests
//
//  Created by Michal Mocarski on 27/09/2024.
//

import XCTest
import RxTest
import RxSwift
@testable import Weather

class ObservableTypeUnitTests: XCTestCase {
    
    var scheduler: TestScheduler!
    var subscription: Disposable!
    
    override func setUp() {
        super.setUp()
        scheduler = TestScheduler(initialClock: 0)
    }
    
    override func tearDown() {
        scheduler.scheduleAt(1000) {
            self.subscription.dispose()
        }
        
        super.tearDown()
    }
    
    func testUnwrap() {
        let observer = scheduler.createObserver(Int.self)
        
        let observable = scheduler.createHotObservable([ Recorded.next(100, 1),
                                                         Recorded.next(200, 2),
                                                         Recorded.next(300, 3),
                                                         Recorded.next(400, nil),
                                                         Recorded.next(500, 4) ])
        
        let unwrapObservable = observable.unwrap()
        
        scheduler.scheduleAt(0) {
            self.subscription = unwrapObservable.subscribe(observer)
        }
        
        scheduler.start()
        
        let results = observer.events.map {
            $0.value.element
        }
        
        XCTAssertEqual(results, [1, 2, 3, 4])
    }
}
