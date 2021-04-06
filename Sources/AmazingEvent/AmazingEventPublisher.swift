/// Publisher of an event.
public final class AmazingEventPublisher<Parameter: Any> {
    
    // MARK: - Public Properties
    
    /// Gets the event assosiated with the publisher.
    public let event: AmazingEvent<Parameter>
    
    // MARK: - Initializers
    
    public init() {
        event = AmazingEvent()
    }
    
    // MARK: - Public Methods
    
    /// Invokes assosiated event.
    /// - Parameters:
    ///   - sender: The source of the event to pass to the handlers.
    ///   - parameter: A parameter to pass to the handlers.
    public func invoke(sender: AnyObject?, parameter: Parameter) {
        event.invoke(sender: sender, parameter: parameter)
    }
}

public extension AmazingEventPublisher where Parameter == Void {
    
    // MARK: - Methods
    
    /// Invokes assosiated event.
    /// - Parameters:
    ///   - sender: The source of the event to pass to the handlers.
    func invoke(sender: AnyObject?) {
        self.invoke(sender: sender, parameter: ())
    }
}
