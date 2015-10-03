//
//  CFProgressView.h
//  04-CFProgressImageView
//
//  Created by 于传峰 on 15/10/2.
//  Copyright © 2015年 于传峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFProgressView : UIView

//@property (nonatomic, strong) UIImage *image;
- (instancetype)initWithImage:(UIImage *)image;

@property (nonatomic, assign) CGFloat proportion;


@property (nonatomic, strong) UIColor *fillColor;
@property (nonatomic, strong) UIColor *strokeColor;

@end
