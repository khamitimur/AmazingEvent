public final class AmazingEvent<Parameter: Any> {
    
    // MARK: - Type Aliases
    
    public typealias HandleFunction = (AnyObject?, Parameter) -> Void
    
    // MARK: - Private Properties
    
    private var handlers: ContiguousArray<IAmazingEventHandler>
    
    // MARK: - Initializers
    
    public init() {
        handlers = ContiguousArray<IAmazingEventHandler>()
    }
    
    // MARK: - Public Methods
    
    /// Subscribes to the event and returns subscriber.
    /// - Parameters:
    ///   - target: Object that owns an event handle function.
    ///   - handleFunction: Event handle function.
    @discardableResult
    public func subscribe<Target: AnyObject>(target: Target,
                                             handleAction: @escaping (Target) -> (AnyObject?, Parameter) -> Void) -> IAmazingEventSubscriber {
        let eventSubscriber = AmazingEventSubscriber(event: self, target: target, handleAction: handleAction)
        
        handlers.append(eventSubscriber)
        
        return eventSubscriber
    }
    
    // MARK: - Internal Methods
    
    internal func invoke(sender: AnyObject?, parameter: Parameter) {
        handlers = handlers.filter { $0.canHandle }
        
        handlers.forEach { $0.handle(sender: sender, parameter: parameter) }
    }
    
    internal func unsubscribe(eventHandler: IAmazingEventHandler) {
        handlers = handlers.filter { $0 !== eventHandler }
    }
}
