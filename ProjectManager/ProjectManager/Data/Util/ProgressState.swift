import Foundation

enum ProgressState: CustomStringConvertible, CaseIterable {
    
    case todo
    case doing
    case done
    
    var description: String {
        switch self {
        case .todo:
            return "todo"
        case .doing:
            return "doing"
        case .done:
            return "done"
        }
    }
}

