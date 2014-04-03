//
//  MyCustomEmailer.m
//  ECard
//
//  Created by Chris Meehan on 4/2/14.
//  Copyright (c) 2014 Chris Meehan. All rights reserved.
//

#import "MyCustomEmailer.h"


@implementation MyCustomEmailer

-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    UIImageView* uIIView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 275, 480)];
    [uIIView1 setBackgroundColor:[UIColor blackColor]];
    [uIIView1 setImage:[UIImage imageNamed:@"ECardEdgeRev2.jpg"]];
    [self.view addSubview:uIIView1];
    
    UIImageView* uIIView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 60, 320, 420)];
    [uIIView2 setBackgroundColor:[UIColor blackColor]];
    [uIIView2 setImage:[UIImage imageNamed:@"ECardCroppedRev.jpg"]];
    [self.view addSubview:uIIView2];
    
    UIView* uIV = [[UIView alloc]initWithFrame:CGRectMake(270, 35.5, 50, 30)];
    [uIV setBackgroundColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1]];
    [self.view addSubview:uIV];
    
}


- (NSUInteger)supportedInterfaceOrientations
{
    return (UIInterfaceOrientationMaskPortraitUpsideDown);
}

@end
