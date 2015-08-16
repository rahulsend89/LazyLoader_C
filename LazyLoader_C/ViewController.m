//
//  ViewController.m
//  LazyLoader_C
//
//  Created by Malik, Rahul (US - Mumbai) on 5/21/15.
//  Copyright (c) 2015 Malik, Rahul (US - Mumbai). All rights reserved.
//

#import "ViewController.h"
#import "JCPLoaderLayer.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *loaderView;
@property (nonatomic)JCPLoaderLayer *myLoader;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myLoader = [[JCPLoaderLayer alloc] initWithLayer:self.loaderView.layer];
    [self.loaderView.layer addSublayer:self.myLoader];
    [self.myLoader startAnimationInFrame:self.loaderView.frame];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
