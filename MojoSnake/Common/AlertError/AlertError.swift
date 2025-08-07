//
//  AlertError.swift
//  ReelsSaver
//
//  Created by Naveen Rana on 25/10/22.
//

import Foundation

enum AlertMessageType {
    
    case invalidReelLink
    case saveFileError
    case novideoUrlFound
    case invalidReelRequest
    case videodurationexceeds
    case videosavedlocally

    var title: String {
        switch self {
        case .invalidReelLink, .novideoUrlFound:
            return "Invalid Link"
        case .saveFileError:
            return "Failed"
        case .videodurationexceeds:
            return "Reel Size Exceeds"
        case .videosavedlocally:
            return "Success"

        default:
            return AppInfo.appname
        }
        
    }
    
    var message: String {
        switch self {
        case .invalidReelLink:
            return "Please enter a valid link"
        case .novideoUrlFound:
            return "No reels found for this link"
        case .saveFileError:
            return "Please Try again"
        case .invalidReelRequest:
            return "This Reel is not supported, This video is either private or not available"
        case .videodurationexceeds:
            return "Something went wrong, please try different reel"

            //return "Reel size of more than \(ReelUrl.durationLimit) minutes is not allowed to download"
        case .videosavedlocally:
            return "Completed successfully!"

            //return "This video has been successfully saved to your album!"
        default:
            return "Please Try again"
        }
        
    }
}

struct AppError: LocalizedError {
    var title: String
    var message: String
    
    init(type: AlertMessageType) {
        self.title = type.title
        self.message = type.message
    }

    
    init(message: String) {
        self.title = ""
        self.message = message
    }
    var errorDescription: String? {
        return message
    }
}
