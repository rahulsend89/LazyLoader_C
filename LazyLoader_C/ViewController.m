//
//  ViewController.m
//  LazyLoader_C
//
//  Created by Malik, Rahul (US - Mumbai) on 5/21/15.
//  Copyright (c) 2015 Malik, Rahul (US - Mumbai). All rights reserved.
//

#import "ViewController.h"
#import "LazyLoaderLayer.h"
#define DURATION 2.0
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *loaderView;
@property (nonatomic)LazyLoaderLayer *myLoader;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myLoader = [LazyLoaderLayer layer];
    [self.myLoader initVariablesWithFrame:self.loaderView.frame];
    [self.loaderView.layer addSublayer:self.myLoader];
    [self startAnimationWithAngle:@"endAngle"];
    [self addRotation];
}
-(void)addRotation{
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: 360.0f*M_PI/180];
    rotationAnimation.duration = DURATION;
    rotationAnimation.repeatCount = HUGE_VAL;
    [self.myLoader addAnimation:rotationAnimation forKey:@"rotation"];
}
-(void)startAnimationWithAngle:(NSString*)key{
    BOOL endPoint = ([[[self.myLoader modelLayer] valueForKey:key] floatValue]>0);
    NSNumber *toValue = [NSNumber numberWithFloat:endPoint?0.0f:360.0f];
    
    CABasicAnimation* arcAnimation;
    arcAnimation = [CABasicAnimation animationWithKeyPath:key];
    arcAnimation.toValue = toValue;
    arcAnimation.duration = DURATION;
    arcAnimation.cumulative = YES;
    arcAnimation.repeatCount = 1;
    arcAnimation.timingFunction = [CAMediaTimingFunction functionWithName:endPoint?kCAMediaTimingFunctionEaseOut:kCAMediaTimingFunctionEaseOut];
    arcAnimation.delegate = self;
    [self.myLoader addAnimation:arcAnimation forKey:key];
}
- (void)animationDidStop:(CAPropertyAnimation *)anim finished:(BOOL)flag{
    [self startAnimationWithAngle:([[anim keyPath] isEqualToString:@"endAngle"])?@"startAngle":@"endAngle"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
