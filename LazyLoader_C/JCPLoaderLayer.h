//
//  JCPLoaderLayer.h
//  LazyLoader_C
//
//  Created by Malik, Rahul (US - Mumbai) on 5/21/15.
//  Copyright (c) 2015 Malik, Rahul (US - Mumbai). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCPLoaderLayer : CALayer
@property (nonatomic)UIColor *strokeColor;
@property (nonatomic)CGFloat strokeWidth;
- (void)startAnimationInFrame:(CGRect)frame;
@end
