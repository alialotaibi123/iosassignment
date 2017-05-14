
import UIKit

class ViewController: UIViewController {

    
    @IBAction func btnRegister(_ sender: Any) {
        let sec=self.storyboard?.instantiateViewController(withIdentifier: "registration") as! RegistrationViewController
        self.navigationController?.pushViewController(sec, animated: true)
    }
    @IBAction func btnSignin(_ sender: Any) {
        let sec=self.storyboard?.instantiateViewController(withIdentifier: "signin") as! SignInViewController
        self.navigationController?.pushViewController(sec, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden=true
        
        let u = UserDefaults()
        if u.value(forKey: "signin")==nil
        {
            return;
        }
        let q = u.value(forKey: "signin") as! String
        if (q=="done")
        {
            let sec=self.storyboard?.instantiateViewController(withIdentifier: "main") as! MainViewController
            self.navigationController?.pushViewController(sec, animated: true)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

