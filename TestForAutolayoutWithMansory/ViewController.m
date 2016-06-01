//
//  ViewController.m
//  TestForAutolayoutWithMansory
//
//  Created by 羅際巧 on 2016/6/1.
//  Copyright © 2016年 Potentia Computing Inc. All rights reserved.
//

#import "ViewController.h"

#import <Masonry/Masonry.h>
#import "UITraitCollection+MKAdditions.h"

@interface ViewController ()

@property BOOL didSetConstraints;
// Constraints
@property NSArray *phonePortraitConstraints;
@property NSArray *phoneLandscapeConstraints;

@property (nonatomic, weak) IBOutlet UILabel *center;
@property (nonatomic, weak) IBOutlet UILabel *a;
@property (nonatomic, weak) IBOutlet UILabel *b;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view setNeedsUpdateConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if( self.view.window == nil) {
        self.view = nil;
    }
}

-(void)updateViewConstraints{
    
    if( self.didSetConstraints){
        self.didSetConstraints = YES;
        [self installGenericConstraints];
        [self toggleConstraintsForTraitCollection:self.traitCollection];
    }
    
    [super updateViewConstraints];
}

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [self toggleConstraintsForTraitCollection:newCollection];
}


- (void)toggleConstraintsForTraitCollection:(UITraitCollection *)traitCollection
{
    
    if ([traitCollection mk_matchesPhoneLandscape]) {
        NSLog(@"landscape");
        [self uninstallPhonePortraitConstraints];
        [self installPhoneLandscapeConstraints];
    }
    else if ([traitCollection mk_matchesPhonePortrait]) {
        NSLog(@"portrait");
        [self uninstallPhoneLandscapeConstraints];
        [self installPhonePortraitConstraints];
    } else{
        NSLog(@"gg");
    }
    
    [self updateViewConstraints];
}

- (void)installGenericConstraints
{
    [self.center mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.equalTo(@100);
        make.width.and.height.equalTo(@90);
//        make.center.equalTo(self.view);
    }];
    
    [self.a mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.center);
        make.top.equalTo(self.center).with.offset(-100);
        make.width.and.height.equalTo(self.center);
    }];
//    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(@60);
//        make.left.right.and.top.equalTo(self.view);
//    }];
//    
//    [self.pictureView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(self.pictureView.mas_width);
//        make.left.equalTo(self.view);
//    }];
//    
//    [self.authorView mas_makeConstraints:^(MASConstraintMaker *make) {
//    addObject:make.height.equalTo(@50);
//        make.top.equalTo(self.headerView.mas_bottom);
//    }];
}

- (void)installPhonePortraitConstraints
{
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    
    [self.center mas_makeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.top.and.left.equalTo(@100)];
        [constraints addObject:make.width.and.height.equalTo(@90)];
//        [constraints addObject:make.center.equalTo(self.view)];
    }];
    
    [self.a mas_makeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.left.equalTo(self.center)];
        [constraints addObject: make.top.equalTo(self.center).with.offset(-100)];
    }];
//    [self.authorView mas_makeConstraints:^(MASConstraintMaker *make) {
//        [constraints addObject:make.left.and.right.equalTo(self.view)];
//    }];
//    
//    [self.pictureView mas_makeConstraints:^(MASConstraintMaker *make) {
//        [constraints addObject:make.top.equalTo(self.authorView.mas_bottom)];
//        [constraints addObject:make.right.equalTo(self.view)];
//    }];
//    
//    [self.likesView mas_makeConstraints:^(MASConstraintMaker *make) {
//        [constraints addObject:make.top.equalTo(self.pictureView.mas_bottom).with.offset(5)];
//        [constraints addObject:make.left.and.right.equalTo(self.view)];
//    }];
    
    self.phonePortraitConstraints = [constraints copy];
}

- (void)uninstallPhonePortraitConstraints
{
    for (MASConstraint *constraint in self.phonePortraitConstraints) {
        [constraint uninstall];
    }
}

- (void)installPhoneLandscapeConstraints
{
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    
    [self.center mas_makeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.top.and.left.equalTo(@100)];
        [constraints addObject:make.width.and.height.equalTo(@90)];
//        [constraints addObject:make.center.equalTo(self.view)];
    }];
//    [self.authorView mas_makeConstraints:^(MASConstraintMaker *make) {
//        [constraints addObject:make.left.equalTo(self.pictureView.mas_right)];
//        [constraints addObject:make.width.lessThanOrEqualTo(self.pictureView)];
//    }];
//    
//    [self.pictureView mas_makeConstraints:^(MASConstraintMaker *make) {
//        [constraints addObject:make.top.equalTo(self.headerView.mas_bottom)];
//        [constraints addObject:make.bottom.equalTo(self.view)];
//    }];
//    
//    [self.likesView mas_makeConstraints:^(MASConstraintMaker *make) {
//        [constraints addObject:make.top.equalTo(self.authorView.mas_bottom)];
//        [constraints addObject:make.left.equalTo(self.pictureView.mas_right)];
//        [constraints addObject:make.width.lessThanOrEqualTo(self.pictureView)];
//    }];
    [self.a mas_makeConstraints:^(MASConstraintMaker *make) {
        [constraints addObject:make.left.equalTo(self.center).with.offset(-100)];
        [constraints addObject:make.top.equalTo(self.center)];
    }];
    
    self.phoneLandscapeConstraints = [constraints copy];
}

- (void)uninstallPhoneLandscapeConstraints
{
    for (MASConstraint *constraint in self.phoneLandscapeConstraints) {
        [constraint uninstall];
    }
}


@end
