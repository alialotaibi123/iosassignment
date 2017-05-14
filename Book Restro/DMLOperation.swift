
import UIKit

class DMLOperation: NSObject
{
    var strpath=""
    
    
    func dmlservices(quey:String)->Bool
    {
        //sqlite3_close("mydb")
        strpath=""
        var status=false
        var path=NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let str=path[0]
        strpath=str.appending("/mydb.db")
        
        print(quey)
        var stmnt:OpaquePointer?=nil
        if sqlite3_open(strpath, &stmnt) == SQLITE_OK
        {
            if sqlite3_prepare_v2(stmnt, quey, -1, &stmnt, nil) == SQLITE_OK
            {
                sqlite3_step(stmnt)
                status=true
            }
            sqlite3_finalize(stmnt)
            sqlite3_close(stmnt)
        }
        return status
    }
    
        
    func selectMax() -> String
    {
        
        //var status=false
        var path=NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let str=path[0]
        strpath=str.appending("/mydb.db")
        
        
        var stmnt:OpaquePointer?=nil
        if sqlite3_open(strpath, &stmnt) == SQLITE_OK
        {
            if sqlite3_prepare_v2(stmnt, "SELECT MAX(id) FROM login", -1, &stmnt, nil) == SQLITE_OK
            {
                while sqlite3_step(stmnt) == SQLITE_ROW
                {
                    let sid=String(cString:sqlite3_column_text(stmnt, 0))
                    var x = Int(sid)
                    x=x!+1
                    var s = ""
                    s=String(format: "%d", x!)
                    sqlite3_finalize(stmnt)
                    sqlite3_close(stmnt)
                    return s
                }
                sqlite3_finalize(stmnt)
                sqlite3_close(stmnt)
            }
        }
        return ""
    }

    
    func searchUser(quey:String) -> String
    {
        //var status=false
        var path=NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let str=path[0]
        strpath=str.appending("/mydb.db")
        
        
        var stmnt:OpaquePointer?=nil
        if sqlite3_open(strpath, &stmnt) == SQLITE_OK
        {
            if sqlite3_prepare_v2(stmnt, quey, -1, &stmnt, nil) == SQLITE_OK
            {
                while sqlite3_step(stmnt) == SQLITE_ROW
                {
                    let sid=String(cString:sqlite3_column_text(stmnt, 0))
                    let snm=String(cString:sqlite3_column_text(stmnt, 1))
                    let scontact=String(cString:sqlite3_column_text(stmnt, 2))
                    let semail=String(cString:sqlite3_column_text(stmnt, 3))
                    let scity=String(cString:sqlite3_column_text(stmnt, 4))
                    let username=String(cString:sqlite3_column_text(stmnt, 5))
                    let password=String(cString:sqlite3_column_text(stmnt, 6))
                    
                    var u = UserDefaults()
                    u.set(sid, forKey: "id")
                    u.set(snm, forKey: "name")
                    u.set(scontact, forKey: "contact")
                    u.set(semail, forKey: "email")
                    u.set(scity, forKey: "city")
                    u.set(username, forKey: "username")
                    u.set(password, forKey: "password")
                    u.set("done", forKey: "signin")
                    
                    sqlite3_finalize(stmnt)
                    sqlite3_close(stmnt)
                    
                    
                    return "valid"
                }
                sqlite3_finalize(stmnt)
                sqlite3_close(stmnt)
            }
        }
        return "invalid"
    }
    
    
    
