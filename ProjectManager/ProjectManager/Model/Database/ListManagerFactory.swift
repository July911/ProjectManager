import Foundation

final class ListManagerFactory {
    
    public func assignListManger(database: DatabaseType) -> ListManager {
        
        switch database {
        case .CoreData:
            return CoredataListManger()
        case .FireBase:
            return FireBaseListManger()
        case .Mock:
            return MockListManager() 
        }
    }
}