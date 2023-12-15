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
public class ComponentEntity: SelfDescribingJson {
    
    /// A globally unique ID for a component. Generated by the tracker if not provided by the user.
    @objc
    public var id: UUID
    
    /// Type of the component, e.g. "PointLightComponent".
    @objc
    public var type: String
    
    // Unique IDs of the RealityKit entity(s) that this component is attached to.
    @objc
    public var entityUuids: [UUID]
    
    /// Textual description of the component.
    @objc
    public var componentDescription: String?
    
    @objc
    override public var data: [String : Any] {
        get {
            var data: [String : Any] = [
                "id": id.uuidString,
                "type": type
            ]
            data["entity_uuids"] = entityUuids.map({ $0.uuidString })
            if let componentDescription = componentDescription { data["description"] = componentDescription }
            return data
        }
        set {}
    }
    
    /// - Parameter id: A globally unique ID for a component. Generated by the tracker if not provided by the user.
    /// - Parameter type: Type of the component, e.g. "PointLightComponent".
    /// - Parameter entityUuids: Unique IDs of the RealityKit entity(s) that this component is attached to.
    /// - Parameter componentDescription: Textual description of the component.
    @objc
    init(
        id: UUID = UUID(),
        type: String,
        entityUuids: [UUID],
        componentDescription: String? = nil
    ) {
        self.id = id
        self.type = type
        self.entityUuids = entityUuids
        self.componentDescription = componentDescription
        super.init(schema: visionOsComponent, andData: [:])
    }
}
