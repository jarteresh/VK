//
//  MenuVC.swift
//  Vk client
//
//  Created by Ярослав on 29.01.2023.
//

import UIKit

class MenuVC: UIViewController {
    
    let service = Service()
    let session = Session.instance

    override func viewDidLoad() {
        super.viewDidLoad()
        
        service.getFriends(token: session.token)
        service.getPhotos(token: session.token)
        service.getGroups(token: session.token)
        service.getGroupsByName(token: session.token, name: "Apple")

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
