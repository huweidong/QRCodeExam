//
//  ScanQRViewController.h
//  Eateraction
//
//  Created by canduo on 24/6/2015.
//  Copyright (c) 2015年 zxd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ScanQRCallBack)(NSString *code);

@interface ScanQRViewController : UIViewController

@property (copy, nonatomic) NSString * cardType;
@property (copy, nonatomic) NSString * cardImage;
@property (copy, nonatomic) NSString * cardBalance;

@property (copy, nonatomic) ScanQRCallBack compite;

@end
