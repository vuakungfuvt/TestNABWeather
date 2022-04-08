//
//  ParameterEncodingType.swift
//  TestNABWeather
//
//  Created by tungphan on 02/04/2022.
//

import Foundation

struct FormDataAttachmentInfo {
    let key: String
    let value: Data
    let fileName: String
    let mimeType: String
}

enum ParameterEncodingType {
    case url
    case json
    case urlAndJson
    case formData(attachments: [FormDataAttachmentInfo])
}
