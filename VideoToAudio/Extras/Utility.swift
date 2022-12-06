//
//  Utility.swift
//  Faces Gallery
//
//  Created by HaiDer's Macbook Pro on 18/12/2021.
//

import Foundation
import UIKit
import SystemConfiguration

var kApplicationWindow = Utility.getAppDelegate()!.window


@objc class Utility: NSObject {
    
    var window: UIWindow?
    
    struct ScreenSize
    {
        static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
        static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
        static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    }
    class func getAppDelegate() -> AppDelegate? {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        return appDelegate
    }
    
    class func removeHairLineFromNavBar(navController: UINavigationController?) {
        navController?.navigationBar.shadowImage = UIImage()
    }

    class func DictToJsonString(_ dict : [String : Any]) -> String?
    {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: []) else {return nil}
        let decoded = String(data: jsonData, encoding: .utf8)!
        return decoded
    }
    class func isTextFieldHasText(textField: UITextField) -> Bool {
        if textField.hasText
        {
            return !isBlankString(text: textField.text!)
        }
        return false
    }
    class func isBlankString(text: String) -> Bool {
        let trimmed = text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return trimmed.isEmpty
    }
    class func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    class func setPlaceHolderTextColor (_ textField: UITextField, _ text: String, _ color: UIColor) {
        textField.attributedPlaceholder = NSAttributedString(string: text,
        attributes: [NSAttributedString.Key.foregroundColor: color])
    }
    
    class func cornerRadiusPostioned (corners: CACornerMask, view: UIView, cornerRadius: CGFloat) {
        view.layer.cornerRadius = cornerRadius
        view.layer.maskedCorners = corners
        view.clipsToBounds = true
        view.layoutIfNeeded()
    }
    
    class func changeFontSizeRange (mainString: String, stringToChange: String) ->  NSMutableAttributedString {
        let font = UIFont.systemFont(ofSize: 11)
        let range = (mainString as NSString).range(of: stringToChange)
        
        let attribute = NSMutableAttributedString.init(string: mainString)
        attribute.addAttribute(NSAttributedString.Key.font, value: font , range: range)
        return attribute
    }
    
    class func changeFontStyleToBold (mainString: String, stringToChange: String) ->  NSMutableAttributedString {
        let font = UIFont(name: "SFProText-Bold", size: 15)!
        let range = (mainString as NSString).range(of: stringToChange)
        
        let attribute = NSMutableAttributedString.init(string: mainString)
        attribute.addAttribute(NSAttributedString.Key.font, value: font , range: range)
        return attribute
    }
    
    class func addTextFieldLeftViewImage(_ textField: UITextField, image: UIImage, width: Int, height: Int, leftPadding: Int, topPadding: Int) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: width + leftPadding + 5, height: height + topPadding))
        let imageView = UIImageView(frame: CGRect(x: leftPadding, y: topPadding, width: width, height: height))
        imageView.image = image
        view.addSubview(imageView)
        
        textField.leftViewMode = .always
        textField.leftView = view
    }
    
    class  func isValidEmail(emailStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }
    
    static func isValidPhoneNumber(_ testStr:String) -> Bool {
        let emailRegEx = "^(\\d){10}$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    class func getScreenHeight() -> CGFloat {
        return UIScreen.main.bounds.height
    }
    
    class func getScreenWidth() -> CGFloat {
        return UIScreen.main.bounds.width
    }
    
    class func showAlertController (_ controller: UIViewController,_ message: String) {
        let easyVC = UIAlertController(title: "", message: message, preferredStyle: .alert)
        easyVC.modalPresentationStyle = .overCurrentContext
        easyVC.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        controller.present(easyVC, animated: true, completion: nil)
    }
    
    class func hasTopNotch() -> Bool {
        
        if #available(iOS 11.0, tvOS 11.0, *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        
        return false
    }
    
    class func makeBlurImage(targetImageView:UIImageView?, alpha: CGFloat = 1) {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = targetImageView!.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        blurEffectView.alpha = alpha
        targetImageView?.addSubview(blurEffectView)
    }
    
    class func removeBlurFromImage(targetImageView: UIImageView?) {
        
        let blurViews = targetImageView?.subviews.filter({ (view) -> Bool in
            view.isKind(of: UIVisualEffectView.self)
        })
        
        blurViews?.forEach({ (view) in
            view.removeFromSuperview()
        })
    }

    
    class func simpleDate (date : Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
    
    
    class func changeDateFormate (dataInString : String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let localDate = dateFormatter.date(from: dataInString)
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "MMM dd, yyyy"
        if localDate != nil {
            return dateFormatter.string(from: localDate!)
            
        } else {
            return ""
        }
    }
    
    class func dataInEnglish (_ dataInString : String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        let localDate = dateFormatter.date(from: dataInString)
        
        let calendar = Calendar.current
        
        if localDate != nil {
            
            if calendar.isDateInYesterday(localDate!) {
                return "Yesterday"
            } else if calendar.isDateInToday(localDate!) {
                return "Today"
            } else {
                dateFormatter.dateStyle = .medium
                dateFormatter.timeStyle = .none
                dateFormatter.dateFormat = "MMM dd, yyyy"
                if localDate != nil {
                    return dateFormatter.string(from: localDate!)
                    
                } else {
                    return ""
                }
            }
        }
        return ""
    }
    
    
    class func getCurrentFormattedDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: date)
    }
    // Give next date by adding days to current date
    class func getNextDate(byAddingDays: Int, to date: Date) -> Date{
        var givenDate = date
        givenDate = givenDate.addingTimeInterval(TimeInterval(TimeZone.current.secondsFromGMT()))
        
        var dateComponent = DateComponents()
        dateComponent.day = byAddingDays
        dateComponent.timeZone = TimeZone.current
        
        let calendar = Calendar.current
        guard let date = calendar.date(byAdding: dateComponent, to: givenDate) else {
            fatalError("\(#function): Error in creating Date by Adding Components")
        }
        return date
    }
    
    // This method returns future date in "dd-MM-yyyy" format
    class func getNextFormattedDate(byAddingDays: Int, to date: Date) -> String {
        let date = getNextDate(byAddingDays: byAddingDays, to: date)
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: date)
    }
    
    class func getFormattedDateStringForFormat(format: String, date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    class func convertToBlackNWhite(image: UIImage) -> UIImage {
        
        // Create image rectangle with current image width/height
        let imageRect:CGRect = CGRect(x:0, y:0, width:image.size.width, height: image.size.height)

        // Grayscale color space
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let width = image.size.width
        let height = image.size.height

        // Create bitmap content with current image size and grayscale colorspace
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)

        // Draw image into current context, with specified rectangle
        // using previously defined context (with grayscale colorspace)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        context?.draw(image.cgImage!, in: imageRect)
        let imageRef = context!.makeImage()

        // Create a new UIImage object
        let newImage = UIImage(cgImage: imageRef!)

        return newImage
    }
}

extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
}
