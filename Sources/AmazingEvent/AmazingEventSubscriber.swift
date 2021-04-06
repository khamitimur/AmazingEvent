public protocol IAmazingEventSubscriber: AnyObject {
    
    // MARK: - Methods
    
    /// Unsubscribes from associated event.
    func unsubscribe()
}

internal protocol IAmazingEventHandler: AnyObject {
    
    // MARK: - Properties
    
    var canHandle: Bool { get }
    
    // MARK: - Methods
    
    func handle(sender: AnyObject?, parameter: Any)
}

final class AmazingEventSubscriber<Target: AnyObject, Parameter: Any>: IAmazingEventSubscriber, IAmazingEventHandler {
    
    // MARK: - Type Aliases
    
    public typealias HandleFunction = (Target) -> (AnyObject?, Parameter) -> Void
    
    // MARK: - Private Properties
    
    private weak var event: AmazingEvent<Parameter>?
    private weak var target: Target?
    
    private let handleFunction: HandleFunction
    
    // MARK: - Initializers
    
    internal init(event: AmazingEvent<Parameter>,
                  target: Target,
                  handleFunction: @escaping HandleFunction) {
        self.event = event
        self.target = target
        
        self.handleFunction = handleFunction
    }
    
    // MARK: - IAmazingEventSubscriber
    
    public func unsubscribe() {
        event?.unsubscribe(eventHandler: self)
    }
    
    // MARK: - IAmazingEventHandler
    
    var canHandle: Bool {
        target != nil
    }
    
    func handle(sender: AnyObject?, parameter: Any) {
        guard let target = target else { return }
        
        handleFunction(target)(sender, parameter as! Parameter)
    }
}
