//
//  JCPLoaderLayer.m
//  LazyLoader_C
//
//  Created by Malik, Rahul (US - Mumbai) on 5/21/15.
//  Copyright (c) 2015 Malik, Rahul (US - Mumbai). All rights reserved.
//

#import "JCPLoaderLayer.h"
CGFloat const spaceFromFrame = 0.1f;
#define DURATION 2.0
@interface JCPLoaderLayer()
@property (nonatomic)CGFloat startAngle;
@property (nonatomic)CGFloat endAngle;
@property (nonatomic)UIColor *fillColor;
@property (nonatomic)CGFloat radius;
@property (nonatomic)CGFloat maxFit;
@end

@implementation JCPLoaderLayer
@dynamic startAngle, endAngle;
@synthesize fillColor, strokeColor, strokeWidth;

- (void)startAnimationInFrame:(CGRect)frame{
    self.maxFit = (frame.size.width>frame.size.height)?frame.size.height:frame.size.width;
    CGFloat xpos = 0.0f;
    CGFloat ypos = 0.0f;
    self.strokeWidth = self.maxFit/10;
    CGFloat gap = (((self.strokeWidth/2)+spaceFromFrame)*1.5);
    self.radius = (self.maxFit/2)-gap;
    if (frame.size.width!=frame.size.height) {
        BOOL isHeight = (self.maxFit == frame.size.height)?YES:NO;
        if (isHeight) {
            xpos = (frame.size.width/2)-(self.maxFit/2);
        }else{
            ypos = (frame.size.height/2)-(self.maxFit/2);
        }
    }
    self.frame = CGRectMake(0, 0, self.maxFit, self.maxFit);
    [self defaultsValuesWithGrayDark];
    
    [self startAnimation];
}

- (id)initWithLayer:(id)layer {
    if (self = [super initWithLayer:layer]) {
        if ([layer isKindOfClass:[JCPLoaderLayer class]]) {
            JCPLoaderLayer *other = (JCPLoaderLayer *)layer;
            self.frame = other.frame;
            self.bounds = other.bounds;
            self.maxFit = other.maxFit;
            self.startAngle = other.startAngle;
            self.endAngle = other.endAngle;
            self.fillColor = other.fillColor;
            self.radius = other.radius;
            self.strokeColor = other.strokeColor;
            self.strokeWidth = other.strokeWidth;
        }
    }
    return self;
}
-(void)defaultsValuesWithGrayDark{
    self.fillColor = [UIColor clearColor];
    self.strokeColor = [UIColor darkGrayColor];
    self.startAngle = 0.0f;
    self.endAngle = 0.0f;
}
+ (BOOL)needsDisplayForKey:(NSString *)key {
    if ([key isEqualToString:@"startAngle"] || [key isEqualToString:@"endAngle"]) {
        return YES;
    }
    return [super needsDisplayForKey:key];
}
-(void)startAnimation{
    [self rotationAnimation];
    [self startAnimationWithAngle:@"endAngle"];
}

-(void)startAnimationWithAngle:(NSString*)key{
    CABasicAnimation* arcAnimation;
    arcAnimation = [CABasicAnimation animationWithKeyPath:key];
    arcAnimation.byValue = [NSNumber numberWithFloat:360.0f];
    arcAnimation.duration = DURATION/2;
    arcAnimation.cumulative = YES;
    arcAnimation.additive = YES;
    arcAnimation.repeatCount = 1;
    if([key isEqualToString:@"startAngle"]){
        arcAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    }
    if([key isEqualToString:@"endAngle"]){
        arcAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    }
    //arcAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.0:0:0.3:1.0];
    arcAnimation.delegate = self;
    [self addAnimation:arcAnimation forKey:key];
}
- (void)animationDidStop:(CAPropertyAnimation *)anim finished:(BOOL)flag{
    if (([[anim keyPath] isEqualToString:@"startAngle"])) {
        self.endAngle = 0.0;
        [self startAnimationWithAngle:@"endAngle"];
    }else if(([[anim keyPath] isEqualToString:@"endAngle"])){
        self.endAngle = 0.1f;
        [self startAnimationWithAngle:@"startAngle"];
    }else{
        [self rotationAnimation];
    }
}
-(void)rotationAnimation{
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.byValue = [NSNumber numberWithFloat: 360.0f*M_PI/180];
    rotationAnimation.duration = DURATION;
    rotationAnimation.repeatCount = 1;
    rotationAnimation.delegate = self;
    [self addAnimation:rotationAnimation forKey:@"transform.rotation.z"];
}

-(void)drawInContext:(CGContextRef)ctx {
    CGPoint center = CGPointMake(self.maxFit/2, self.maxFit/2);
    CGFloat radius = self.radius;
    CGContextBeginPath(ctx);
    CGContextAddArc(ctx, center.x, center.y, radius, self.startAngle*M_PI/180, self.endAngle*M_PI/180, YES);
    CGContextSetFillColorWithColor(ctx, self.fillColor.CGColor);
    CGContextSetLineCap(ctx,kCGLineCapRound);
    CGContextSetStrokeColorWithColor(ctx, self.strokeColor.CGColor);
    CGContextSetLineWidth(ctx, self.strokeWidth);
    CGContextSetInterpolationQuality(ctx,kCGInterpolationHigh);
    CGContextDrawPath(ctx, kCGPathEOFillStroke);
}
@end
