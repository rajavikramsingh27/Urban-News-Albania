//  Setting_ViewController.swift
//  Urban News Albania
//  Created by iOS-Appentus on 30/January/2020.
//  Copyright © 2020 appentus. All rights reserved.


import UIKit


class Setting_ViewController: UIViewController {
    
    @IBOutlet weak var switch_All:UISwitch!
    @IBOutlet weak var switch_GoogleAds:UISwitch!
    @IBOutlet weak var switch_FacebookAds:UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        switch_All.isOn = arr_ads_off[0]
        switch_GoogleAds.isOn = arr_ads_off[1]
        switch_FacebookAds.isOn = arr_ads_off[2]
    }
    
    
    @IBAction func btn_back(_ sender:UIButton)  {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func switch_All(_ sender:UISwitch) {
        switch_All.isOn = !switch_All.isOn
        
        if switch_All.isOn {
            switch_All.isOn = false
            switch_GoogleAds.isOn = false
            switch_FacebookAds.isOn = false
            
            switch_GoogleAds.isUserInteractionEnabled = false
            switch_FacebookAds.isUserInteractionEnabled = false
            
            is_all = false
            is_facebookAds = false
            is_googleAds = false
            
            arr_ads_off = [false,false,false]
        } else {
            switch_All.isOn = true
            
            switch_GoogleAds.isUserInteractionEnabled = true
            switch_FacebookAds.isUserInteractionEnabled = true
            
            is_all = true
            arr_ads_off = [true,false,false]
        }
        
    }
    
    @IBAction func switch_GoogleAds(_ sender:UISwitch) {
        switch_GoogleAds.isOn = true
        switch_FacebookAds.isOn = false
        
        is_googleAds = true
        is_all = true
        arr_ads_off = [true,true,false]
    }
    
    @IBAction func switch_FacebookAds(_ sender:UISwitch) {
        switch_GoogleAds.isOn = false
        switch_FacebookAds.isOn = true
        
        is_facebookAds = true
        
        is_all = true
        arr_ads_off = [true,false,true]
    }
    
}
