//
//  QRCodeViewController.m
//  KOC
//
//  Created by canduo on 15/1/2016.
//  Copyright © 2016年 zxd. All rights reserved.
//

#import "QRCodeViewController.h"
#import "UIImage+MDQRCode.h"
#import "ScanQRViewController.h"

@interface QRCodeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *qrCodeImageView;

@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.qrCodeImageView.image = [UIImage mdQRCodeForString:@"1231111" size:self.qrCodeImageView.bounds.size.width fillColor:[UIColor blackColor]];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backAction:(id)sender {
    
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
