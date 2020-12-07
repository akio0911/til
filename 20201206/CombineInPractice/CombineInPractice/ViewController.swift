//
//  ViewController.swift
//  CombineInPractice
//
//  Created by akio0911 on 2020/12/06.
//

import UIKit
import Combine

private extension Notification.Name {
    static let newTrickDownload = Notification.Name(rawValue: "newTrickDownload")
}

struct MagicTrick: Decodable {
    static let placeholder = MagicTrick()
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let trickNamePublisher: NotificationCenter.Publisher
//            = NotificationCenter.default.publisher(for: .newTrickDownload)
        
// 定義は以下のようになっている
//        extension NotificationCenter {
//            public struct Publisher : Publisher {
//                public typealias Output = Notification
//                public typealias Failure = Never
        
//        let trickNamePublisher: Publishers.Map<NotificationCenter.Publisher, Data>
//            = NotificationCenter.default.publisher(for: .newTrickDownload)
//            .map({ notification in
//                return notification.userInfo?["data"] as! Data
//            })

// 定義は以下のようになっている
//        public struct Map<Upstream, Output> : Publisher where Upstream : Publisher {
//            public typealias Failure = Upstream.Failure
    }

//    let trickNamePublisher: Publishers.TryMap<NotificationCenter.Publisher, MagicTrick>
//        = NotificationCenter.default.publisher(for: .newTrickDownload)
//        .map({ notification in
//            return notification.userInfo?["data"] as! Data
//        })
//        .tryMap { data -> MagicTrick in
//            let decoder = JSONDecoder()
//            return try decoder.decode(MagicTrick.self, from: data)
//        }

    let trickNamePublisher: Publishers.Catch<Publishers.Decode<Publishers.Map<NotificationCenter.Publisher, JSONDecoder.Input>, MagicTrick, JSONDecoder>, Just<MagicTrick>>

        = NotificationCenter.default.publisher(for: .newTrickDownload)
        .map({ notification in
            return notification.userInfo?["data"] as! Data
        })
        .decode(type: MagicTrick.self, decoder: JSONDecoder())
        .catch { error in
            return Just(MagicTrick.placeholder)
        }
}

