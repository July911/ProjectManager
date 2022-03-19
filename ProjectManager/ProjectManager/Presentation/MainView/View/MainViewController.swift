import UIKit
import RxSwift
import RxCocoa

final class MainViewController: UIViewController {
    
    // MARK: - properties
    var viewModel: MainViewModel?
    private var shareView = MainUIView()
    let disposeBag = DisposeBag()
    
    // MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureMainView()
        self.configureLayout()
        self.configureNavigationItems()
        let input = self.configureInput()
        self.configureOutput(input: input)
    }
    
  // MARK: - methods
    private func configureMainView() {
        view.addSubview(shareView)
        view.backgroundColor = .white
        shareView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureNavigationItems() {
        self.navigationItem.title = "ProjectManager"
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: nil
        )
    }

    private func configureLayout() {
        NSLayoutConstraint.activate([
            shareView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            shareView.trailingAnchor.constraint(equalTo:  self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            shareView.topAnchor.constraint(equalTo:  self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            shareView.bottomAnchor.constraint(equalTo:  self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
    }
    
    // MARK: - bind UI w/ RxSwift 
    private func configureInput() -> MainViewModel.Input {
        
        let rightBarButton = self.extractRightBarButtonItem()
        
        let input = MainViewModel
            .Input(
                viewWillAppearEvent: self.rx.methodInvoked(#selector(UIViewController.viewWillAppear(_:))).map { _ in },
                projectAddButtonTapped: rightBarButton.rx.tap.asObservable(), projectDeleteEvent: shareView.todoTableView.rx.modelDeleted(Project.self).map { $0.identifier }, projectDidtappedEvent: shareView.todoTableView.rx.modelSelected(Project.self).map { $0.identifier }
            )
        
        return input
    }
        
    private func configureOutput(input: MainViewModel.Input) {
        let output = self.viewModel?.transform(input: input, disposeBag: self.disposeBag)
        let stateWithTableViews = self.zipStateWithTableViews()
        stateWithTableViews.forEach { zip in
            output?.baseProjects.map({ lists in
                lists.filter { $0.progressState.description == zip.key }
            })
            .asDriver(onErrorJustReturn: [])
            .drive(zip.value.rx.items(cellIdentifier: String(describing: ProjectUITableViewCell.self), cellType: ProjectUITableViewCell.self)) { index, item , cell in
                cell.configureCellUI(data: item)
            }.disposed(by: disposeBag)
        }
    }
    
    private func extractRightBarButtonItem() -> UIBarButtonItem {
        
        guard let rightBarButton = self.navigationItem.rightBarButtonItem
        else {
            return UIBarButtonItem()
        }
        
        return rightBarButton
    }
    
    private func zipStateWithTableViews() -> [String: UITableView] {
        let zip = Dictionary(
            uniqueKeysWithValues: zip([ProgressState.todo.description,ProgressState.doing.description,ProgressState.done.description], [shareView.todoTableView,shareView.doingTableView,shareView.doneTableView])
        )
        
        return zip
    }
}

