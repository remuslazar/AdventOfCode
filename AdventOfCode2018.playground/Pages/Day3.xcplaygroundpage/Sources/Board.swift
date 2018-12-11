import Foundation

public struct Board {
    public let claims: [Claim]
    public init(claims: [Claim]) {
        self.claims = claims
    }
}

extension Claim: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}

extension Board {
    public var overlapArea: Int {
        let intersectionXCoords = Set(
            claims.map { $0.rectangle.minX } +
            claims.map { $0.rectangle.maxX }
        )
        
        var visibleClaims = Set<Claim>()
        
        for x in intersectionXCoords.sorted() {
            claims.forEach { (claim) in
                if claim.rectangle.minX == x {
                    visibleClaims.insert(claim)
                } else if claim.rectangle.maxX == x {
                    visibleClaims.remove(claim)
                }
            }
            
            // check which visible claims do overlap
            visibleClaims.forEach { (visibleClaim) in
                
            }
        }
        
        return 0
    }
}
