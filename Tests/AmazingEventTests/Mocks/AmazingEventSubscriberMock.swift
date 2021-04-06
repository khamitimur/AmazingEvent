final class AmazingEventSubscriberMock<T> {
    
    // MARK: - Properties
    
    var invokedHandleAction = false
    var invokedHandleActionSender: AnyObject?
    var invokedHandleActionParameter: T?
    
    // MARK: - Methods
    
    func handleAction(sender: AnyObject?, parameter: T) {
        invokedHandleAction = true
        invokedHandleActionSender = sender
        invokedHandleActionParameter = parameter
    }
}
