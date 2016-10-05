//
//  TGLViewController.m
//  TimesheetPlus
//
//  Created by Deepthi Kaligi on 25/06/2016.
//  Copyright © 2016 Banana Apps. All rights reserved.
//

#import "TGLViewController.h"

@interface TGLViewController ()

@end

@implementation TGLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat hue = ( arc4random() % 256 / 256.0 );
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
    self.view.backgroundColor = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
