//
//  HHWaveView.m
//  HHWaveView
//
//  Created by 倪辉辉 on 16/8/16.
//  Copyright © 2016年 倪辉辉. All rights reserved.
//

#import "HHWaveView.h"

@interface HHWaveView ()
{
    CGFloat _offsetX;
    CAShapeLayer *_waveShapeLayer;
    CADisplayLink *_waveDisplayLink;
}
@end

@implementation HHWaveView

- (instancetype)initWithFrame:(CGRect)frame{
    HHWaveView *view;
    view = [super initWithFrame:frame];
    if (view) {
        [self config];
        return view;
    }else
        return nil;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    HHWaveView *view;
    view = [super initWithCoder:aDecoder];
    if (view) {
        [self config];
        return view;
    }else
        return nil;
}

- (void)setWaveSpeed:(CGFloat)waveSpeed{
    _waveSpeed = waveSpeed;
}
- (void)setWaveInColor:(UIColor *)waveInColor{
    _waveInColor = waveInColor;
    if (_waveShapeLayer) {
        _waveShapeLayer.fillColor = _waveInColor.CGColor;
    }
}
- (void)setWaveLineColor:(UIColor *)waveLineColor{
    _waveLineColor = waveLineColor;
    if (_waveShapeLayer) {
        _waveShapeLayer.strokeColor = _waveLineColor.CGColor;
    }
}
- (void)setRunTime:(CGFloat)runTime{
    _runTime = runTime;
}

- (void)config{
    if (!_waveSpeed) {
        _waveSpeed = 2.f;
    }
    if (!_angularSpeed) {
        _angularSpeed = 2.f;
    }
    if (!_runTime) {
        _runTime = 10.f;
    }
    if (!_waveInColor) {
        _waveInColor = [UIColor yellowColor];
    }
    if (!_waveLineColor) {
        _waveLineColor = [UIColor blackColor];
    }
//    [self start];
    
}
- (void)start{
    
    if (!_waveShapeLayer) {
        _waveShapeLayer = [CAShapeLayer layer];
        _waveShapeLayer.fillColor = _waveInColor.CGColor;
        _waveShapeLayer.strokeColor = _waveLineColor.CGColor;
        [self.layer addSublayer:_waveShapeLayer];
    }
    
    if (!_waveDisplayLink) {
        _waveDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(currentWave)];
        [_waveDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    
    if (_runTime > 0.f) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_runTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self stop];
        });
    }

}
- (void)currentWave{
    _offsetX -= _waveSpeed;
    
    CGFloat height = CGRectGetHeight(self.frame);
    CGFloat width = CGRectGetWidth(self.frame);
    
    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathMoveToPoint(path, NULL, 0, height / 2);
    CGPathMoveToPoint(path, NULL, 0, 0);

    CGFloat y = 0.f;
    for (CGFloat x = 0.f; x <= CGRectGetWidth(self.frame) ; x++) {
        y = height/2 * sin(0.01 * _angularSpeed * x + _offsetX * 0.08) + height/2;
        CGPathAddLineToPoint(path, NULL, x, y);
    }
//    CGPathAddLineToPoint(path, NULL, width, height);
//    CGPathAddLineToPoint(path, NULL, 0, height);
    CGPathAddLineToPoint(path, NULL, width, 0);
    CGPathAddLineToPoint(path, NULL, 0, 0);
    CGPathCloseSubpath(path);

    _waveShapeLayer.path = path;
    CGPathRelease(path);
}

- (void)stop{
    [UIView animateWithDuration:1.f animations:^{
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        [_waveDisplayLink invalidate];
        _waveDisplayLink = nil;
        _waveShapeLayer.path = nil;
        self.alpha = 1.f;
    }];

}

@end
