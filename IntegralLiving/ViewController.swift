//
//  ViewController.swift
//  IntegralLiving
//
//  Created by Debashis.Ghosh on 8/9/20.
//  Copyright © 2020 IntegralLiving. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemTeal
        getCategories(){ categoryResponse in
            var buttonY: CGFloat = 250
             for category in categoryResponse{
               if(category.categoryID == category.parentID){
                    DispatchQueue.main.async {
                        let button = UIButton(frame: CGRect(x: 100, y: buttonY, width: 200, height: 50))
                        buttonY = buttonY+100
                        button.backgroundColor = .blue
                        button.layer.cornerRadius = 5
                        button.setTitle(category.name, for: .normal)
                        button.tag = category.categoryID
                        button.addTarget(self, action: #selector(self.openTopicView(button:)), for: .touchUpInside)
                       self.view.addSubview(button)
                    }
               }
           }
        }
    }
    func getCategories(completionHandler: @escaping(CategoryResponse) -> Void ) -> Void{
        let url = "https://integral-80c7.restdb.io/rest/category"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("", forHTTPHeaderField: "x-apikey")
        let task = URLSession.shared.dataTask(with: request){
            (data, response, error) in
            if error == nil{
                do {
                   let decoder = JSONDecoder()
                   let response = try decoder.decode(CategoryResponse.self, from: data!)
                   completionHandler(response)
                } catch { print(error) }
            }else{
                print("error")
            }
        }
        task.resume()
    }
    @objc func openTopicView(button: UIButton){
        let topicVC = TopicViewController()
        topicVC.catgeoryId = button.tag
        present(topicVC, animated: true, completion: nil)
    }
}

