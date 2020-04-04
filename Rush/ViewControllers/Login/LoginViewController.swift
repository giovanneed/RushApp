
//
//  Created by giovanne emiliano
//  Student ID: 301044051
//  Copyright © 2020 Centennial College. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var viewLogin: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewLogin.materialCardLayout()
        

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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueSignIn" {
            if let signInViewController = segue.destination as? SignInTableViewController {
                signInViewController.loginDelegate = self
            }
        }
    }

}

extension LoginViewController : LoginDelegate {
    func signInWithUsername(username: String, password: String) {
        performSegue(withIdentifier: "SegueMain", sender: nil)
    }
    
    func signUp() {
        performSegue(withIdentifier: "SegueSignUp", sender: nil)

    }
}


protocol LoginDelegate: class {
  

    
    func signInWithUsername(username: String, password: String)
   
    func signUp()

    
}
