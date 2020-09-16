//
//  ChatViewController.swift
//  LOL-Chats
//
//  Created by Mac on 14.09.2020.
//  Copyright © 2020 hialex. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var inputMessageTextField: UITextField!
    
    // MARK: - Variables (can be moved to VM)
    var messages = [ChatMessageModel]()
    
    // MARK: - VC Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tempData()
        addNotificationObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeNotificationObservers()
    }
    
    // MARK: - Notification observers
    private func addNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard(_:)), name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard(_:)), name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    
    private func removeNotificationObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Handle keyboard appear/disappear
    @objc private func handleKeyboard(_ notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardIsShown = notification.name == UIWindow.keyboardWillShowNotification
            
            if let keyboardFrame = userInfo["UIKeyboardFrameEndUserInfoKey"] as? CGRect {
                bottomConstraint.constant = keyboardIsShown ? -keyboardFrame.height : 0
                
                UIView.animate(withDuration: 0, animations: {
                    self.view.layoutIfNeeded()
                    
                    self.tableView.scrollToRow(at: IndexPath(row: self.messages.count - 1, section: 0), at: .bottom, animated: true)
                })
            }
        }
    }

    // MARK: - Setup view appearance
    private func setupView() {
        inputMessageTextField.clipsToBounds = true
        inputMessageTextField.layer.cornerRadius = inputMessageTextField.frame.height/2
        
        inputMessageTextField.layer.borderColor = UIColor.black.cgColor
        inputMessageTextField.layer.borderWidth = 1.5
    }
    
    // MARK: - Get messages (that are hardcoded for now)
    private func tempData() {
        messages = ChatMessageModel.testData()
        
        // the messages will be set either before the VC loads or with completion handler
        
        DispatchQueue.main.async {
            self.tableView.scrollToRow(at: IndexPath(row: self.messages.count - 1, section: 0), at: .bottom, animated: false)
        }
    }
}

// MARK: - Send message logic
extension ChatViewController {
    private func sendMessage(_ message: ChatMessageModel) {
        messages.append(message)
        
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row: self.messages.count - 1, section: 0), at: .bottom, animated: true)
    }
}

// MARK: - UITableView DataSource Extension
extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatMessageTableViewCell.identifier, for: indexPath) as? ChatMessageTableViewCell else { return UITableViewCell() }
        
        cell.setupCell(message: messages[indexPath.row])
        
        cell.infoButtonAction = {
            // TODO:
            cell.setupInfoPopUp("""
                Ceci est un message
                à caractère informatif.
                Vous n'avez pas besoin
                de répondre à ce message.
            """)
        }
        
        return cell
    }
}

// MARK: - UITableView Delegate Extension
extension ChatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        inputMessageTextField.endEditing(true)
        // here we can also set up various actions for cell selection
    }
}

// MARK: - UITextField Delegate Extension
extension ChatViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let message = textField.text {
            self.sendMessage(ChatMessageModel(messageDate: Date(), messageText: message, messageType: .outbox))
        }
        
        textField.text = ""
        
        return true
    }
}
