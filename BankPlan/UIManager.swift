//
//  UIManager.swift
//  ClubTaola
//
//  Created by Younghu min on 2022/04/07.
//

import UIKit

class UIManager: NSObject, UIAdaptivePresentationControllerDelegate {
    var window: UIWindow?
    var myApplication: UIApplication?
    
    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    /// singleton
    static let shared: UIManager = {
        let instance = UIManager()
         
        return instance
    }()
}


extension UIManager {
    public func viewChangeEvent(_ eventKey: ChangeEvent, _ data: Any?) {
        
        //<< default portrait >>
        
        
        switch eventKey {
        case .none:
            break
       
        case .RegisterUserVC:
           
             
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegisterUserVC") as? RegisterUserVC {
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, data, true)
                            }
                        }
            
            
            
            break
        case .RegisterVC:
           
             
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegisterVC") as? RegisterVC {
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, data, true)
                            }
                        }
            
            
            
            break
            
        case .MainVC:
           
             
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainVC") as? MainVC {
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, data, true)
                            }
                        }
            
            
            
            break
        case .PinMoneyVC:
           
             
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PinMoneyVC") as? PinMoneyVC {
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, data, true)
                            }
                        }
            
            
            
            break
            
        case .DividendsCalendarVC:
           
             
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DividendsCalendarVC") as? DividendsCalendarVC {
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, data, true)
                            }
                        }
            
            
            
            break
            
        case .ClosedDays:
           
             
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ClosedDays") as? ClosedDays {
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, data, true)
                            }
                        }
            
            
            
            break
            
        case .NotificationVC:
           
             
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotificationVC") as? NotificationVC {
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, data, true)
                            }
                        }
            
            
            
            break
            
        case .ExchangeRateVC:
           
             
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ExchangeRateVC") as? ExchangeRateVC {
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, data, true)
                            }
                        }
            
            
            
            break
            
        default:
            break
        }
    }
    
    
    /// 현재탭바 컨트롤러
    /// - Returns: BaseViewController
    
    
    /// keyWindow의 최상위 뷰 컨트롤러를 구한다.
    /// - Returns: 최상위 VC 리턴 optional
    public func topViewController() -> UIViewController? {
        if let keywindow = myApplication?.keyWindow {
            if var viewController = keywindow.rootViewController {
                while viewController.presentedViewController != nil {
                    viewController = viewController.presentedViewController!
                }
                
                if viewController.isKind(of: UINavigationController.self) {
                    let vc = (viewController as? UINavigationController)?.viewControllers.last
                    //dprint("topViewController is NavigationController of last -> \(String(describing: vc))")
                    return vc
                }
                //dprint("topViewController -> \(viewController)")
                return viewController
                
            }
        }
        return nil
    }
    
    /// navigation push
    /// - Parameters:
    ///   - viewController: 이동할 VC
    ///   - data: 전달할 데이터
    ///   - animated: 애니메이션 여부
    public func pushViewController(_ viewController : UIViewController?, _ data: Any?, _ animated: Bool) {
        //data전달
        DispatchQueue.main.async {
            
            
            
            
            
        }
        
    }
    
    /// pop single
    /// - Parameters:
    ///   - data: 전달할 데이터
    ///   - animated: 애니메이션 여부 기본값 true
    public func popViewController(_ data: Any?, _ animated: Bool = true) {
        //이전 ViewController 에게 data를 넘기기 위함.
        
        
    }
    
    //popToRoot
    public func popToRootViewController(_ data: Any?, _ animated:Bool = true) {
        //        if self.mainNavigationController == nil {
        //            dprint("> mainNavigationController is nil")
        //            return
        //        }
        //
        //        if let topViewController = self.mainNavigationController?.viewControllers.first as? BaseViewController {
        //            topViewController.setEventData(data)
        //        }
        //
        //        mainNavigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        //        mainNavigationController?.popToRootViewController(animated: animated)
    }
    
    /// 모달뷰컨트롤러 With Data Open
    /// - Parameters:
    ///   - controlller: present 할 VC
    ///   - data: 전달할 데이터
    ///   - animated: 애니메이션 여부
    public func present(_ modalViewController: UIViewController, _ data: Any?, _ animated: Bool) {
        
        let viewController =  UIApplication.topViewController() //self.getTopController()
        
        viewController!.present(modalViewController, animated: animated) {
            
        }
        
        /// 모달뷰컨트롤러 with Close
        /// - Parameters:
        ///   - controller: dismiss 할 VC
        ///   - data: 전달할 데이터
        ///   - animated: 애니메이션 여부
      
        
        
        
    }
    public   func dismiss(_ controller: Any?, _ data: Any?, _ animated: Bool) {
        
             if let vc = controller as? UIViewController {
                    vc.dismiss(animated: animated) {
                    }
                }
    }
    
    /// 화면전환을 위한 이벤트
    public enum ChangeEvent: Int {
        ///화면전환 없음
        case none
        
        ///앱 실행시 모드 선택(개발, 스테이징, 운영 ... )
        case RegisterUserVC
        
        case RegisterSuccess
        
        case RegisterVC
       
        case MainVC
        
        case PinMoneyVC
        
        case DividendsCalendarVC
        
        case ClosedDays
        
        case NotificationVC
        
        case ExchangeRateVC
    }
}
