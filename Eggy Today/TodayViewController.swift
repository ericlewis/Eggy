//
//  TodayViewController.swift
//  Eggy Today
//
//  Created by Eric Lewis on 10/1/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI
import NotificationCenter

class TodayViewController: UIHostingController<RootView>, NCWidgetProviding {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: RootView())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
