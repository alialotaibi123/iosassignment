
import UIKit

class BookViewController: UIViewController {
    
    var uId = ""
    var rId = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let u = UserDefaults()
        //datePicker.time
        uId = u.value(forKey: "id") as! String
        rId = u.value(forKey: "rId") as! String
        
        let date = Date()
        datePicker.minimumDate = date
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BookViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    func dismissKeyboard() {
        view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBook(_ sender: Any) {
        if txtPersons.text==""
        {
            let alert=UIAlertController(title: "Warning", message: "Please Enter no of persons!", preferredStyle: .alert)
            let ok=UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)

        }
        else
        {
            let d = datePicker.date
            let formatter = DateFormatter()
            let formatter1 = DateFormatter()
            let dml = DMLOperation()
            formatter.dateFormat = "yyyy-MM-dd"
            formatter1.dateFormat = "hh:mm"
            let s = String(format: "INSERT INTO all_bookings VALUES(%@,%@,'%@','%@',%@,%@)", uId,rId, formatter.string(from: d),formatter1.string(from: d), txtPersons.text!, dml.selectMaxId())
            
            dml.dmlservices(quey: s)
            let sec=self.storyboard?.instantiateViewController(withIdentifier: "main") as! MainViewController
            self.navigationController?.pushViewController(sec, animated: true)
        }
    }
    @IBAction func btnBack(_ sender: Any) {
        let sec=self.storyboard?.instantiateViewController(withIdentifier: "main") as! MainViewController
        self.navigationController?.pushViewController(sec, animated: true)
    }
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var txtPersons: UITextField!
    @IBOutlet weak var lblName: UILabel!
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
