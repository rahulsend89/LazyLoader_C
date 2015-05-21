//
//  LazyLoaderLayer.h
//  LazyLoader_C
//
//  Created by Malik, Rahul (US - Mumbai) on 5/21/15.
//  Copyright (c) 2015 Malik, Rahul (US - Mumbai). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LazyLoaderLayer : CALayer
@property (nonatomic)CGFloat startAngle;
@property (nonatomic)CGFloat endAngle;
@property (nonatomic)UIColor *fillColor;
@property (nonatomic)UIColor *strokeColor;
@property (nonatomic)CGFloat strokeWidth;
@property (nonatomic)CGFloat radius;

- (void)initVariablesWithFrame:(CGRect)frame;
@end
