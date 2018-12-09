import Foundation

struct CircularArray<Element> {
    private var storage: [Element]
    private var currentIndex: Int

    init(rootElement: Element) {
        storage = [rootElement]
        currentIndex = 0
    }
    
    /// Insert a new element after a specific index. This also sets
    /// the newly inserted element as the current one.
    ///
    /// - Parameters:
    ///   - element: element to be inserted
    ///   - index: the element will be inserted after this index
    mutating func insert(_ element: Element, after index: Int) {
        // calculate the insertion point in the circle
        let newIndex = (currentIndex + 1) % storage.endIndex + 1
        // it is ok for newIndex to be equal circle.endIndex. In this case, the new element will be appended to the array
        storage.insert(element, at: newIndex)
        currentIndex = newIndex
    }
    
    /// Removes the element at the specified index and sets the
    /// current element to be the next one.
    ///
    /// - Parameter index: index of the element to be removed
    /// - Returns: removed element
    mutating func remove(at index: Int) -> Element {
        var indexOfTheElementToBeRemoved = (currentIndex + index) % storage.endIndex
        if (indexOfTheElementToBeRemoved < 0) { indexOfTheElementToBeRemoved += storage.endIndex }
        let elem = storage.remove(at: indexOfTheElementToBeRemoved)
        currentIndex = indexOfTheElementToBeRemoved
        if currentIndex == storage.endIndex {
            currentIndex = 0
        }
        return elem
    }
    
    var current: Element {
        return storage[currentIndex]
    }
    
}

extension CircularArray: CustomStringConvertible {
    var description: String {
        return storage.enumerated()
            .map {
                if $0.offset == currentIndex {
                    return "(\($0.element))"
                } else {
                    return " \($0.element) "
                }
            }
            .joined(separator: " ")
    }
}
