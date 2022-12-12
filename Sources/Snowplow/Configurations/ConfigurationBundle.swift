//  SPConfigurationBundle.swift
//  Snowplow
//
//  Copyright (c) 2013-2022 Snowplow Analytics Ltd. All rights reserved.
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
//
//  Authors: Alex Benini
//  License: Apache License Version 2.0
//

import Foundation

/// This class represents the default configuration applied in place of the remote configuration.
@objc(SPConfigurationBundle)
public class ConfigurationBundle: Configuration {
    @objc
    private(set) public var namespace: String
    @objc
    public var networkConfiguration: NetworkConfiguration?
    @objc
    public var trackerConfiguration: TrackerConfiguration?
    @objc
    public var subjectConfiguration: SubjectConfiguration?
    @objc
    public var sessionConfiguration: SessionConfiguration?

    @objc
    public var configurations: [Configuration] {
        var array: [Configuration] = []
        if let networkConfiguration = networkConfiguration {
            array.append(networkConfiguration)
        }
        if let trackerConfiguration = trackerConfiguration {
            array.append(trackerConfiguration)
        }
        if let subjectConfiguration = subjectConfiguration {
            array.append(subjectConfiguration)
        }
        if let sessionConfiguration = sessionConfiguration {
            array.append(sessionConfiguration)
        }
        return array
    }

    @objc
    public convenience init(namespace: String) {
        self.init(namespace: namespace, networkConfiguration: nil)
    }

    @objc
    public init(namespace: String, networkConfiguration: NetworkConfiguration?) {
        self.namespace = namespace
        self.networkConfiguration = networkConfiguration
    }

    @objc
    public init?(dictionary: [String : NSObject]) {
        if let namespace = dictionary["namespace"] as? String {
            self.namespace = namespace
        } else {
            logDebug(message: "Error assigning: namespace")
            return nil
        }
        if let config = dictionary["networkConfiguration"] as? [String : NSObject] {
            networkConfiguration = NetworkConfiguration(dictionary: config)
        }
        if let config = dictionary["trackerConfiguration"] as? [String : NSObject] {
            trackerConfiguration = TrackerConfiguration(dictionary: config)
        }
        if let config = dictionary["subjectConfiguration"] as? [String : NSObject] {
            subjectConfiguration = SubjectConfiguration(dictionary: config)
        }
        if let config = dictionary["sessionConfiguration"] as? [String: NSObject] {
            sessionConfiguration = SessionConfiguration(dictionary: config)
        }
    }

    // MARK: - NSCopying

    @objc
    override public func copy(with zone: NSZone? = nil) -> Any {
        let copy = ConfigurationBundle(namespace: namespace)
        copy.networkConfiguration = networkConfiguration?.copy(with: zone) as? NetworkConfiguration
        copy.trackerConfiguration = trackerConfiguration?.copy(with: zone) as? TrackerConfiguration
        copy.subjectConfiguration = subjectConfiguration?.copy(with: zone) as? SubjectConfiguration
        copy.sessionConfiguration = sessionConfiguration?.copy(with: zone) as? SessionConfiguration
        return copy
    }

    // MARK: - NSSecureCoding
    
    @objc
    public override class var supportsSecureCoding: Bool { return true }

    @objc
    override public func encode(with coder: NSCoder) {
        coder.encode(namespace, forKey: "namespace")
        coder.encode(networkConfiguration, forKey: "networkConfiguration")
        coder.encode(trackerConfiguration, forKey: "trackerConfiguration")
        coder.encode(subjectConfiguration, forKey: "subjectConfiguration")
        coder.encode(sessionConfiguration, forKey: "sessionConfiguration")
    }

    required init?(coder: NSCoder) {
        if let namespace = coder.decodeObject(forKey: "namespace") as? String {
            self.namespace = namespace
        } else {
            return nil
        }
        networkConfiguration = coder.decodeObject(forKey: "networkConfiguration") as? NetworkConfiguration
        trackerConfiguration = coder.decodeObject(forKey: "trackerConfiguration") as? TrackerConfiguration
        subjectConfiguration = coder.decodeObject(forKey: "subjectConfiguration") as? SubjectConfiguration
        sessionConfiguration = coder.decodeObject(forKey: "sessionConfiguration") as? SessionConfiguration
    }
}