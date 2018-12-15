import Foundation

public struct Board {
    public let claims: [Claim]
    public init(claims: [Claim]) {
        self.claims = claims
    }
}

extension Board {
    public var overlapArea: Int {
        
        let xRanges = Range<Int>.ranges(from: claims.map { $0.minX } + claims.map { $0.maxX })
        var totalArea = 0
        for xRange in xRanges {
            let visibleClaims = claims.filter { $0.contains(xRange: xRange) }
            let yRanges = Range<Int>.ranges(from: visibleClaims.map { $0.minY } + visibleClaims.map { $0.maxY })

            let overlapingYRanges = yRanges.filter { (yRange) -> Bool in
                return visibleClaims.filter { $0.contains(yRange: yRange) }.count > 1
            }
            
            let totalVerticalLength = overlapingYRanges.map { $0.upperBound - $0.lowerBound }.reduce(0, +)
            totalArea += totalVerticalLength * (xRange.upperBound - xRange.lowerBound)
        }
        
        return totalArea
    }

    public var nonOverlapingClaims: Set<Claim> {

        var nonOverlapingClaimsCandidates = Set(self.claims)
        
        let xRanges = Range<Int>.ranges(from: claims.map { $0.minX } + claims.map { $0.maxX })
        for xRange in xRanges {
            let visibleClaims = claims.filter { $0.contains(xRange: xRange) }
            let yRanges = Range<Int>.ranges(from: visibleClaims.map { $0.minY } + visibleClaims.map { $0.maxY })
            
            let overlapingYRanges = yRanges.filter { (yRange) -> Bool in
                return visibleClaims.filter { $0.contains(yRange: yRange) }.count > 1
            }
            // remove all affected claims from the candidates list
            for overlapingYRange in overlapingYRanges {
                visibleClaims.filter { $0.contains(yRange: overlapingYRange)}.forEach { nonOverlapingClaimsCandidates.remove($0) }
            }
        }
        return nonOverlapingClaimsCandidates
    }
}
