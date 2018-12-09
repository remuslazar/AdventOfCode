import Foundation

struct CircularArray<Element> {
    
    private class Container<Element> {
        let element: Element
        var next: Container<Element>!
        var prev: Container<Element>!

        init(element: Element) {
            self.element = element
            self.next = self
            self.prev = self
        }
    }
    
    private let root: Container<Element>
    private var capacity: Int
    private var current: Container<Element>

    init(rootElement: Element) {
        root = Container<Element>(element: rootElement)
        current = self.root
        capacity = 1
    }
    
    private func getContainer(relativeOffet: Int) -> Container<Element> {
        var element = current
        if relativeOffet < 0 {
            let count = -relativeOffet
            for _ in 0..<count { element = element.prev }
        } else if relativeOffet > 0 {
            let count = relativeOffet
            for _ in 0..<count { element = element.next }
        }
        return element
    }
    
    /// Insert a new element after a specific index. This also sets
    /// the newly inserted element as the current one.
    ///
    /// - Parameters:
    ///   - element: element to be inserted
    ///   - index: the element will be inserted after this index
    mutating func insert(_ element: Element, after index: Int) {
        // calculate the insertion point in the circle
        let insertAfter = getContainer(relativeOffet: 1)
        let new = Container<Element>(element: element)
        new.prev = insertAfter
        new.next = insertAfter.next

        insertAfter.next.prev = new
        insertAfter.next = new
        current = new
        capacity += 1
    }
    
    /// Removes the element at the specified index and sets the
    /// current element to be the next one.
    ///
    /// - Parameter index: index of the element to be removed
    /// - Returns: removed element
    mutating func remove(at index: Int) -> Element {
        let toRemove = getContainer(relativeOffet: -7)
        toRemove.prev.next = toRemove.next
        toRemove.next.prev = toRemove.prev
        current = toRemove.next
        capacity -= 1
        return toRemove.element
    }
    
    var currentElement: Element {
        return current.element
    }
    
}

//extension CircularArray: CustomStringConvertible {
//    var description: String {
//        return storage.enumerated()
//            .map {
//                if $0.offset == currentIndex {
//                    return "(\($0.element))"
//                } else {
//                    return " \($0.element) "
//                }
//            }
//            .joined(separator: " ")
//    }
//}
