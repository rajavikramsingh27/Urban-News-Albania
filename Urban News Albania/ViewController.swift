//  ViewController.swift
//  Urban News Albania
//  Created by iOS-Appentus on 29/December/2019.
//  Copyright © 2019 appentus. All rights reserved.



//  App ID: ca-app-pub-9980479003859465~5254067542
//  banner ID :- ca-app-pub-9980479003859465/9584388318



import UIKit
import MBProgressHUD
import AdSupport
import GoogleMobileAds
import FBAudienceNetwork

//import SVProgressHUD

var is_all = false
var is_googleAds = false
var is_facebookAds = false

var arr_ads_off = [true,false,true]

class ViewController: UIViewController,UIWebViewDelegate {
    @IBOutlet weak var webview:UIWebView!
    @IBOutlet weak var splash_screen:UIView!
    
    @IBOutlet weak var view_show_ads:UIView!
    
    var gad_bannerView: GADBannerView!
    var fb_bannerAdView: FBAdView!
    
    @IBOutlet weak var height_bannerView:NSLayoutConstraint!
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(ASIdentifierManager.shared().advertisingIdentifier.uuidString)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+10) {
            self.splash_screen.isHidden = true
        }
        
        let url_request = URLRequest (url: URL (string: "https://urbannews.al/?fbclid=IwAR1_0EgQf81ZP6sr3UKZjIjy4RKXLyql-zvhwP5C61hhhPzFUxG-qJWoMfg")!)
        webview.loadRequest(url_request)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        height_bannerView.constant = 0
        
        is_all = arr_ads_off[0]
        is_googleAds = arr_ads_off[1]
        is_facebookAds = arr_ads_off[2]

        if is_all {
            if is_facebookAds {
                load_FB_BannerAd()
            } else if is_googleAds {
                func_gad_bannerView()
            }
        } else {
            
        }
    }
    
    @IBAction func btn_setting(_ sender:UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier:"Setting_ViewController") as! Setting_ViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
//        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        splash_screen.isHidden = true
//        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    /// Tells the delegate an ad request loaded an ad.
//    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
//      print("adViewDidReceiveAd")
//    }
    
}

extension ViewController:GADBannerViewDelegate {
        func func_gad_bannerView() {
//            gad_bannerView.frame = view_show_ads.frame
//            view_show_ads.addSubview(gad_bannerView)
//            gad_bannerView.adUnitID = "ca-app-pub-9980479003859465/9584388318"
//            gad_bannerView.rootViewController = self
//            gad_bannerView.delegate = self
//
//        //                let request =  GADRequest()
//        //                request.testDevices = [UIDevice.current.identifierForVendor!.uuidString]
//        //                gad_bannerView.load(request)
//            gad_bannerView.load(GADRequest())
            
            
            
            gad_bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
            gad_bannerView.adUnitID = "ca-app-pub-9980479003859465/9584388318"
            gad_bannerView.delegate = self
            gad_bannerView.rootViewController = self
            gad_bannerView.load(GADRequest())
        }
    
        /// Tells the delegate an ad request failed.
        func adView(_ bannerView: GADBannerView,
            didFailToReceiveAdWithError error: GADRequestError) {
          print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
        }
        
        /// Tells the delegate that a full-screen view will be presented in response
        /// to the user clicking on an ad.
        func adViewWillPresentScreen(_ bannerView: GADBannerView) {
          print("adViewWillPresentScreen")
        }
        
        /// Tells the delegate that the full-screen view will be dismissed.
        func adViewWillDismissScreen(_ bannerView: GADBannerView) {
          print("adViewWillDismissScreen")
        }
        
        /// Tells the delegate that the full-screen view has been dismissed.
        func adViewDidDismissScreen(_ bannerView: GADBannerView) {
          print("adViewDidDismissScreen")
        }
        
        /// Tells the delegate that a user click will open another app (such as
        /// the App Store), backgrounding the current app.
        func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
          print("adViewWillLeaveApplication")
        }
        
        func adViewDidReceiveAd(_ bannerView: GADBannerView) {
          // Add banner to view and add constraints as above.
    //      addBannerViewToView(bannerView)
            height_bannerView.constant = 100
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }

}


extension ViewController:FBAdViewDelegate {
     func load_FB_BannerAd() {
        fb_bannerAdView = FBAdView(placementID: "163469191739164_163469981739085", adSize: kFBAdSizeHeight50Banner, rootViewController: self)
        fb_bannerAdView.frame = CGRect (x: 0, y: 0, width: UIScreen.main.bounds.width, height: view_show_ads.bounds.height)
        fb_bannerAdView.delegate = self
        view_show_ads.addSubview(fb_bannerAdView)
        
        fb_bannerAdView.loadAd()
    }
    
    func adViewDidLoad(_ adView: FBAdView) {
        height_bannerView.constant = 70
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func adView(_ adView: FBAdView, didFailWithError error: Error) {
        print(error)
    }
    
    func adViewDidClick(_ adView: FBAdView) {
        print("Did tap on ad view")
    }
        
}
