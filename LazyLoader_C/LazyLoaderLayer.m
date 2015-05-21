//
//  LazyLoaderLayer.m
//  LazyLoader_C
//
//  Created by Malik, Rahul (US - Mumbai) on 5/21/15.
//  Copyright (c) 2015 Malik, Rahul (US - Mumbai). All rights reserved.
//

#import "LazyLoaderLayer.h"
CGFloat const spaceFromFrame = 1.0f;
@interface LazyLoaderLayer()
@end

@implementation LazyLoaderLayer
@dynamic startAngle, endAngle;
@synthesize fillColor, strokeColor, strokeWidth;

- (void)initVariablesWithFrame:(CGRect)frame {
    self.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    self.fillColor = [UIColor greenColor];
    self.strokeColor = [UIColor redColor];
    self.strokeWidth = 10.0f;
    self.startAngle = 0.0f;
    self.endAngle = 0.0f;
    self.radius = (frame.size.width/2)-(self.strokeWidth/2+1)*2;
    [self setNeedsDisplay];
}

+ (BOOL)needsDisplayForKey:(NSString *)key {
    if ([key isEqualToString:@"startAngle"] || [key isEqualToString:@"endAngle"] || [key isEqualToString:@"rotation"]) {
        return YES;
    }
    
    return [super needsDisplayForKey:key];
}

-(void)drawInContext:(CGContextRef)ctx {
    
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    if(!self.radius)
        self.radius = (self.frame.size.width/2)-(self.strokeWidth/2+1)*2;
    CGFloat radius = 44.0;
    
    CGContextBeginPath(ctx);
    CGContextAddArc(ctx, center.x, center.y, radius, self.startAngle*M_PI/180, self.endAngle*M_PI/180, YES);
    // Color it
    CGContextSetFillColorWithColor(ctx, [UIColor clearColor].CGColor);
    CGContextSetLineCap(ctx,kCGLineCapRound);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(ctx, 10);
    
    CGContextDrawPath(ctx, kCGPathEOFillStroke);
}
@end
