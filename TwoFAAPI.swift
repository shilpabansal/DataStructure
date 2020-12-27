//
//  TwoFAAPI.swift
//  SamsClub
//
//  Created by Shilpa Bansal on 06/01/20.
//  Copyright © 2020 SamsClub. All rights reserved.
//

import Moya
import ServicesBase

/// The endpoints for the TwoFAAPI
public enum TwoFAAPI: VivaldiCommonTargetType, VivaldiTokenAuthorizable {
    case twoFAStatus(encryptedMembershipNumber: String, jSessionID:String, authToken: String)
    case enroll(postBodyData: Data)
    case send(postBodyData: Data)
    case unenroll(postBodyData: Data)
    case validate(authToken: String)
}

extension TwoFAAPI {
    enum Keys: String {
        case encryptedMembershipNumber = "encryptedmembershipnumber"
        case jSessionID = "jsessionid"
        case authToken = "authToken"
    }
}

extension TwoFAAPI {
    public var authorizationType: VivaldiAuthorizationType {
        return .required
    }

    public var path: String {
        switch self {
        case .twoFAStatus(_):
            return "v2/account/two-factor"
        case .enroll(_):
            return "v2/account/two-factor/enroll"
        case .send(_):
            return "v2/account/two-factor/opt/send"
        case .unenroll(_):
            return "v2/account/two-factor/unenroll"
        case .validate:
            return "v2/account/validate-2FA"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .twoFAStatus(_, _, _), .validate(_):
            return .get
        case .unenroll(_):
            return .put
        default:
            return .post
        }
    }

    private var parameters: [String: Any]? {
        switch self {
        case .twoFAStatus(encryptedMembershipNumber, jSessionID, authToken), .validate:
            return .requestParameters(parameters: [Keys.encryptedMembershipNumber.rawValue: encryptedMembershipNumber,
                                                   Keys.jSessionID.rawValue: jSessionID,
                                                   Keys.authToken.rawValue: authToken
            ], encoding: URLEncoding.queryString)
        case .validate(authToken):
            return .requestParameters(parameters: [Keys.authToken.rawValue: authToken], encoding: URLEncoding.queryString)
        case .enroll(postBodyData),
             .send(postBodyData),
             .unenroll(postBodyData):
            return .requestCompositeData(bodyData: postBodyData, urlParameters: [:])
        }
    }

    public var task: Task {
        if let parameters = self.parameters {
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        } else {
            return .requestPlain
        }
    }
}
