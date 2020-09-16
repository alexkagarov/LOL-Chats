//
//  ChatMessageTableViewCell.swift
//  LOL-Chats
//
//  Created by Mac on 14.09.2020.
//  Copyright © 2020 hialex. All rights reserved.
//

import UIKit

class ChatMessageTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var messageDateLabel: UILabel!
    @IBOutlet weak var messageTextLabel: UILabel!
    @IBOutlet weak var messageInfoButton: UIButton!
    
    @IBOutlet weak var messageBackgroundView: UIView!
    
    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var infoPopUpView: UIView!
    @IBOutlet weak var infoPopUpLabel: UILabel!
    
    // MARK: - Variables
    var infoButtonAction: (()->Void)?
    static let identifier = "ChatMessageTableViewCell"
    
    // MARK: - Cell life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupInfoPopUp()
    }
    
    // MARK: - Convert NSDate to string with desired format
    private func dateToString(date: Date) -> String {
        let df = DateFormatter()
        df.dateFormat = "dd/MM à HH:mm"
        
        return df.string(from: date)
    }
    
    // MARK: - Setup cell view
    func setupCell(message: ChatMessageModel) {
        messageTextLabel.text = message.messageText
        messageDateLabel.text = dateToString(date: message.messageDate)
        
        switch message.messageType {
        case .inbox:
            messageInfoButton.isHidden = true
            setupCellStyle(true)
        case .inboxInfo:
            messageInfoButton.isHidden = false
            setupCellStyle(true)
        default:
            messageInfoButton.isHidden = true
            setupCellStyle(false)
        }
    }
    
    private func setupInfoPopUp() {
        infoPopUpView.layer.cornerRadius = 9

        infoPopUpView.layer.borderColor = UIColor.popupTextColor.cgColor
        infoPopUpView.layer.borderWidth = 1.0
    }
    
    private func setupCellStyle(_ isInbox: Bool) {
        messageBackgroundView.layer.cornerRadius = 9
        messageBackgroundView.backgroundColor = isInbox ? .inboxBackgroundColor : .outboxBackgroundColor
        
        messageDateLabel.textColor = isInbox ? .inboxTextColor : .outboxTextColor
        messageTextLabel.textColor = isInbox ? .inboxTextColor : .outboxTextColor
        
        leftConstraint.constant = isInbox ? 23 : 66
        rightConstraint.constant = isInbox ? 60 : 15
    }
    
    // MARK: - Set message for info pop up
    func setupInfoPopUp(_ message: String) {
        infoPopUpLabel.text = message
    }
    
    // MARK: - IBActions
    @IBAction func onInfoButtonTapped(_ sender: UIButton) {
        infoButtonAction?()
        infoPopUpView.isHidden.toggle()
    }
    
    @IBAction func onInfoPopUpTapped(_ sender: UIButton) {
        infoPopUpView.isHidden.toggle()
    }
}
