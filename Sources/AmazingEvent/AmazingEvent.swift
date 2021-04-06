public final class AmazingEvent<Parameter: Any> {
    
    // MARK: - Type Aliases
    
    public typealias HandleFunction = (AnyObject?, Parameter) -> Void
    
    // MARK: - Private Properties
    
    private var handlers: ContiguousArray<IAmazingEventHandler>
    private var handleFunctions: ContiguousArray<HandleFunction>
    
    // MARK: - Initializers
    
    public init() {
        handlers = ContiguousArray<IAmazingEventHandler>()
        handleFunctions = ContiguousArray<HandleFunction>()
    }
    
    // MARK: - Public Methods
    
    @discardableResult
    public func subscribe<Target: AnyObject>(target: Target,
                                             handleFunction: @escaping (Target) -> (AnyObject?, Parameter) -> Void) -> IAmazingEventSubscriber {
        let eventSubscriber = AmazingEventSubscriber(event: self, target: target, handleFunction: handleFunction)
        
        handlers.append(eventSubscriber)
        
        return eventSubscriber
    }
    
    public func subscribe(handleFunction: @escaping HandleFunction) {
        handleFunctions.append(handleFunction)
    }
    
    // MARK: - Internal Methods
    
    internal func invoke(sender: AnyObject?, parameter: Parameter) {
        handlers = handlers.filter { $0.canHandle }
        
        handlers.forEach { $0.handle(sender: sender, parameter: parameter) }
        
        handleFunctions.forEach { $0(sender, parameter) }
    }
    
    internal func unsubscribe(eventHandler: IAmazingEventHandler) {
        handlers = handlers.filter { $0 !== eventHandler }
    }
}
