//
//  HHWaveView.h
//  HHWaveView
//
//  Created by 倪辉辉 on 16/8/16.
//  Copyright © 2016年 倪辉辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHWaveView : UIView
@property (nonatomic,strong)UIColor *waveInColor;
@property (nonatomic,strong)UIColor *waveLineColor;
@property (nonatomic,assign)CGFloat waveSpeed;
@property (nonatomic,assign)CGFloat angularSpeed;
@property (nonatomic,assign)CGFloat runTime;//运行时间

- (instancetype)initWithFrame:(CGRect)frame;
- (void)start;
@end
