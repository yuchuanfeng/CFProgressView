//
//  CFProgressView.m
//  04-CFProgressImageView
//
//  Created by 于传峰 on 15/10/2.
//  Copyright © 2015年 于传峰. All rights reserved.
//

#import "CFProgressView.h"

@interface CFProgressView ()
{
    float a;
    BOOL jia;
    
    CGFloat offsetX;
}
@property (nonatomic, strong) CADisplayLink* displayLink;

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, weak) UILabel *textLabel;
@end

@implementation CFProgressView

- (CADisplayLink *)displayLink
{
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayAnimation)];
    }
    return _displayLink;
}

- (instancetype)initWithImage:(UIImage *)image
{
    if (self = [super initWithFrame:CGRectZero]) {
        // image
        self.image = image;
        CALayer *mask = [CALayer layer];
        mask.contents = (id)self.image.CGImage;
        mask.anchorPoint = CGPointZero;
        mask.frame = CGRectMake(0, 0, self.image.size.width, self.image.size.height);
        self.layer.mask = mask;
        self.layer.masksToBounds = YES;
        a = 1.0;
        jia = NO;
        offsetX = 0.4 / M_PI;
        
        // label
        UILabel* textLabel = [[UILabel alloc] init];
        [self addSubview:textLabel];
        self.textLabel = textLabel;
        textLabel.textColor = [UIColor blackColor];
        textLabel.font = [UIFont systemFontOfSize:30];
        textLabel.frame = (CGRect){30, 80, 100, 100};
        [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    return self;
}

- (void)setProportion:(CGFloat)proportion
{
    _proportion = proportion;
    if (proportion > 1.0) {
        _proportion = 1.0;
    }
    self.textLabel.text = [NSString stringWithFormat:@"%%%02zd", (NSInteger)(_proportion * 100)];
    [self setNeedsDisplay];
}

- (void)displayAnimation
{
    if (jia) {
        a += 0.01;
    }else{
        a -= 0.01;
    }
    
    if (a <= 1) {
        jia = YES;
        
    }
    
    if (a>=1.3) {
        jia = NO;
    }
    offsetX += 0.5/M_PI;
    
    [self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    if (self.proportion >= 1.0) {
        [self.displayLink invalidate];
        self.displayLink = nil;
        return;
    }
    
    
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddRect(context, rect);
    [self.strokeColor set];
    CGContextFillPath(context);
    
    CGFloat animateFillHeight = rect.size.height * (1 - self.proportion);
    
    //画水波
    CGMutablePathRef wavePath = CGPathCreateMutable();
    CGContextSetFillColorWithColor(context, self.fillColor.CGColor);
    CGPathMoveToPoint(wavePath, nil, 0, animateFillHeight - 10);
    float y = 0;
    
    for (float x = 0; x <= self.frame.size.width; x++) {
        y = a * 5 * sin(x  * M_PI / self.frame.size.width * 2.5 + offsetX) + animateFillHeight - 5;
        CGPathAddLineToPoint(wavePath, nil, x, y);
    }
    CGPathAddLineToPoint(wavePath, nil, rect.size.width , rect.size.height);
    CGPathAddLineToPoint(wavePath, nil, 0, rect.size.height);
    
    CGContextAddPath(context, wavePath);
    CGContextFillPath(context);
    CGPathRelease(wavePath);

   //画水波背后的阴影
    CGMutablePathRef shadoWavePath = CGPathCreateMutable();
    CGContextSetFillColorWithColor(context, [self.fillColor  colorWithAlphaComponent:.25].CGColor);
    CGPathMoveToPoint(shadoWavePath, nil, 0, animateFillHeight  -10);
    for (float x = 0; x <= self.frame.size.width; x++) {
        y = a * 5 * cos(x  * M_PI / self.frame.size.width * 2.5 + offsetX) + animateFillHeight - 5;
        CGPathAddLineToPoint(shadoWavePath, nil, x, y);
    }
    CGContextAddPath(context, shadoWavePath);
    CGContextFillPath(context);
    CGPathRelease(shadoWavePath);
    
    
}

// http://code.cocoachina.com/detail/316113/
// http://blog.csdn.net/yanfangjin/article/details/7893980


@end
