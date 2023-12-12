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

/**
 Properties for the Snowplow entity that represents a RealityKit Entity.
 Entity schema: `iglu:com.apple.realitykit/entity/jsonschema/1-0-0`
 */
@objc(SPRealityKitEntity)
public class RealityKitEntity: NSObject {
    
//    /// Randomly generated ID for the view of the immersive space by the tracker.
//    public var id: String
//    /// The identifier of the immersive space to present.
//    public var immersiveSpaceId: String?
//    /// The style of an immersive space.
//    public var immersionStyle: ImmersionStyle
//    /// Preferred visibility of the user's upper limbs, while an immersive space scene is presented.
//    public var upperLimbVisibility: UpperLimbVisibility
//    
//    internal var entity: SelfDescribingJson {
//        var data: [String : Any] = [
//            "id": id
//        ]
//        if let immersiveSpaceId = immersiveSpaceId { data["immersive_space_id"] = immersiveSpaceId }
//        data["immersion_style"] = immersionStyle.value
//        data["upper_limb_visibility"] = upperLimbVisibility.value
//
//        return SelfDescribingJson(schema: VisionOsSchemata.immersiveSpace, andData: data)
//    }
//    
//    /// - Parameter id: Randomly generated ID for the view of the immersive space by the tracker.
//    /// - Parameter immersiveSpaceId: A localized string key to use for the window's title in system menus and in the window's title bar.
//    /// - Parameter immersionStyle: A specification for the appearance and interaction of a window.
//    /// - Parameter upperLimbVisibility: A specification for the appearance and interaction of a window.
//    @objc
//    public init(
//        id: String,
//        immersiveSpaceId: String? = nil,
//        immersionStyle: ImmersionStyle,
//        upperLimbVisibility: UpperLimbVisibility
//    ) {
//        self.id = id
//        self.immersiveSpaceId = immersiveSpaceId
//        self.immersionStyle = immersionStyle
//        self.upperLimbVisibility = upperLimbVisibility
//    }
}
