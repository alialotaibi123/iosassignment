
import UIKit

class RegistrationViewController: UIViewController , UIPickerViewDataSource, UIPickerViewDelegate{
    
    var pkrdata=["Melbourne"]
    
    
    @IBOutlet weak var btnCancel: UIButton!
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var lblPassword: UITextField!
    @IBOutlet weak var lblName: UITextField!
    @IBOutlet weak var lblContact: UITextField!
    @IBOutlet weak var lblEmail: UITextField!
    @IBOutlet weak var lblUsername: UITextField!
    @IBOutlet weak var lblConPass: UITextField!
    @IBOutlet weak var pickerCity: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnRegister(_ sender: Any) {
        let dml=DMLOperation()
        var result:Bool = true
        var strinsert=""
        
        if(lblName.text=="" || lblPassword.text=="" || lblContact.text=="" || lblUsername.text=="")
        {
            let alert=UIAlertController(title: "Error", message: "Please fill required fields!", preferredStyle: .alert)
            let ok=UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
        else if(lblPassword.text != lblConPass.text)
        {
            let alert=UIAlertController(title: "Error", message: "Passwords are not same!", preferredStyle: .alert)
            let ok=UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
        else
        {
            strinsert = String(format:"insert into login values (%@,'%@','%@','%@','%@','%@','%@')",dml.selectMax(),lblName.text!,lblContact.text!,lblEmail.text!,pkrdata[pickerCity.selectedRow(inComponent: 0)],lblUsername.text!,lblPassword.text!)
            //print(strinsert)
            
            result=dml.dmlservices(quey: strinsert)
            
            if result==true
            {
                let sec=self.storyboard?.instantiateViewController(withIdentifier: "signin") as! SignInViewController
                self.navigationController?.pushViewController(sec, animated: true)
            }
            else
            {
                print("Somthing went wrong...!")
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return pkrdata.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return pkrdata[row]
    }
    
}
