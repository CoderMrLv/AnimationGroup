//
//  ViewController.m
//  AnimationGroup
//
//  Created by apple on 16/4/20.
//  Copyright © 2016年 qingxunLv. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong) UIView * containerView;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self createBezierPath];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)groupAnimation{
    
    self.containerView = [[UIView alloc]initWithFrame:CGRectMake(0, 150, 200, 200)];
    [self.view addSubview:self.containerView];
    //create a path
    UIBezierPath *bezierPath = [[UIBezierPath alloc]init];
    self.containerView.center = CGPointMake(200, 150);
    [bezierPath moveToPoint:CGPointMake(200, 150)];
    
//    [bezierPath addCurveToPoint:CGPointMake(200, 150) controlPoint1:CGPointMake(100, 0) controlPoint2:CGPointMake(0, 400)];
    
    [bezierPath addArcWithCenter:CGPointMake(200, 150) radius:M_PI_2*2 startAngle:0.0 endAngle:M_PI_2 clockwise:YES];
    
    //draw the path using a CAShapeLayer
    CAShapeLayer *pathlayer = [CAShapeLayer layer];
    pathlayer.path = bezierPath.CGPath;
    pathlayer.fillColor = [UIColor whiteColor].CGColor;
    pathlayer.strokeColor = [UIColor redColor].CGColor;
    pathlayer.lineWidth = 15.0f;
    [self.containerView.layer addSublayer:pathlayer];
    
    //add a colored layer
    CALayer *colorLayer = [CALayer layer];
    colorLayer.frame = CGRectMake(0, 0, 64, 64);
    colorLayer.backgroundColor = [UIColor greenColor].CGColor;
    [self.containerView.layer addSublayer:colorLayer];
    
    //create the position animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.path = bezierPath.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    
    //create the color animation
    CABasicAnimation *animation2 = [CABasicAnimation animation];
    animation2.keyPath = @"backgroundColor";
    animation2.toValue = (__bridge id)[UIColor redColor].CGColor;
    
    //create group animation
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[animation,animation2];
    groupAnimation.duration = 4.0;
    
    //add the animation to the color layer
    [colorLayer addAnimation:groupAnimation forKey:nil];
    
    
    
}

- (void)CABasicAnimation{
    
    self.containerView = [[UIView alloc]initWithFrame:CGRectMake(10, 100, 200, 2000)];
    [self.view addSubview:self.containerView];
    
    CALayer * shipLayer = [CALayer layer];
    shipLayer.frame = CGRectMake(0, 0, 128, 128);
    shipLayer.position = CGPointMake(150, 150);
    shipLayer.contents = (__bridge id)[UIImage imageNamed:@"选择框"].CGImage;
    [self.containerView.layer addSublayer:shipLayer];
    
    //animate the ship rotation
    CABasicAnimation * animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.duration = 2.0;
    animation.byValue = @(M_PI*2);
    [shipLayer addAnimation:animation forKey:nil];
    
    
}

- (void)createBezierPath{
    
    self.containerView = [[UIView alloc]initWithFrame:CGRectMake(10, 100, 64,64)];
    [self.view addSubview:self.containerView];
    //create a path
    self.containerView.center = CGPointMake(200, 400);
    //画圆
    UIBezierPath * bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100,-200) radius:100 startAngle:0 endAngle:2*M_PI clockwise:YES];
    //画弧线
 //   UIBezierPath * bezierPath = [[UIBezierPath alloc]init];
    //起点坐标
    [bezierPath moveToPoint:CGPointMake(200,-200)];
    // 终点坐标    转折点1    转折点2
    [bezierPath addCurveToPoint:CGPointMake(-150, 100) controlPoint1:CGPointMake(0,200) controlPoint2:CGPointMake(0,-200)];
    //draw the path using a CAShapeLayer
    
    CAShapeLayer * pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    //设置填充色
    pathLayer.fillColor = [UIColor whiteColor].CGColor;
    //设置线条色
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.containerView.layer addSublayer:pathLayer];
    
    //add the ship
    CALayer * shipLayer = [CALayer layer];
    shipLayer.frame = CGRectMake(0, 0, 64, 64);
//    shipLayer.position = CGPointMake(0, 150);
    shipLayer.contents = (__bridge id)[UIImage imageNamed:@"001"].CGImage;
    [self.containerView.layer addSublayer:shipLayer];
    
    
    //create the keyframe animation
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 4.0f;
    animation.path = bezierPath.CGPath;
    //设置滚动的方向
    animation.rotationMode = kCAAnimationRotateAuto;
    animation.autoreverses = NO;
    animation.repeatCount = 10;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [shipLayer addAnimation:animation forKey:nil];
    [bezierPath closePath];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
