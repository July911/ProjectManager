import UIKit

final class ListDetailUIView: UIView {
    
    private let textfield: UITextField = {
        let textfield = UITextField(frame: .zero)
        textfield.placeholder = "Title"
        textfield.layer.borderColor = UIColor.gray.cgColor
        textfield.layer.borderWidth = 0.5
        textfield.translatesAutoresizingMaskIntoConstraints = false
        
        return textfield
    }()
    
    private let datePicker: UIDatePicker = {
           let datePicker = UIDatePicker()
           datePicker.datePickerMode = .date
           if #available(iOS 13.5, *) {
               datePicker.preferredDatePickerStyle = .wheels
               }
        
           return datePicker
       }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.font = .preferredFont(forTextStyle: .body)
        textView.insertText("Body")
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addViews()
        self.configureLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func extractComponentsData() -> (name: String, detail: String, deadline: Date) {
        guard let name = self.textfield.text,
                let detail = self.textView.text
        else {
            return (name: "", detail: "", deadline: Date())
        }
        
        return (name: name, detail: detail, deadline: self.datePicker.date)
    }
    
    func configureUIComponents(name: String, detail: String, deadline: Date) {
        self.textfield.text = name
        self.datePicker.date = deadline
        self.textView.text = detail
    }
    
    private func addViews() {
        self.addSubview(self.stackView)
    }
    
    private func configureLayout() {
        
        let viewComponents = [textfield, datePicker, textView]
        viewComponents.forEach { component in
            self.stackView.addArrangedSubview(component)
        }
        
        NSLayoutConstraint.activate([
            self.textfield.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            self.datePicker.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 1.0),
            self.textView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            self.textView.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor, multiplier: 0.6)
        ])
        
        NSLayoutConstraint.activate([
            self.stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            self.stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            self.stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
    }
}
