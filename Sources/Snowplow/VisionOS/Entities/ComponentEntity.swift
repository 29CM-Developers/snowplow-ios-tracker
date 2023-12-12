//  Copyright (c) 2013-2023 Snowplow Analytics Ltd. All rights reserved.
//
//  This program is licensed to you under the Apache License Version 2.0,
//  and you may not use this file except in compliance with the Apache License
//  Version 2.0. You may obtain a copy of the Apache License Version 2.0 at
//  http://www.apache.org/licenses/LICENSE-2.0.
//
//  Unless required by applicable law or agreed to in writing,
//  software distributed under the Apache License Version 2.0 is distributed on
//  an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
//  express or implied. See the Apache License Version 2.0 for the specific
//  language governing permissions and limitations there under.

import Foundation
import RealityFoundation

/**
 Properties for the RealityKit component entity.
 Entity schema: `iglu:com.apple.arkit/component/jsonschema/1-0-0`
 */
@objc(SPComponentEntity)
public class ComponentEntity: NSObject {
    
    /// A globally unique ID for a component.
    public var id: String
    /// Type of the component, e.g. "PointLightComponent".
    public var type: String
    /// Textual description of the component.
    public var componentDescription: String?
    
    internal var entity: SelfDescribingJson {
        var data: [String : Any] = [
            "id": id,
            "type": type
        ]
        if let componentDescription = componentDescription { data["description"] = componentDescription }
        
        return SelfDescribingJson(schema: VisionOsSchemata.component, andData: data)
    }
    
    /// - Parameter id: A globally unique ID for a component.
    /// - Parameter type: Type of the component, e.g. "PointLightComponent".
    /// - Parameter componentDescription: Textual description of the component.
    @objc
    init(
        id: String,
        type: String,
        componentDescription: String? = nil
    ) {
        self.id = id
        self.type = type
        self.componentDescription = componentDescription
    }
}
