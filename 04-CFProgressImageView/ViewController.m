//
//  ViewController.m
//  04-CFProgressImageView
//
//  Created by 于传峰 on 15/10/2.
//  Copyright © 2015年 于传峰. All rights reserved.
//

#import "ViewController.h"
#import "CFProgressView.h"

@interface ViewController ()
@property (nonatomic, weak) CFProgressView *progressView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
//    CFProgressView* progressView = [[CFProgressView alloc] initWithImage:[UIImage imageNamed:@"jaykt"]];
    UIImage* image = [UIImage imageNamed:@"jaykt"];
    CFProgressView* progressView = [[CFProgressView alloc] initWithImage:image];
    progressView.bounds = (CGRect){0, 0, image.size};
    [self.view addSubview:progressView];
    progressView.proportion = 0.0;
    progressView.strokeColor = [UIColor redColor];
    progressView.fillColor = [UIColor greenColor];
    progressView.center = self.view.center;
    
    self.progressView = progressView;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSTimer* timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(timerUpdate) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    // Dispose of any resources that can be recreated.
}

- (void)timerUpdate
{
    self.progressView.proportion += 0.002;
}

@end
