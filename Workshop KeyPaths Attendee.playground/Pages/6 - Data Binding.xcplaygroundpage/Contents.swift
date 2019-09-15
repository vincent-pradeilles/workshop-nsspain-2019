//: [Previous](@previous)

import Foundation
import UIKit
import PlaygroundSupport

// Let's say we are working on an MVVM archicture

// We want to implement data binding between
// ViewController and ViewModel

// We're going to begin by taking a look at the
// standard UIKit implementation

class ViewModel: NSObject {
    var name: String? {
        didSet { print(name) }
    }
}

class ViewController: UIViewController {
    
    lazy var viewModel: ViewModel = { ViewModel() }()
    
    lazy var nameTextField: UITextField = { UITextField() }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        nameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
                
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.borderStyle = .roundedRect
        nameTextField.placeholder = "Name"
        view.addSubview(nameTextField)
        nameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @objc func textFieldDidChange() {
        viewModel.name = nameTextField.text
    }
}

// It does the job, but it relies on the old
// target/action pattern, which isn't very
// Swifty 😢

let vc = ViewController()
vc.preferredContentSize = vc.view.frame.size
PlaygroundPage.current.liveView = vc

//: [Next](@next)
