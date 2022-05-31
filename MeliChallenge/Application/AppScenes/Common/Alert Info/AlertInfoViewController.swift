//
//  AlertInfoViewController.swift
//  MeliChallenge
//
//  Created by Mayerly Rios on 30/05/22.
//

import UIKit

typealias AlertInfo = AlertInfoViewController

class AlertInfoViewController: UIViewController {
        
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var confirmButton: UIButton!
        
    var message: String?
    var confirm: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - Setup UI
extension AlertInfoViewController {
    
    private func setupView() {
        messageLabel.text = message
    }
}

// MARK: - Actions
extension AlertInfoViewController {
    
    @IBAction func confirmButtonPresed(_ sender: Any) {
        dismiss(animated: true, completion: confirm)
    }
}

// MARK: - Show Alert
extension AlertInfoViewController {
    static func show(controller: UIViewController, message: String? = nil, confirm: (() -> Void)? = nil) {
        let storyboard: UIStoryboard = UIStoryboard(name: "AlertInfo", bundle: nil)
        guard let alert = storyboard.instantiateViewController(withIdentifier: "AlertInfo") as? AlertInfoViewController else { return }
        alert.modalPresentationStyle = .overFullScreen
        alert.modalTransitionStyle = .crossDissolve
        alert.message = message
        alert.confirm = confirm
        controller.present(alert, animated: true, completion: nil)
    }
}
