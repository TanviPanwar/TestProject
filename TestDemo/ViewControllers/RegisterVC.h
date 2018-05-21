//
//  RegisterVC.h
//  TestDemo
//
//  Created by AAYUSHI on 21/05/18.
//  Copyright © 2018 Tanvi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFHTTPSessionManager.h>
#import "MBProgressHUD.h"
@interface RegisterVC : UIViewController<UITextFieldDelegate>
{
    AFHTTPSessionManager *manager;
    NSDictionary *params,*data_dict;
    NSString *message,*device_id,*str_status,*user_id;
}

@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

@end
