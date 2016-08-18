//
//  ScanQRViewController.m
//  Eateraction
//
//  Created by canduo on 24/6/2015.
//  Copyright (c) 2015年 zxd. All rights reserved.
//

#import "ScanQRViewController.h"
#import <AVFoundation/AVFoundation.h>

#define IOS8Later ([[[UIDevice currentDevice] systemVersion] doubleValue]>=8.0)

@interface ScanQRViewController ()<AVCaptureMetadataOutputObjectsDelegate>

@property(strong, nonatomic) AVCaptureSession *session;
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (strong, nonatomic) UIImageView *line;

@end

@implementation ScanQRViewController

#pragma mark -LifeCycle


-(void)dealloc{
    [self.line.layer removeAllAnimations];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self scrollLine];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unauthorized camera connection, please change your setting"
                                                        message:@"Please go to  Settings>Privacy>Camera>Eateraction open the permission"
                                                       delegate:self
                                              cancelButtonTitle:IOS8Later?@"Cancel":@"OK" otherButtonTitles:IOS8Later?@"Setting":nil,nil];
        
        [alert show];
    }else{
        if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            //[clsOtherFun showAlertMessage:@"Camera invalid!"];
            return;
        }
        
        CGRect rect=[UIScreen mainScreen].bounds;
        self.line=[[UIImageView alloc] initWithFrame:CGRectMake(-5, 0, self.topImageView.bounds.size.width+10, 5)];
        self.line.image=[UIImage imageNamed:@"scan_line.png"];
        [self.topImageView addSubview:self.line];
        self.line.autoresizingMask=UIViewAutoresizingFlexibleWidth;
        
        AVCaptureDevice *device=[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        AVCaptureDeviceInput *input=[AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
        AVCaptureMetadataOutput * ouput=[[AVCaptureMetadataOutput alloc] init];
        dispatch_queue_t dispatchQueue;
        dispatchQueue = dispatch_queue_create("myQueue", NULL);
        [ouput setMetadataObjectsDelegate:self queue:dispatchQueue];
        [ ouput setRectOfInterest : CGRectMake (((rect.size.height - 240 )/ 2)/ rect.size.height ,(( rect.size.width - 240 )/ 2 )/ rect.size.width , 240 / rect.size.height , 240 / rect.size.width )];
        self.session=[[AVCaptureSession alloc] init];
        [self.session setSessionPreset:AVCaptureSessionPresetHigh];
        [self.session addInput:input];
        [self.session addOutput:ouput];
        ouput.metadataObjectTypes=@[AVMetadataObjectTypeQRCode];
        AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
        layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
        layer.frame=rect;
        [self.view.layer insertSublayer:layer atIndex:0];
        [self.session startRunning];

    }

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -EventResponse
-(void) TabBarItemClickCahnge:(NSNotification *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -PrivateMethods

-(void)scrollLine{
    [self.line.layer removeAllAnimations];
    [self.line.layer addAnimation:[self moveY:self.line.frame.origin.y toY:self.topImageView.bounds.size.height-7 duration:2.0] forKey:@"move"];
}

-(CABasicAnimation *)moveY:(CGFloat)y toY:(CGFloat)toy duration:(CGFloat)time
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    animation.fromValue=[NSNumber numberWithFloat:y];
    animation.toValue = [NSNumber numberWithFloat:toy];
    animation.duration = time;
    animation.repeatCount =HUGE_VALF;
    animation.autoreverses = YES;
    return animation;
}


#pragma mark -ZBarReaderViewDelegate
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count>0) {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
        NSString *qrcode=metadataObject.stringValue;
        NSLog(@"%@",qrcode);

        [self dismissViewControllerAnimated:YES completion:^{
            NSLog(@"Dismiss");
            if (self.compite) {
                self.compite(qrcode);
            }
        }];
        [self.session stopRunning];

    }
}

#pragma mark -UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1){
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]){
            [[UIApplication sharedApplication] openURL:url];
        }
    }
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
