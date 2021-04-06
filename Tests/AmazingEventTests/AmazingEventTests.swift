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
    
    func test_subscribe_whenHandleAction() {
        // given
        let parameter: Int = 5
        
        let subscriberMock = AmazingEventSubscriberMock<Int>()
        let event = AmazingEvent<Int>()
        
        // when
        event.subscribe(target: subscriberMock, handleAction: AmazingEventSubscriberMock.handleAction)
        event.invoke(sender: self, parameter: parameter)
        
        // then
        XCTAssertTrue(subscriberMock.invokedHandleAction)
        XCTAssertTrue(subscriberMock.invokedHandleActionSender! === self)
        XCTAssertEqual(subscriberMock.invokedHandleActionParameter, parameter)
    }
    
    func test_unsubscribe() {
        // given
        let parameter: Int = 5
        
        let subscriberMock = AmazingEventSubscriberMock<Int>()
        let event = AmazingEvent<Int>()
        
        // when
        let subscriber = event.subscribe(target: subscriberMock, handleAction: AmazingEventSubscriberMock.handleAction)
        
        subscriber.unsubscribe()
        
        event.invoke(sender: self, parameter: parameter)
        
        // then
        XCTAssertFalse(subscriberMock.invokedHandleAction)
    }
    
    func test_subscribe_whenHandleFunction() {
        // given
        let parameter: Int = 5
        
        let event = AmazingEvent<Int>()
        
        var invokedHandleFunction: Bool!
        var invokedHandleFunctionSender: AnyObject!
        var invokedHandleFunctionParameter: Int!
        
        // when
        event.subscribe { sender, parameter in
            invokedHandleFunction = true
            invokedHandleFunctionSender = sender
            invokedHandleFunctionParameter = parameter
        }
        
        event.invoke(sender: self, parameter: parameter)
        
        // then
        XCTAssertTrue(invokedHandleFunction)
        XCTAssertTrue(invokedHandleFunctionSender === self)
        XCTAssertEqual(invokedHandleFunctionParameter, parameter)
    }
}
