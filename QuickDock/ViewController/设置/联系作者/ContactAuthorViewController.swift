//
//  ContactAuthorViewController.swift
//  QuickDock
//
//  Created by LTXX on 2019/4/25.
//  Copyright © 2019 LTXX. All rights reserved.
//

import UIKit
import MessageUI//邮件撰写视图控制器包含在该框架中，提供用于发送电子邮件和文本消息的界面

class ContactAuthorViewController: UIViewController, MFMailComposeViewControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - 邮件内容需要自定义
    @IBAction func sendEmailButtonTapped(_ sender: Any) {
        //判断用户的设备能否发送邮件
        guard MFMailComposeViewController.canSendMail() else {
            print("此设备无法发送邮件")
            return
        }
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        mailComposer.setToRecipients(["example@example.com"])//设置默认收件地址
        mailComposer.setSubject("Example Subject")//设置默认主题
        mailComposer.setMessageBody("Say something", isHTML: false)//设置默认文本
        present(mailComposer, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        //关闭邮件撰写视图控制器，然后返回到App
        dismiss(animated: true, completion: nil)
    }
    
}
