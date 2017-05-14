import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtUsername.delegate=self
        txtPassword.delegate=self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true;
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtUsername: UITextField!
    @IBAction func btnSignin(_ sender: Any) {
        if(txtPassword.text=="" || txtUsername.text == "")
        {
            let alert=UIAlertController(title: "Error", message: "Username and Password cannot be empty!", preferredStyle: .alert)
            let ok=UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
        else {
            let dml = DMLOperation()
            let s = dml.searchUser(quey: String(format:"SELECT * FROM login WHERE username='%@' AND password='%@'",txtUsername.text!,txtPassword.text!))
            if s=="valid"
            {
                var ud = UserDefaults()
                ud.set("out", forKey: "image1")
                let sec=self.storyboard?.instantiateViewController(withIdentifier: "main") as! MainViewController
                self.navigationController?.pushViewController(sec, animated: true)
            }
            else
            {
                let alert=UIAlertController(title: "Error", message: "Invalid Username or Password!", preferredStyle: .alert)
                let ok=UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(ok)
                present(alert, animated: true, completion: nil)

            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
