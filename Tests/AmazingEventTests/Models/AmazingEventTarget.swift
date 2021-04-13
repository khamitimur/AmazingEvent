final class AmazingEventTarget<T> {
    
    // MARK: - Properties
    
    var invokedHandle = false
    var invokedHandleSender: AnyObject?
    var invokedHandleParameter: T?
    
    // MARK: - Methods
    
    func handle(sender: AnyObject?, parameter: T) {
        invokedHandle = true
        invokedHandleSender = sender
        invokedHandleParameter = parameter
    }
}
