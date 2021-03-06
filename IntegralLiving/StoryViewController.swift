//
//  StoryViewController.swift
//  IntegralLiving
//
//  Created by Debashis.Ghosh on 8/16/20.
//  Copyright © 2020 IntegralLiving. All rights reserved.
//

import UIKit

class StoryViewController: UIViewController {

    var catgeoryId = -1
        @IBOutlet weak var label: UILabel!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = UIColor.systemTeal
            // Do any additional setup after loading the view.
            print(catgeoryId)
            getContent(categoryId: catgeoryId){ contentResponse in
                 for content in contentResponse{
                        DispatchQueue.main.async {
                            /*
                            let button = UIButton(frame: CGRect(x: 100, y: 100, width: 200, height: 50))
                            button.backgroundColor = .blue
                            button.setTitle(content.content, for: .normal)
                            button.tag = content.contentResponseID
                            self.view.addSubview(button)
                            */
                            let uiTextView = UITextView(frame: CGRect(x: 5, y: 5, width: self.view.frame.width, height: self.view.frame.height))
                            uiTextView.isScrollEnabled = true
                            uiTextView.isUserInteractionEnabled = true
                            uiTextView.isEditable = false
                            uiTextView.text = content.content
                            uiTextView.font = UIFont.systemFont(ofSize: 17.0)
                            uiTextView.textContainer.lineFragmentPadding = 0
                            uiTextView.textContainerInset = .zero
                            self.view.addSubview(uiTextView)
                        }
               }
            }
        }
        func getContent(categoryId: Int, completionHandler: @escaping(ContentResponse) -> Void ) -> Void{
            let query = """
                        {"category_id":\(categoryId)}
                        """
            var components = URLComponents()
            components.scheme = "https"
            components.host = "integral-80c7.restdb.io"
            components.path = "/rest/content"
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
                       let response = try decoder.decode(ContentResponse.self, from: data!)
                       completionHandler(response)
                    } catch { print(error) }
                }else{
                    print("error")
                }
            }
            task.resume()
        }

}
