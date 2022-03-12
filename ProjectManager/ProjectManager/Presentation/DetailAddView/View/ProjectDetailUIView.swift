import UIKit

class ProjectDetailUIView: UIView {
    
    private let textfield: UITextField = {
        let textfield = UITextField(frame: .zero)
        textfield.placeholder = "Input Name Here"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private let datePicker: UIDatePicker = {
        let datepicker = UIDatePicker(frame: .zero)
        datepicker.datePickerMode = .date
        datepicker.translatesAutoresizingMaskIntoConstraints = false
        return datepicker
    }()
    
    private let textView: UITextView = {
        let textView = UITextView(frame: .zero)
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 0.5
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                self.textfield,
                self.datePicker,
                self.textView
            ]
        )
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func addViews() {
        self.addSubview(self.stackView)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            self.stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            self.stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            self.stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
    }
}