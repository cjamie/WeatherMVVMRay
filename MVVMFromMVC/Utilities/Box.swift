
import Foundation

final class Box<T> {
    typealias Listener = (T) -> Void
    
    private var listener: Listener?
    
    // MARK: - Public API
    
    var value: T {
        didSet {
            listener?(value)
        }
    }

    func bind(listener: Listener? = nil) {
        self.listener = listener
        listener?(value)
    }
    
    // MARK: - Init
    
    init(_ value: T) {
        self.value = value
    }
    
}
