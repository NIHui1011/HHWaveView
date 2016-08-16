//
//  ViewController.m
//  HHWaveView
//
//  Created by 倪辉辉 on 16/8/16.
//  Copyright © 2016年 倪辉辉. All rights reserved.
//

#import "ViewController.h"
#import "HHWaveView.h"
@interface ViewController ()
{
    HHWaveView *_wave;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     _wave = [[HHWaveView alloc] initWithFrame:CGRectMake(0, 100, [[UIScreen mainScreen] bounds].size.width, 40)];
    _wave.waveLineColor = [UIColor yellowColor];
    _wave.runTime = 2;
    _wave.backgroundColor = [UIColor redColor];
    [self.view addSubview:_wave];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)startBtnClick:(UIButton *)sender {
    if (_wave) {
        [_wave start];
    }
}

@end
