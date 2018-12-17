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

    public func doWork(workers: Int = 1, timeOffset: Int = 0) -> Int {
        
        var time = 0
        
        // per worker, assigned job and timestamp when started, nil if idle
        var schedule = [(String,Int)?].init(repeating: nil, count: workers + 1)
        
        var freeWorker: Int? {
            return schedule.enumerated().first(where: { $0.element == nil })?.offset
        }
        
        var executedSteps: [String] = []
        var steps = self.steps

        var stepsAvailable: [String] {
            return steps
                .filter { $0.value.isEmpty || $0.value.allSatisfy { executedSteps.contains($0) } }
                .map { $0.key }
                .sorted()
        }
        
        func workingTime(for step: String) -> Int {
            guard let char = step.first else { return 0 }
            return timeOffset + char.positionAfterA + 1
        }
        
        while true {
            
            // check if there are finished jobs, then mark them as executed and the associated worker
            // as idle
            schedule.enumerated().forEach {
                if let task = $0.element {
                    let step = task.0
                    let totalTime = workingTime(for: step)
                    let elapsed = time - task.1
                    if elapsed == totalTime {
                        // job is finished
                        executedSteps.append(step)
                        // mark worker as idle
                        schedule[$0.offset] = nil
                    }
                }
            }
            
            // if there are idle workers and steps in the ready state, do schedule them to all
            // available idle workers
            while let step = stepsAvailable.first, let worker = freeWorker {
                steps[step] = nil
                schedule[worker] = (step, time)
            }
            
            if executedSteps.count == self.steps.count {
                break
            }
            
            // advance time until a step has been finished
            time += 1
        }
        
        return time
    }
}

private extension Character {
    var positionAfterA: Int {
        return Int(self.unicodeScalars.first!.value) - Int(Character("A").unicodeScalars.first!.value)
    }
}
