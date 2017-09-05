//
//  ExtendedString.swift
//  LacerApp
//
//  Created by Joan Angb on 05/09/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

extension String {
    var isAlphanum: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
}
