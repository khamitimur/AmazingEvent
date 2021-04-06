public final class AmazingEvent<Parameter: Any> {
    
    // MARK: - Type Aliases
    
    public typealias HandleFunction = (AnyObject, Parameter) -> Void
    
    // MARK: - Private Properties
    
    private var handlers: ContiguousArray<IAmazingEventHandler>
    private var handleFunctions: ContiguousArray<HandleFunction>
    
    // MARK: - Initializers
    
    public init() {
        handlers = ContiguousArray<IAmazingEventHandler>()
        handleFunctions = ContiguousArray<HandleFunction>()
    }
    
    // MARK: - Public Methods
    
    public func subscribe<Target: AnyObject>(target: Target,
                                             handleAction: @escaping (Target) -> (AnyObject, Parameter) -> Void) -> AmazingEventSubscriber<Target, Parameter> {
        let eventSubscriber = AmazingEventSubscriber(event: self, target: target, handleAction: handleAction)
        
        handlers.append(eventSubscriber)
        
        return eventSubscriber
    }
    
    public func subscribe(handleFunction: @escaping HandleFunction) {
        handleFunctions.append(handleFunction)
    }
    
    // MARK: - Internal Methods
    
    internal func invoke(sender: AnyObject, parameter: Parameter) {
        handlers = handlers.filter { $0.canHandle }
        
        handlers.forEach { $0.handle(sender: sender, parameter: parameter) }
        
        handleFunctions.forEach { $0(sender, parameter) }
    }
    
    internal func unsubscribe(eventHandler: IAmazingEventHandler) {
        handlers = handlers.filter { $0 !== eventHandler }
    }
}
