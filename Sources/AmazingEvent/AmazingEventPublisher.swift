public final class AmazingEventPublisher<Parameter: Any> {
    
    // MARK: - Private Properties
    
    private let event: AmazingEvent<Parameter>
    
    // MARK: - Initializers
    
    public init() {
        event = AmazingEvent()
    }
    
    // MARK: - Public Methods
    
    public func invoke(sender: AnyObject, parameter: Parameter) {
        event.invoke(sender: sender, parameter: parameter)
    }
}
