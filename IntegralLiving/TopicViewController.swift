//
//  SecondViewController.swift
//  IntegralLiving
//
//  Created by Debashis.Ghosh on 8/15/20.
//  Copyright © 2020 IntegralLiving. All rights reserved.
//

import UIKit

class TopicViewController: UIViewController {
    var catgeoryId = -1
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemTeal
        // Do any additional setup after loading the view.
        print(catgeoryId)
        getCategories(categoryId: catgeoryId){ categoryResponse in
            var buttonY: CGFloat = 100
             for category in categoryResponse{
                    DispatchQueue.main.async {
                        let button = UIButton(frame: CGRect(x: 100, y: buttonY, width: 200, height: 50))
                        buttonY = buttonY+100
                        button.backgroundColor = .blue
                        button.layer.cornerRadius = 5
                        button.setTitle(category.name, for: .normal)
                        button.tag = category.categoryID
                        button.addTarget(self, action: #selector(self.openStoryView(button:)), for: .touchUpInside)
                        self.view.addSubview(button)
                    }
           }
        }
    }
    func getCategories(categoryId: Int, completionHandler: @escaping(CategoryResponse) -> Void ) -> Void{
        let query = """
{"parent_id":\(categoryId),"id":{"$not" : \(categoryId)}}
"""
        
      

        var components = URLComponents()

        components.scheme = "https"
        components.host = "integral-80c7.restdb.io"
        components.path = "/rest/category"
        components.queryItems = [URLQueryItem(name: "q", value: query)]
        var request = URLRequest(url:components.url!)
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
    @objc func openStoryView(button: UIButton){
        let storyVC = StoryViewController()
        storyVC.catgeoryId = button.tag
        present(storyVC, animated: true, completion: nil)
    }
}