    func restauranList(quey:String) -> NSMutableArray
    {
        let dict=NSMutableDictionary()
        let data=NSMutableArray()
        
        //var status=false
        var path=NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let str=path[0]
        strpath=str.appending("/mydb.db")
        
        print(quey)
        
        var stmnt:OpaquePointer?=nil
        if sqlite3_open(strpath, &stmnt) == SQLITE_OK
        {
            if sqlite3_prepare_v2(stmnt, "SELECT * FROM restro_overview", -1, &stmnt, nil) == SQLITE_OK
            {
                while sqlite3_step(stmnt) == SQLITE_ROW
                {
                    let sid=String(cString:sqlite3_column_text(stmnt, 0))
                    let snm=String(cString:sqlite3_column_text(stmnt, 1))
                    let scity=String(cString:sqlite3_column_text(stmnt, 8))
                    
                    dict.setValue(sid, forKey: "id")
                    dict.setValue(snm, forKey: "name")
                    dict.setValue(scity, forKey: "city")
                    dict.setValue(String(cString:sqlite3_column_text(stmnt, 2)), forKey: "address")
                    dict.setValue(String(cString:sqlite3_column_text(stmnt, 3)), forKey: "hours")
                    dict.setValue(String(cString:sqlite3_column_text(stmnt, 4)), forKey: "phone")
                    dict.setValue(String(cString:sqlite3_column_text(stmnt, 5)), forKey: "detail")
                    dict.setValue(String(cString:sqlite3_column_text(stmnt, 6)), forKey: "logitude")
                    dict.setValue(String(cString:sqlite3_column_text(stmnt, 7)), forKey: "latitude")
                    
                    data.add(dict.copy())
                }
                sqlite3_finalize(stmnt)
                sqlite3_close(stmnt)
            }
        }
        return data
    }
    
    
    func menuData(query:String) -> NSMutableArray
    {
        let dict=NSMutableDictionary()
        let data=NSMutableArray()
        
        //var status=false
        var path=NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let str=path[0]
        strpath=str.appending("/mydb.db")
        
        print(query)
        
        var stmnt:OpaquePointer?=nil
        if sqlite3_open(strpath, &stmnt) == SQLITE_OK
        {
            if sqlite3_prepare_v2(stmnt, query, -1, &stmnt, nil) == SQLITE_OK
            {
                while sqlite3_step(stmnt) == SQLITE_ROW
                {
                    dict.setValue(String(cString:sqlite3_column_text(stmnt, 0)), forKey: "id")
                    dict.setValue(String(cString:sqlite3_column_text(stmnt, 1)), forKey: "restro_id")
                    dict.setValue(String(cString:sqlite3_column_text(stmnt, 2)), forKey: "name")
                    dict.setValue(String(cString:sqlite3_column_text(stmnt, 3)), forKey: "price")
                    dict.setValue(String(cString:sqlite3_column_text(stmnt, 4)), forKey: "detail")
                    
                    data.add(dict.copy())
                }
                sqlite3_finalize(stmnt)
                sqlite3_close(stmnt)
            }
        }
        return data
    }

    func allBookings(quey:String) -> NSMutableArray
    {   let dict=NSMutableDictionary()
        let data=NSMutableArray()
        
        //var status=false
        var path=NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let str=path[0]
        strpath=str.appending("/mydb.db")
        
        print(quey)
        
        var stmnt:OpaquePointer?=nil
        if sqlite3_open(strpath, &stmnt) == SQLITE_OK
        {
            if sqlite3_prepare_v2(stmnt, quey, -1, &stmnt, nil) == SQLITE_OK
            {
                while sqlite3_step(stmnt) == SQLITE_ROW
                {
                    dict.setValue(String(cString:sqlite3_column_text(stmnt, 0)), forKey: "user_id")
                    dict.setValue(String(cString:sqlite3_column_text(stmnt, 1)), forKey: "restro_id")
                    dict.setValue(String(cString:sqlite3_column_text(stmnt, 2)), forKey: "book_date")
                    dict.setValue(String(cString:sqlite3_column_text(stmnt, 3)), forKey: "book_time")
                    dict.setValue(String(cString:sqlite3_column_text(stmnt, 4)), forKey: "no_persons")
                    dict.setValue(String(cString:sqlite3_column_text(stmnt, 5)), forKey: "id")
                    data.add(dict.copy())
                }
                sqlite3_finalize(stmnt)
                sqlite3_close(stmnt)
            }
        }
        return data
    }
    
    func restroName(query:String, ind:Int32) -> String
    {
        var path=NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let str=path[0]
        strpath=str.appending("/mydb.db")
        
        var stmnt:OpaquePointer?=nil
        if sqlite3_open(strpath, &stmnt) == SQLITE_OK
        {
            if sqlite3_prepare_v2(stmnt, query, -1, &stmnt, nil) == SQLITE_OK
            {
                while sqlite3_step(stmnt) == SQLITE_ROW
                {
                    let s = String(cString:sqlite3_column_text(stmnt, Int32(ind)))
                    sqlite3_finalize(stmnt)
                    sqlite3_close(stmnt)
                    return s
                }
                sqlite3_finalize(stmnt)
                sqlite3_close(stmnt)
            }
        }
        return ""
    }

