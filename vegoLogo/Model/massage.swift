// To parse the JSON, add this file to your project and do:
//
//   let massage = try? newJSONDecoder().decode(Massage.self, from: jsonData)

import Foundation

class Massage: Codable {
    var chat: [String: Chat]
    
    init(chat: [String: Chat]) {
        self.chat = chat
    }
}

class Chat: NSObject,Codable {
    var masseges: [String: Massege]
    
    enum CodingKeys: String, CodingKey {
        case masseges = "Masseges"
    }
    
    init(masseges: [String: Massege]) {
        self.masseges = masseges
    }
}

class Massege: NSObject,Codable {
    var tokenReceiver, tokenSender, date, senderId: String
    var sendername, msg: String
    
    //    init(tokenReceiver: String, tokenSender: String, date: String, senderID: String, sendername: String, msg: String) {
    //        self.tokenReceiver = tokenReceiver
    //        self.tokenSender = tokenSender
    //        self.date = date
    //        self.senderID = senderID
    //        self.sendername = sendername
    //        self.msg = msg
    //    }
}
