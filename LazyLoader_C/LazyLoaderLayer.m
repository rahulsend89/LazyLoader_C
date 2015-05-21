//
//  LazyLoaderLayer.m
//  LazyLoader_C
//
//  Created by Malik, Rahul (US - Mumbai) on 5/21/15.
//  Copyright (c) 2015 Malik, Rahul (US - Mumbai). All rights reserved.
//

#import "LazyLoaderLayer.h"
CGFloat const spaceFromFrame = 1.0f;
#define DURATION 2.0
@interface LazyLoaderLayer()
@end

@implementation LazyLoaderLayer
@dynamic startAngle, endAngle;
@synthesize fillColor, strokeColor, strokeWidth;

- (void)initVariablesWithFrame:(CGRect)frame {
    self.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    self.fillColor = [UIColor clearColor];
    self.strokeColor = [UIColor blackColor];
    self.strokeWidth = frame.size.width/10;
    self.startAngle = 0.0f;
    self.endAngle = 0.0f;
    self.radius = (frame.size.width/2)-(self.strokeWidth/2+1)*2;
    [self addRotation];
}
- (id)initWithLayer:(id)layer {
    if (self = [super initWithLayer:layer]) {
        if ([layer isKindOfClass:[LazyLoaderLayer class]]) {
            LazyLoaderLayer *other = (LazyLoaderLayer *)layer;
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
+ (BOOL)needsDisplayForKey:(NSString *)key {
    if ([key isEqualToString:@"startAngle"] || [key isEqualToString:@"endAngle"] || [key isEqualToString:@"rotation"]) {
        return YES;
    }
    
    return [super needsDisplayForKey:key];
}
-(void)addRotation{
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: 360.0f*M_PI/180];
    rotationAnimation.duration = DURATION;
    rotationAnimation.repeatCount = HUGE_VAL;
    [self addAnimation:rotationAnimation forKey:@"rotation"];
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
        }else{
            self.endAngle = 0.1f;
            [self startAnimationWithAngle:@"startAngle"];
        }
}

-(void)drawInContext:(CGContextRef)ctx {
    
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    CGFloat radius = self.radius;
    
    CGContextBeginPath(ctx);
    CGContextAddArc(ctx, center.x, center.y, radius, self.startAngle*M_PI/180, self.endAngle*M_PI/180, YES);
    CGContextSetFillColorWithColor(ctx, self.fillColor.CGColor);
    CGContextSetLineCap(ctx,kCGLineCapRound);
    CGContextSetStrokeColorWithColor(ctx, self.strokeColor.CGColor);
    CGContextSetLineWidth(ctx, self.strokeWidth);
    CGContextDrawPath(ctx, kCGPathEOFillStroke);
}
@end
