//
//  ChatMessageModel.swift
//  LOL-Chats
//
//  Created by Mac on 14.09.2020.
//  Copyright © 2020 hialex. All rights reserved.
//

import Foundation

struct ChatMessageModel {
    let messageDate: Date
    let messageText: String
    
    let messageType: MessageType
    
    enum MessageType {
        case inbox, inboxInfo, outbox
    }
}

// MARK: - Hardcoded data for testing
extension ChatMessageModel {
    static func testData() -> [ChatMessageModel] {
        var messages = [ChatMessageModel]()
        
        messages.append(ChatMessageModel(messageDate: Date(timeIntervalSinceNow: -360),
                                         messageText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                                         messageType: .inbox))
        messages.append(ChatMessageModel(messageDate: Date(timeIntervalSinceNow: -300),
                                         messageText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                                         messageType: .inboxInfo))
        messages.append(ChatMessageModel(messageDate: Date(timeIntervalSinceNow: -270),
                                         messageText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                         messageType: .inbox))
        messages.append(ChatMessageModel(messageDate: Date(timeIntervalSinceNow: -30),
                                         messageText: "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                                         messageType: .outbox))
        messages.append(ChatMessageModel(messageDate: Date(timeIntervalSinceNow: -90),
                                         messageText: "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
                                         messageType: .inbox))
        messages.append(ChatMessageModel(messageDate: Date(timeIntervalSinceNow: -30),
                                         messageText: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
                                         messageType: .inbox))
        
        messages.sort(by: { $0.messageDate < $1.messageDate })
        
        return messages
    }
}
