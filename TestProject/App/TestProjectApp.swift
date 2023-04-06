//
//  TestProjectApp.swift
//  TestProject
//
//  Created by ILLIA HOREVOI on 06.03.2023.
//

import SwiftUI

@main
struct TestProjectApp: App {
    @DefaultServiceManager var manager
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                UsersListScene(serviceManage: manager)
            }
        }
    }
}
