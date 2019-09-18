//: [Previous](@previous)

import Foundation
import UIKit
import PlaygroundSupport

// Now, we are going to implement this
// binding pattern using KeyPaths!

class Binding<Destination: AnyObject>: NSObject {
    weak var source: UITextField?
    weak var destination: Destination?
    var property: WritableKeyPath<Destination, String?>
    
    // 👩🏽‍💻👨🏼‍💻 Implement `class Binding`
}

extension UITextField {
    func bindText<Destination>(to destination: Destination, on property: WritableKeyPath<Destination, String?>) -> Binding<Destination> {
        // 👩🏽‍💻👨🏼‍💻 Implement `func bindText()`
    }
}

// Then, we get our previous code back

class ViewModel: NSObject {
    var name: String? {
        didSet { print(name) }
    }
}

class ViewController: UIViewController {
    
    lazy var viewModel: ViewModel = { ViewModel() }()
    lazy var nameTextField: UITextField = { UITextField() }()
    
    var bindings: [Binding<ViewModel>] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        let binding = nameTextField.bindText(to: viewModel, on: \.name)
        bindings.append(binding)
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
}

// Job done 🎉
// Of course, in a real implementation,
// we would definitely take some time
// to improve the ergonomics a little bit 😇

let vc = ViewController()
vc.preferredContentSize = vc.view.frame.size
PlaygroundPage.current.liveView = vc

//: [Next](@next)