    func selectMaxId() -> String
    {
        
        //var status=false
        var path=NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let str=path[0]
        strpath=str.appending("/mydb.db")
        
        
        var stmnt:OpaquePointer?=nil
        if sqlite3_open(strpath, &stmnt) == SQLITE_OK
        {
            if sqlite3_prepare_v2(stmnt, "SELECT MAX(id) FROM all_bookings", -1, &stmnt, nil) == SQLITE_OK
            {
                while sqlite3_step(stmnt) == SQLITE_ROW
                {
                    let sid=String(cString:sqlite3_column_text(stmnt, 0))
                    var x = Int(sid)
                    x=x!+1
                    var s = ""
                    s=String(format: "%d", x!)
                    sqlite3_finalize(stmnt)
                    sqlite3_close(stmnt)
                    return s
                }
                sqlite3_finalize(stmnt)
                sqlite3_close(stmnt)
            }
        }
        return ""
    }
    
    
    func selectMaxRateId() -> String
    {
        
        //var status=false
        var path=NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let str=path[0]
        strpath=str.appending("/mydb.db")
        
        
        var stmnt:OpaquePointer?=nil
        if sqlite3_open(strpath, &stmnt) == SQLITE_OK
        {
            if sqlite3_prepare_v2(stmnt, "SELECT MAX(id) FROM ratings", -1, &stmnt, nil) == SQLITE_OK
            {
                while sqlite3_step(stmnt) == SQLITE_ROW
                {
                    let sid=String(cString:sqlite3_column_text(stmnt, 0))
                    var x = Int(sid)
                    x=x!+1
                    var s = ""
                    s=String(format: "%d", x!)
                    sqlite3_finalize(stmnt)
                    sqlite3_close(stmnt)
                    return s
                }
                sqlite3_finalize(stmnt)
                sqlite3_close(stmnt)
            }
        }
        return ""
    }
    
    
    func reviewData(query:String) -> NSMutableArray
    {
        let dict=NSMutableDictionary()
        let data=NSMutableArray()
        
        //var status=false
        var path=NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let str=path[0]
        strpath=str.appending("/mydb.db")
        
        print(query)
        
        var stmnt:OpaquePointer?=nil
        if sqlite3_open(strpath, &stmnt) == SQLITE_OK
        {
            if sqlite3_prepare_v2(stmnt, query, -1, &stmnt, nil) == SQLITE_OK
            {
                while sqlite3_step(stmnt) == SQLITE_ROW
                {
                    dict.setValue(String(cString:sqlite3_column_text(stmnt, 0)), forKey: "id")
                    dict.setValue(String(cString:sqlite3_column_text(stmnt, 2)), forKey: "restro_id")
                    dict.setValue(String(cString:sqlite3_column_text(stmnt, 1)), forKey: "user_id")
                    dict.setValue(String(cString:sqlite3_column_text(stmnt, 3)), forKey: "rate")
                    dict.setValue(String(cString:sqlite3_column_text(stmnt, 4)), forKey: "review")
                    
                    data.add(dict.copy())
                }
                sqlite3_finalize(stmnt)
                sqlite3_close(stmnt)
            }
        }
        return data
    }
    
    
    func reviewAvg(query:String) -> String
    {
        var path=NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let str=path[0]
        strpath=str.appending("/mydb.db")
        
        var sum:Float = 0
        var c:Float = 0
        var stmnt:OpaquePointer?=nil
        if sqlite3_open(strpath, &stmnt) == SQLITE_OK
        {
            if sqlite3_prepare_v2(stmnt, query, -1, &stmnt, nil) == SQLITE_OK
            {
                while sqlite3_step(stmnt) == SQLITE_ROW
                {
                    let u = Float(String(cString:sqlite3_column_text(stmnt, 3)))
                    sum = sum + u!
                    c = c + 1
                }
                sqlite3_finalize(stmnt)
                sqlite3_close(stmnt)
            }
        }
        if c==0{
            return "-"
            
        }
        var f:Float = 0
        f = sum/c
        print(f)
        let q = String(format: "%.1f/5", f)
        return q
    }
}
