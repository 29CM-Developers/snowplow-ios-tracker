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

import XCTest
import ARKit
@testable import SnowplowTracker

class TestVisionOSSerialisation: XCTestCase {
    let id = UUID()
    let id2 = UUID()
    
    func testBuildsComponentEntity() {
        let component = ComponentEntity(
            id: self.id,
            type: "Transform",
            entityUuids: [id2],
            componentDescription: "transforms things"
        )
        let entity = component.entity
        
        XCTAssertEqual(visionOsComponent, entity.schema)
        XCTAssertEqual(id.uuidString, entity.data["id"] as? String)
        XCTAssertEqual("Transform", entity.data["type"] as? String)
        XCTAssertEqual("transforms things", entity.data["description"] as? String)
        XCTAssertEqual([id2.uuidString], entity.data["entity_uuids"] as? Array<String>)
    }
    
    func testBuildsImmersiveSpaceEntity() {
        let space = ImmersiveSpaceEntity(
            id: id,
            immersiveSpaceId: "space_123",
            immersionStyle: ImmersionStyle.automatic,
            upperLimbVisibility: UpperLimbVisibility.visible
        )
        let entity = space.entity
        
        XCTAssertEqual(visionOsImmersiveSpace, entity.schema)
        XCTAssertEqual(id.uuidString, entity.data["id"] as? String)
        XCTAssertEqual("space_123", entity.data["immersive_space_id"] as? String)
        XCTAssertEqual("automatic", entity.data["immersion_style"] as? String)
        XCTAssertEqual("visible", entity.data["upper_limb_visibility"] as? String)
    }
    
    func testBuildsRealityKitEntity() {
        let rkEntity = RealityKitEntity(
            id: "12345",
            name: "entity_entity",
            parentEntityID: "1234567",
            anchorID: "6789",
            sceneID: "123",
            sceneName: "scene",
            uuid: id
        )
        let entity = rkEntity.entity
        
        XCTAssertEqual(visionOsRealityKitEntity, entity.schema)
        XCTAssertEqual("12345", entity.data["id"] as? String)
        XCTAssertEqual("entity_entity", entity.data["name"] as? String)
        XCTAssertEqual("1234567", entity.data["parent_entity_id"] as? String)
        XCTAssertEqual("6789", entity.data["anchor_id"] as? String)
        XCTAssertEqual("123", entity.data["scene_id"] as? String)
        XCTAssertEqual("scene", entity.data["scene_name"] as? String)
        XCTAssertEqual(id.uuidString, entity.data["uuid"] as? String)
    }
    
    func testBuildsTrackableAnchorEntity() {
        let anchor = TrackableAnchorEntity(
            id: id,
            type: TrackableAnchorType.hand,
            anchorDescription: "an anchor",
            isTracked: true,
            referenceImage: MockReferenceImage()
        )
        let entity = anchor.entity
        let imageMap = entity.data["reference_image"] as? [String : Any]
        
        XCTAssertEqual(visionOsTrackableAnchor, entity.schema)
        XCTAssertEqual(id.uuidString, entity.data["id"] as? String)
        XCTAssertEqual("hand", entity.data["type"] as? String)
        XCTAssertEqual("an anchor", entity.data["description"] as? String)
        XCTAssertEqual(true, entity.data["is_tracked"] as? Bool)
        if let map = imageMap {
            if let width = map["width"] {
                XCTAssertEqual(3.0, width as? Double)
            }
            if let height = map["height"] {
                XCTAssertEqual(2.1, height as? Double)
            }
            if let description = map["description"] {
                XCTAssertEqual("image description", description as? String)
            }
            if let name = map["name"] {
                XCTAssertEqual("image name", name as? String)
            }
        }
    }
    
    func testBuildsWindowEntity() {
        let window = WindowEntity(
            id: "12345",
            title: "window title",
            windowStyle: .automatic
        )
        let entity = window.entity
        
        XCTAssertEqual(visionOsWindow, entity.schema)
        XCTAssertEqual("12345", entity.data["id"] as? String)
        XCTAssertEqual("window title", entity.data["title"] as? String)
        XCTAssertEqual("automatic", entity.data["window_style"] as? String)
    }
    
    func testBuildsWindowGroupEntity() {
        let windows = WindowGroupEntity(
            id: id,
            titleKey: "title",
            windowGroupID: "group_id",
            windowStyle: .plain
        )
        let entity = windows.entity
        
        XCTAssertEqual(visionOsWindowGroup, entity.schema)
        XCTAssertEqual(id.uuidString, entity.data["id"] as? String)
        XCTAssertEqual("title", entity.data["title_key"] as? String)
        XCTAssertEqual("group_id", entity.data["window_group_id"] as? String)
        XCTAssertEqual("plain", entity.data["window_style"] as? String)
    }
}

class MockReferenceImage: ImageAnchorDetails {
    public var widthDetails: Double { return 3.0 }
    public var heightDetails: Double { return 2.1 }
    public var descriptionDetails: String { return "image description" }
    public var nameDetails: String? { return "image name" }
}
