//
//  ProjectModel.swift
//  The Place
//
//  Created by Arthur Daniyarov on 17.02.2020.
//  Copyright © 2020 Arthur Daniyarov. All rights reserved.
//

import Foundation

struct Model {
    
    var title: String
    var hashtag: String
    var text: String
    var status: String
    var upDate: Date
}

class ProjectModel {
    
    var models = [Model]()
    var modelsFiltered = [Model]()
    
    init() {
        
        setup()
    }
    
    func filterModels(text: String) {
        
        modelsFiltered.removeAll()
        
        modelsFiltered = models.filter({ (model) -> Bool in
            
            return model.title.lowercased().contains(text.lowercased())
        })
    }
    
    func removeTask(indexPath: IndexPath) {
        
        models.remove(at: indexPath.row)
    }
    
    func setup() {
        
        let title = ["The Place Project","Back-end project","Dakkar book write","In First Place","What about User?"]
        
        let hashtag = ["#theplaceproject","#backendprj","#dakkarbook","#firstplace","#userexp"]
        
        let status = ["Status", "Priority", "Normal", "Low", "Deadline"]
        
        let text = ["Lorem Ipsum is simply dummy text", " of the printing and typesetting industry. Lorem Ipsum has been the industry's standard", " dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,", " but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more", "recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."]
        
        for _ in 0..<10 {
            
            let number = Int.random(in: 0 ..< title.count)
            
            let today = Date()
            let dateMessage = Calendar.current.date(byAdding: .minute, value: number * 100, to: today)
            
            let model = Model(title: title[number], hashtag: hashtag[number], text: text[number], status: status[number], upDate: dateMessage!)
            models.append(model)
        }
    }
}
