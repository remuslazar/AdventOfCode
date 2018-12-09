import Foundation

struct LicenceFile {
    
    // MARK: - Public API
    let storage: [Int]
    
    var checksum: Int {
        var storage = self.storage
        return calculateChecksum(storage: &storage)
    }
    
    var value: Int {
        var storage = self.storage
        return calculateValue(storage: &storage)
    }
    
    // MARK: - Private implementation
    private struct Header {
        let childNodesCount: Int
        let metadataEntriesCount: Int
        init(storage: inout [Int]) {
            childNodesCount = storage.removeFirst()
            metadataEntriesCount = storage.removeFirst()
        }
    }

    /// Calculates the checksum by adding up all metadata entries recursively
    ///
    /// This method mangles the storage parameter, basically removing all "processed" elements
    /// by unshifting the data stream accordingly
    ///
    /// - Parameter storage
    /// - Returns: sum of the metadata entries
    private func calculateChecksum(storage: inout [Int]) -> Int {

        var checksum = 0

        let header = Header(storage: &storage)

        // Zero or more child nodes (as specified in the header).
        for _ in 0..<header.childNodesCount {
            checksum += calculateChecksum(storage: &storage)
        }

        // One or more metadata entries (as specified in the header).
        for _ in 0..<header.metadataEntriesCount {
            checksum += storage.removeFirst()
        }

        return checksum
    }
    
    /// Calculates the value of a node
    ///
    /// This method mangles the storage parameter, basically removing all "processed" elements
    /// by unshifting the data stream accordingly
    ///
    /// - Parameter storage
    /// - Returns: calculated value
    private func calculateValue(storage: inout [Int]) -> Int {
        return 1
    }
}

let fileURL = Bundle.main.url(forResource: "day8-input", withExtension: "txt")!

let data = try! String(contentsOf: fileURL)
let storage = data
    .trimmingCharacters(in: ["\n"])
    .split(separator: " ")
    .map { Int($0)! }

let licenceFile = LicenceFile(storage: storage)

print("Checksum: \(licenceFile.checksum)")
print("Value: \(licenceFile.value)")

