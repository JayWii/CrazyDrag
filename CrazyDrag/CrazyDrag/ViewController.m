//
//  ViewController.m
//  CrazyDrag
//
//  Created by Cooper on 15/9/20.
//  Copyright (c) 2015年 Jason. All rights reserved.
//

#import "ViewController.h"
#import "AboutViewController.h"

@interface ViewController (){
    int currentValue;
    int targetValue;
    int score;
    int round;
}
@property (strong, nonatomic) IBOutlet UILabel *targetNumber;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *roundLabel;
@property (strong, nonatomic) IBOutlet UISlider *slider;


@end

@implementation ViewController

@synthesize targetNumber;

- (void)startNewRound{
    round+=1;
    targetValue = 1 + (arc4random()%100);
    self.targetNumber.text = [NSString stringWithFormat:@"%d",targetValue];
}

- (void)updataLabels{
    self.targetNumber.text = [NSString stringWithFormat:@"%d",targetValue];
    self.scoreLabel.text = [NSString stringWithFormat:@"%d",score];
    self.roundLabel.text = [NSString stringWithFormat:@"%d",round];
}

- (void)startNewGame{
    score = 0;
    round = 0;
    [self startNewRound];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImage *thumbImageNormal = [UIImage imageNamed:@"SliderThumb-Normal"];
    [self.slider setThumbImage:thumbImageNormal forState:UIControlStateNormal];

    UIImage *thumbUmageHighlighted = [UIImage imageNamed:@"SliderThumbHighlighted"];
    [self.slider setThumbImage:thumbUmageHighlighted forState:UIControlStateHighlighted];

    UIImage *trackLeftImage = [[UIImage imageNamed:@"SliderTrackLeft"]stretchableImageWithLeftCapWidth:14 topCapHeight:0];
    [self.slider setMinimumTrackImage:trackLeftImage forState:UIControlStateNormal];

    UIImage *trackRightImage = [[UIImage imageNamed:@"SliderTrackRight"]stretchableImageWithLeftCapWidth:14 topCapHeight:0];
    [self.slider setMaximumTrackImage:trackRightImage forState:UIControlStateNormal];

    [self startNewRound];
    [self updataLabels];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showAlert:(id)sender {
    int difference = abs(currentValue - targetValue);
    int points = 100 - difference;
    score+=points;
    NSString *message = [NSString stringWithFormat:@"大神,您的得分是:%d",points];

    [[[UIAlertView alloc]initWithTitle:@"猪，你好!" message:message delegate:self cancelButtonTitle:@"朕知道了" otherButtonTitles:nil, nil]show];

}

- (IBAction)sliderMoved:(id)sender {
    UISlider *slider = sender;
    currentValue = (int)lroundf(slider.value);
    NSLog(@"当前滑动条数值为:%d",currentValue);
    //self.sliderNumber.text = [NSString stringWithFormat:@"%d",currentValue];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self startNewRound];
    [self updataLabels];
}

- (IBAction)satrtOver:(id)sender {

    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.duration = 3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];

    [self startNewGame];
    [self updataLabels];

    [self.view.layer addAnimation:transition forKey:nil];
}

- (IBAction)showInfo:(id)sender {
    AboutViewController *controller = [[AboutViewController alloc]initWithNibName:@"AboutViewController" bundle:nil];
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:controller animated:YES completion:nil];
}

@end
