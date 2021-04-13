import XCTest

@testable import AmazingEvent

final class AmazingEventTests: XCTestCase {
    
    // MARK: - Lifecycle
    
    override func setUpWithError() throws {
        try? super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try? super.tearDownWithError()
    }

    // MARK: - Tests
    
    func test_subscribe() {
        // given
        let parameter: Int = 5
        
        let eventTarget = AmazingEventTarget<Int>()
        let event = AmazingEvent<Int>()
        
        // when
        event.subscribe(target: eventTarget, handleAction: AmazingEventTarget.handle)
        event.invoke(sender: self, parameter: parameter)
        
        // then
        XCTAssertTrue(eventTarget.invokedHandle)
        XCTAssertTrue(eventTarget.invokedHandleSender! === self)
        XCTAssertEqual(eventTarget.invokedHandleParameter, parameter)
    }
    
    func test_unsubscribe() {
        // given
        let parameter: Int = 5
        
        let eventTarget = AmazingEventTarget<Int>()
        let event = AmazingEvent<Int>()
        
        // when
        let subscriber = event.subscribe(target: eventTarget, handleAction: AmazingEventTarget.handle)
        
        subscriber.unsubscribe()
        
        event.invoke(sender: self, parameter: parameter)
        
        // then
        XCTAssertFalse(eventTarget.invokedHandle)
    }
}
