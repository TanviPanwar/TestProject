//
//  RegisterVC.m
//  TestDemo
//
//  Created by AAYUSHI on 21/05/18.
//  Copyright © 2018 Tanvi. All rights reserved.
//

#import "RegisterVC.h"
#import "ViewController.h"
#import "HomeVC.h"
@interface RegisterVC ()

@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)RegisterAction:(id)sender {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if ([self checkForProviderBlankFields]) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self api_call];
    }
    else {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
    
}

- (IBAction)LoginAction:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *myNewVC = (ViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    [self.navigationController pushViewController:myNewVC animated:YES];
    
}

#pragma mark API Call

-(void)api_call
{
    params = @{@"email":_txtEmail.text,@"password":_txtPassword.text};
    
    //   params = @{@"email": @"test@novuse.com",@"password": @"cityslicka"};
    
    manager = [AFHTTPSessionManager manager];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer
                                                    serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    manager.responseSerializer = responseSerializer;
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager POST:@"https://reqres.in/api/register" parameters:params progress:nil
          success:^(NSURLSessionTask *task, id responseObject) {
              str_status = [responseObject valueForKey:@"token"];
              
              if ([str_status isEqualToString: @"QpwL5tke4Pnpja7X"])
                  
              {
                  UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                  HomeVC *myNewVC = (HomeVC *)[storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
                  [self.navigationController pushViewController:myNewVC animated:YES];
                  
                  
              }
              else
              {
                  
                  [self showAlert:@"Invalid Credentials" title:@""];
                  
                  
              }
          }
          failure:^(NSURLSessionTask *operation, NSError *error) {
              NSLog(@"%@",error.description);
          }];
}

#pragma mark Check Methods
-(BOOL) checkForProviderBlankFields {
    
    if ([self.txtEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0) {
        
        [self showAlert:@"Please fill Email" title:@""];
        return NO;
    }
    else  if ([self.txtPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0) {
        
        [self showAlert:@"Please fill Password" title:@""];
        return NO;
    }
    
    else
        return YES;
}

#pragma mark - UIAlertView

-(void) showAlert:(NSString *) msg title:(NSString *) title{
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:msg
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Ok"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    //Handel your yes please button action here
                                    [alert dismissViewControllerAnimated:YES completion:nil];
                                    
                                }];
    [alert addAction:yesButton];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self presentViewController:alert animated:YES completion:nil];
}



#pragma mark TextField Delegates

-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    if (textField == self.txtEmail) {
        [textField resignFirstResponder];
        [self.txtPassword becomeFirstResponder];
    }
    
    else if (textField == self.txtPassword) {
        [textField resignFirstResponder];
        [self.view endEditing:YES];
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
    
    return YES;
}

#pragma mark - touchbegan
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
