//
//  ModelFile.swift
//  ModelGenerator
//
//  Created by Pawan Kumar on 01/06/16.
//  Copyright © 2016 Pawan Kumar K M. All rights reserved.
//

import Foundation
import SwiftyJSON

/// A protocol defining the structure of the model file.
protocol ModelFile {
    /// Filename for the model.
    var fileName: String { get set }

    /// Original JSON source file used for generating this model.
    var sourceJSON: JSON { get set }

    /// Type of the the object, if a structure or a class.
    var type: ConstructType { get }

    /// Storage for various components of the model, it is used to store the intermediate data.
    var component: ModelComponent { get set}

    /// Configuration to be used for this model file's generation.
    var configuration: ModelGenerationConfiguration? { get set }

    // Initialiser function's assignment and function parameters for classes.
    var propertyComponents: [PropertyComponent]? { get set}
        
    /// Set the basic information for the given model file.
    ///
    /// - Parameters:
    ///   - fileName: Name of the model file.
    ///   - configuration: Configuration for the model file.
    mutating func setInfo(_ fileName: String, _ configuration: ModelGenerationConfiguration)

    /// Generate various required components for the given property.
    ///
    /// - Parameter property: Property for which components are to be generated.
    mutating func generateAndAddComponentsFor(_ property: PropertyComponent)
    
    /// - Parameter property: Property for which components are to be generated.
    mutating func generateAllComponents()
    
    
    /// - Parameter property: Property for which components are to be generated.
    mutating func addComponentsFor(_ property: PropertyComponent)

}

