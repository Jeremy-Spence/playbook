//
//  styling.swift
//  Playbook
//
//  Created by Jeremy Spence on 6/3/17.
//  Copyright © 2017 Jeremy Spence. All rights reserved.
//

import Foundation
import UIKit

enum CellTag: Int {
    
    case tvAddAuthorOnboardingLabel = 8001
    case tvAddAuthorOnboardingImage = 8007
    case tvAddAuthorOnboardingButton = 8002
    case tvAddAuthorOnboardingDescription = 8003
    case cvAddAuthorOnboardingLabel = 9001
    case cvAddAuthorOnboardingView = 9000
    case cvAddAuthorOnboardingPic = 9007
    case tvHomeTitle = 5003
    case tvHomePic = 5007
    case tvHomeAuthor = 5001
    case tvHomeDate = 5008
    case tvHomeTag1 = 5004
    case tvHomeTag2 = 5005
    case tvHomeTag3 = 5006
    case cvHomeView = 1000
    case cvHomeLabel = 1001
    case cvHomePic = 1007
    case tvAddAuthorLabel = 2001
    case tvAddAuthorImage = 2007
    case tvAddAuthorButton = 2002
    case tvAddAuthorDescription = 2003
    case cvAddAuthorLabel = 3001
    case cvAddAuthorView = 3000
    case cvAddAuthorPic = 3007
    
    func cvGetView(cell: UICollectionViewCell) -> UIView {
        switch self {
        case .cvAddAuthorOnboardingLabel: return cell.viewWithTag(9001)!
        case .cvAddAuthorOnboardingView: return cell.viewWithTag(9000)!
        case .cvAddAuthorOnboardingPic: return cell.viewWithTag(9007)!
        case .cvHomeView: return cell.viewWithTag(1000)!
        case .cvHomeLabel: return cell.viewWithTag(1001)!
        case .cvHomePic: return cell.viewWithTag(1007)!
        case .cvAddAuthorLabel: return cell.viewWithTag(3001)!
        case .cvAddAuthorView: return cell.viewWithTag(3000)!
        case .cvAddAuthorPic: return cell.viewWithTag(3007)!
        default: return UIView()
        }
    }
    
    func tvGetView(cell: UITableViewCell) -> UIView {
        switch self {
        case .tvAddAuthorOnboardingLabel: return cell.viewWithTag(8001)!
        case .tvAddAuthorOnboardingImage: return cell.viewWithTag(8007)!
        case .tvAddAuthorOnboardingButton: return cell.viewWithTag(8002)!
        case .tvAddAuthorOnboardingDescription: return cell.viewWithTag(8003)!
        case .tvHomeTitle: return cell.viewWithTag(5003)!
        case .tvHomePic: return cell.viewWithTag(5007)!
        case .tvHomeAuthor: return cell.viewWithTag(5001)!
        case .tvHomeDate: return cell.viewWithTag(5008)!
        case .tvHomeTag1: return cell.viewWithTag(5004)!
        case .tvHomeTag2: return cell.viewWithTag(5005)!
        case .tvHomeTag3: return cell.viewWithTag(5006)!
        case .tvAddAuthorLabel: return cell.viewWithTag(2001)!
        case .tvAddAuthorImage: return cell.viewWithTag(2007)!
        case .tvAddAuthorButton: return cell.viewWithTag(2002)!
        case .tvAddAuthorDescription: return cell.viewWithTag(2003)!
        default: return UIView()
        }
    }
    
}

public func round(view: UIView) {
    view.layer.cornerRadius = view.layer.frame.width/2
}

public func round(image: UIImageView) {
    image.layer.cornerRadius = image.layer.frame.width/2
    image.clipsToBounds = true
}











