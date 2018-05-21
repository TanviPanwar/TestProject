//
//  HomeVC.m
//  TestDemo
//
//  Created by AAYUSHI on 21/05/18.
//  Copyright © 2018 Tanvi. All rights reserved.
//

#import "HomeVC.h"
#import "HomeCell.h"
@interface HomeVC ()

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self api_call];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark API Call

-(void)api_call
{
    
    manager = [AFHTTPSessionManager manager];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer
                                                    serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    manager.responseSerializer = responseSerializer;
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager GET:@"https://reqres.in/api/users?page=2" parameters:params progress:nil
          success:^(NSURLSessionTask *task, id responseObject) {
              
              arr = [responseObject valueForKey:@"data"];
              
              [_tblView reloadData];
          }
          failure:^(NSURLSessionTask *operation, NSError *error) {
              NSLog(@"%@",error.description);
          }];
}

#pragma mark Table view

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"TableItem";
    
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[HomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    NSDictionary * dict = [arr objectAtIndex:indexPath.row];
    NSString * firstname = [dict valueForKey:@"first_name"];
    NSString * lastname = [dict valueForKey:@"last_name"];
    
    cell.CellLbl.text = [NSString stringWithFormat:@"%@ %@",firstname,lastname];
    
    NSString *filePath = [NSString stringWithFormat:@"%@",[dict valueForKey:@"avatar"]];
    
    
 if (filePath.length == 0)
 {
     
 }
 else
 {
    cell.CellImage.image = [UIImage imageWithData: [NSData dataWithContentsOfURL:[NSURL URLWithString:filePath]]];
     cell.CellImage.layer.cornerRadius  =  cell.CellImage.frame.size.width/2;
     [ cell.CellImage.layer setMasksToBounds:YES];
     
 }
    
    return cell;
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
