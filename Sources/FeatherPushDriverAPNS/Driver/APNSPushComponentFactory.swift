//
//  APNSPushComponentBuilder.swift
//  FeatherPushDriverAPNS
//
//  Created by Tibor Bodecs on 2020. 04. 28..
//

import FeatherComponent
import Foundation
import APNS

struct APNSPushComponentFactory: ComponentFactory {

    let context: APNSPushComponentContext

    func build(using config: ComponentConfig) throws -> Component {
        APNSPushComponent(config: config)
    }

}
