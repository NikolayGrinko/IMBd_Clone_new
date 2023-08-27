//
//  Extensions.swift
//  IMBD_Clone_new
//
//  Created by Николай Гринько on 26.08.2023.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}


