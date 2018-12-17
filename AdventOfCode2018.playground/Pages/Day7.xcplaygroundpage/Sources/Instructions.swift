import Foundation

public struct Instructions {

    public init() { }

    public var steps: Dictionary<String, [String]> = [:]

    public mutating func addInstruction(line: String) {
        // Step F must be finished before step E can begin.
        guard let matches: RegexMatch = Regex(pattern: "Step (.) must be finished before step (.) can begin.") ~= line else {
            fatalError("parse error")
        }
        
        let stepID = matches[2]!
        let dependsOnStepID = matches[1]!
        
        if steps[stepID] != nil {
            steps[stepID]!.append(dependsOnStepID)
        } else {
            steps[stepID] = [dependsOnStepID]
        }
        
        if steps[dependsOnStepID] == nil {
            steps[dependsOnStepID] = []
        }
    }
    
    public func executionOrder() -> [String] {
        var executedSteps: [String] = []
        var steps = self.steps

        func pickNextStep() -> String? {
            let list = steps
                .filter { $0.value.isEmpty || $0.value.allSatisfy { executedSteps.contains($0) } }
                .map { $0.key }
                .sorted()
            
            guard let step = list.first else { return nil }
            steps[step] = nil
            return step
        }

        while executedSteps.count < self.steps.count {
            guard let step = pickNextStep() else { break }
            executedSteps.append(step)
        }
        
        return executedSteps
    }
}
