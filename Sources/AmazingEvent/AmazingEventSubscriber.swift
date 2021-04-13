/// Event subscriber.
public protocol IAmazingEventSubscriber: AnyObject {
    
    // MARK: - Methods
    
    /// Unsubscribes from the event.
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
    
    public typealias HandleAction = (Target) -> (AnyObject?, Parameter) -> Void
    
    // MARK: - Private Properties
    
    private weak var event: AmazingEvent<Parameter>?
    private weak var target: Target?
    
    private let handleAction: HandleAction
    
    // MARK: - Initializers
    
    internal init(event: AmazingEvent<Parameter>,
                  target: Target,
                  handleAction: @escaping HandleAction) {
        self.event = event
        self.target = target
        
        self.handleAction = handleAction
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
        
        handleAction(target)(sender, parameter as! Parameter)
    }
}
