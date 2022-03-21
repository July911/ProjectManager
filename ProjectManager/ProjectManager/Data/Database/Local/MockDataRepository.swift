import Foundation
import RxSwift

final class MockDataRepository: DataRepository {
    
    var dataBase = [Listable]()
    
    func create(object: Listable) {
        self.dataBase.append(object)
    }
    
    func read(identifier: String) -> Listable? {
        (self.dataBase.filter{ $0.identifier == identifier }).first
    }
    
    func update(identifier: String, how object: Listable) {
        let listToUpdatedIndex = self.dataBase.enumerated().filter{ $0.element.identifier == identifier }.map { $0.offset }.first
        self.dataBase[listToUpdatedIndex ?? .zero] = object
    }
    
    func delete(identifier: String) {
        let listToDeleteIndex = self.dataBase.enumerated().filter{ $0.element.identifier == identifier }.map { $0.offset }.first
        self.dataBase.remove(at: listToDeleteIndex ?? .zero)
    }
    
    func fetch() {
        
    }

    func extractAll() -> [Listable] {
        return self.dataBase
    }
    
    func extractRxAll() -> Observable<[Listable]> {
        return Observable.create { emitter in
            let list = self.extractAll()
            emitter.onNext(list)
        return Disposables.create()
        }
    }
    
    private func extractMockList() -> Listable? {
        let uuid = UUID().uuidString
        
        guard let projectMock = Project(name: "프로젝트", detail: "실험데이터", deadline: Date(), indentifier: uuid, progressState: ProgressState.todo.description) as? Listable
        else {
            return nil
        }
        
        return projectMock
    }
}
