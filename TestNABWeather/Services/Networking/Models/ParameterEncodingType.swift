//
//  ParameterEncodingType.swift
//  F99
//
//  Created by Linh Ta on 8/12/20.

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
