//
//  ViewController.m
//  LazyLoader_C
//
//  Created by Malik, Rahul (US - Mumbai) on 5/21/15.
//  Copyright (c) 2015 Malik, Rahul (US - Mumbai). All rights reserved.
//

#import "ViewController.h"
#import "LazyLoaderLayer.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *loaderView;
@property (nonatomic)LazyLoaderLayer *myLoader;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myLoader = [LazyLoaderLayer layer];
    [self.loaderView.layer addSublayer:self.myLoader];
    [self.myLoader initVariablesWithFrame:self.loaderView.frame];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
