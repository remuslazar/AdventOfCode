import Foundation

struct LicenceFile {
    
    enum LicenceFileError: Error {
        case invalid
    }
    
    let storage: [Int]

    var checksum: Int {
        var storage = self.storage
        return calculateChecksum(storage: &storage)
    }
    
    /// Calculates the checksum by adding up all metadata entries recursively
    ///
    /// This method mangles the storage parameter, basically removing all "processed" elements
    /// by unshifting the data stream accordingly
    ///
    /// - Parameter storage
    /// - Returns: sum of the metadata entries
    private func calculateChecksum(storage: inout [Int]) -> Int {
        struct Header {
            let childNodesCount: Int
            let metadataEntriesCount: Int
        }

        var checksum = 0

        let header = Header(childNodesCount: storage.removeFirst(), metadataEntriesCount: storage.removeFirst())

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
}

let fileURL = Bundle.main.url(forResource: "day8-input", withExtension: "txt")!

let data = try! String(contentsOf: fileURL)
let storage = data
    .trimmingCharacters(in: ["\n"])
    .split(separator: " ")
    .map { Int($0)! }

let licenceFile = LicenceFile(storage: storage)
let checksum = licenceFile.checksum

print("Checksum: \(checksum)")

