//
//  View+Extension.swift
//  Study_Room
//
//  Created by Joo Young Kim on 2022/01/22.
//

import SwiftUI

extension View {
  func showIf(condition: Bool) -> AnyView {
    if condition {
      return AnyView(self)
    } else {
      return AnyView(EmptyView())
    }
  }
}
