//
//  checkQRCodeVC.m
//  QRCodeExam
//
//  Created by huweidong on 2/2/16.
//  Copyright © 2016年 huweidong. All rights reserved.
//

#import "checkQRCodeVC.h"
#import "ScanQRViewController.h"

@interface checkQRCodeVC ()

@end

@implementation checkQRCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnQRCodeClick:(id)sender {
    ScanQRViewController *vc=[[ScanQRViewController alloc] initWithNibName:@"ScanQRViewController" bundle:nil];
    vc.compite=^(NSString *code){
        
    };
    UINavigationController * nav=[[UINavigationController alloc] initWithRootViewController:vc];
    nav.navigationBarHidden=YES;
    [self presentViewController:nav animated:YES completion:nil];
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
