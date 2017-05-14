
import UIKit

class ReviewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var data = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.realodeArray()
        // Do any additional setup after loading the view.
    }

    
    override func viewDidAppear(_ animated: Bool) {
        self.realodeArray()
        tblView.reloadData()
        if data.count==0
        {
            let alert=UIAlertController(title: "OOPS!", message: "No reviews found for this restaurant.", preferredStyle: .actionSheet)
            
            //Set all statastics to zero
            let ok=UIAlertAction(title: "Give Review", style: .destructive, handler: {(alert: UIAlertAction!) in
                let sec=self.storyboard?.instantiateViewController(withIdentifier: "rate") as! RateViewController
                self.navigationController?.pushViewController(sec, animated: true)
            })
            let yes=UIAlertAction(title: "OK", style: .default, handler: {(alert: UIAlertAction!) in
                self.navigationController?.popViewController(animated: true)
            })
            alert.addAction(ok)
            alert.addAction(yes)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func realodeArray(){
        let dml = DMLOperation()
        let u = UserDefaults()
        let s = String(format:"SELECT * FROM ratings WHERE restro_id=%@",(u.value(forKey: "rId") as! String))
        data = dml.reviewData(query: s)
        print(data.count)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var tblView: UITableView!
    @IBAction func btnReview(_ sender: Any) {
        let sec=self.storyboard?.instantiateViewController(withIdentifier: "rate") as! RateViewController
        self.navigationController?.pushViewController(sec, animated: true)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return data.count;
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var mycell=ReviewsTableViewCell()
        mycell=tableView.dequeueReusableCell(withIdentifier: "cell4") as! ReviewsTableViewCell
        
        let d = data.object(at: indexPath.row) as! NSDictionary
        
        mycell.lblName.text=d.value(forKey: "user_id") as! String?
        mycell.lblRate.text=d.value(forKey: "rate") as! String?
        mycell.lblReview.text=d.value(forKey: "review") as! String?
        return mycell
    }
}
