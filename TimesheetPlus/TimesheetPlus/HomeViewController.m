//
//  HomeViewController.m
//  TimesheetPlus
//
//  Created by Deepthi Kaligi on 25/06/2016.
//  Copyright © 2016 Banana Apps. All rights reserved.
//



#import "HomeViewController.h"
#import "CustomViewWithShadow.h"
#import "NewTaskViewController.h"
@import IGLDropDownMenu;

static UIColor *lightOrangeColor;

@interface HomeViewController () {
    CGFloat screenW  ;
    CGFloat screenH ;
    IGLDropDownMenu *dropDownMenu;
    UIButton *startButton;
    UIButton *pauseButton;
    UIButton *stopButton;
    int secs;
    UILabel *timer;
    UILabel *labelDay;
    NSTimer *timerx;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     lightOrangeColor = [[UIColor alloc]initWithRed:232.0/255.0 green:126.0/255.0 blue:4.0/255.0 alpha:1.0];
    UIColor *backgroundColor = [UIColor colorWithRed:65.0 / 255.0 green:62.f / 255.f blue:79.f / 255.f alpha:1];
    self.view.backgroundColor = [UIColor colorWithWhite:0.45 alpha:1.0];

    screenW = [[UIScreen mainScreen] bounds ].size.width;
    screenH = [[UIScreen mainScreen] bounds  ].size.height;
    
    CustomViewWithShadow *header = [[CustomViewWithShadow alloc]initWithFrame:CGRectMake(0,64,screenW,60)];
    header.backgroundColor = lightOrangeColor;
    [self.view addSubview:header];
    
    UILabel *timesheet = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, screenW, 60)];
    timesheet.attributedText = [[NSAttributedString alloc]initWithString:@"TIMESHEET" attributes:@{NSForegroundColorAttributeName :[UIColor whiteColor], NSFontAttributeName : [UIFont boldSystemFontOfSize:15]}];
    timesheet.backgroundColor = [UIColor clearColor];
    timesheet.textAlignment = NSTextAlignmentCenter;
    [header addSubview:timesheet];
    
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(screenW-60 ,5 , 50, 50)];
    [addButton setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
    [addButton setBackgroundColor:[UIColor clearColor]];
    [addButton addTarget:self action:@selector(addButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:addButton];
    
    CGFloat XAxis = 10;
    CGFloat eachBlock = (screenH-64-header.bounds.size.width-10)/4;
    CGFloat YAxis = CGRectGetMaxY(header.frame)+eachBlock;
    CGFloat width = screenW-20;
    CGFloat height = 40;
    CustomViewWithShadow *timerView = [[CustomViewWithShadow alloc]initWithFrame:CGRectMake(10, YAxis, width, height)];
    timerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:timerView];
    timer = [[UILabel alloc]initWithFrame:CGRectMake(0,0,width,height)];
    timer.attributedText = [[NSAttributedString alloc]initWithString:@"TIMER" attributes:@{NSForegroundColorAttributeName : lightOrangeColor, NSFontAttributeName : [UIFont boldSystemFontOfSize:15]}];
    timer.textAlignment = NSTextAlignmentCenter;
    [timerView addSubview:timer];
    
    ProjectsManager *mgr = [ProjectsManager sharedInstance];
    NSMutableArray *dropdownItems = mgr.dropdownItems;
    
    IGLDropDownItem *item1 = [[IGLDropDownItem alloc] init];
    [item1 setIconImage:[UIImage imageNamed:@"taskicon.png"]];
    [item1 setText:@"Task 1"];
    [dropdownItems addObject:item1];
    
//    IGLDropDownItem *item2 = [[IGLDropDownItem alloc] init];
//    [item2 setIconImage:[UIImage imageNamed:@"taskicon.png"]];
//    [item2 setText:@"Task 2"];
//    [dropdownItems addObject:item2];
//    
//    IGLDropDownItem *item3 = [[IGLDropDownItem alloc] init];
//    [item3 setIconImage:[UIImage imageNamed:@"taskicon.png"]];
//    [item3 setText:@"Task 3"];
//    [dropdownItems addObject:item3];
//    
//    IGLDropDownItem *item4 = [[IGLDropDownItem alloc] init];
//    [item4 setIconImage:[UIImage imageNamed:@"taskicon.png"]];
//    [item4 setText:@"Task 4"];
//    [dropdownItems addObject:item4];
    
    XAxis = 10;
    width = screenW-20;
    YAxis = CGRectGetMaxY(timerView.frame);
    height = 60;
    dropDownMenu = [[IGLDropDownMenu alloc] init];
    [dropDownMenu setFrame:CGRectMake(XAxis, YAxis, width, height)];
    dropDownMenu.menuText = @"Choose Task";
    dropDownMenu.menuIconImage = [UIImage imageNamed:@"chooserIcon.png"];
    dropDownMenu.paddingLeft = 15;  // padding left for the content of the button
    
    dropDownMenu.type = IGLDropDownMenuTypeFlipVertical;
    dropDownMenu.gutterY = 5;
    dropDownMenu.itemAnimationDelay = 0.1;
    dropDownMenu.rotate = IGLDropDownMenuRotateNone;
    dropDownMenu.delegate = self;
    dropDownMenu.dropDownItems = dropdownItems;
    [self.view addSubview:dropDownMenu];
    [dropDownMenu reloadView];
    
    YAxis = CGRectGetMaxY(dropDownMenu.frame);
    height = 50;
    startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [startButton setBackgroundColor:[UIColor greenColor]];
    [startButton.layer setShadowColor:[UIColor whiteColor].CGColor];
    [startButton.layer setShadowOffset:CGSizeMake(-2, 2)];
    [startButton.layer setShadowRadius:2.0];
    [startButton.layer setShadowOpacity:0.8];
    startButton.frame = CGRectMake(XAxis, YAxis, width, height);
    [startButton setAttributedTitle:[[NSAttributedString alloc]initWithString:@"START" attributes:@{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Light" size:25]}] forState:UIControlStateNormal];
[startButton addTarget:self action:@selector(startTimer:) forControlEvents:UIControlEventTouchUpInside];
    [startButton setTag:2];
    [self.view addSubview:startButton];
    
    pauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [pauseButton setBackgroundColor:[UIColor grayColor]];
    [pauseButton.layer setShadowColor:[UIColor whiteColor].CGColor];
    [pauseButton.layer setShadowOffset:CGSizeMake(-2, 2)];
    [pauseButton.layer setShadowRadius:2.0];
    [pauseButton.layer setShadowOpacity:0.8];
    pauseButton.frame = CGRectMake(XAxis, YAxis, width/2, height);
    [pauseButton setAttributedTitle:[[NSAttributedString alloc]initWithString:@"PAUSE" attributes:@{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Light" size:25]}] forState:UIControlStateNormal];
    [pauseButton addTarget:self action:@selector(startTimer:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pauseButton];
    [pauseButton setTag:3];
    [pauseButton setHidden:YES];
    
    stopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [stopButton setBackgroundColor:[UIColor redColor]];
    [stopButton.layer setShadowColor:[UIColor whiteColor].CGColor];
    [stopButton.layer setShadowOffset:CGSizeMake(-2, 2)];
    [stopButton.layer setShadowRadius:2.0];
    [stopButton.layer setShadowOpacity:0.8];
    stopButton.frame = CGRectMake(XAxis+width/2, YAxis, width/2, height);
    [stopButton setAttributedTitle:[[NSAttributedString alloc]initWithString:@"STOP" attributes:@{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Light" size:25]}] forState:UIControlStateNormal];
    [stopButton addTarget:self action:@selector(startTimer:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopButton];
    [stopButton setTag:4];
    [stopButton setHidden:YES];
    
    YAxis = CGRectGetMaxY(startButton.frame)+20;
    height = 40;
    CustomViewWithShadow *summaryView = [[CustomViewWithShadow alloc]initWithFrame:CGRectMake(10, YAxis, width, height)];
    summaryView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:summaryView];
    UILabel *summaryLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, width, height)];
    summaryLabel.attributedText = [[NSAttributedString alloc]initWithString:@"TOTAL" attributes:@{NSForegroundColorAttributeName : lightOrangeColor, NSFontAttributeName : [UIFont boldSystemFontOfSize:15]}];
    summaryLabel.textAlignment = NSTextAlignmentCenter;
    [summaryView addSubview:summaryLabel];
    
    YAxis = CGRectGetMaxY(summaryView.frame);
    width = screenW-20;
    height = 60;
    CustomViewWithShadow *underlay = [[CustomViewWithShadow alloc]initWithFrame:CGRectMake(10, YAxis, width, height)];
    underlay.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:underlay];
    width = width/3;
    labelDay = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    labelDay.backgroundColor = [UIColor clearColor];
    labelDay.textAlignment = NSTextAlignmentCenter;
    labelDay.textColor = [UIColor blackColor];
    labelDay.text = @"00h 00m 00s";
    [underlay addSubview:labelDay];

    
    UILabel *labelWeek = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(labelDay.frame), 0, width, height)];
    labelWeek.backgroundColor = [UIColor clearColor];
    labelWeek.textColor = [UIColor blackColor];
    labelWeek.textAlignment = NSTextAlignmentCenter;
    labelWeek.text = @"14h 00m";
    [underlay addSubview:labelWeek];
    
    UILabel *labelMonth = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(labelWeek.frame), 0, width, height)];
    labelMonth.backgroundColor = [UIColor clearColor];
    labelMonth.textColor = [UIColor blackColor];
    labelMonth.text = @"09h 00m";
    labelMonth.textAlignment = NSTextAlignmentCenter;
    [underlay addSubview:labelMonth];
    
    UILabel *labelDayString = [[UILabel alloc]initWithFrame:CGRectMake(0, height/2, width, height/2)];
    labelDayString.backgroundColor = [UIColor clearColor];
    labelDayString.textAlignment = NSTextAlignmentCenter;
    labelDayString.textColor = [UIColor lightGrayColor];
    labelDayString.text = @"Days";
    [labelDay addSubview:labelDayString];
    
    UILabel *labelWeekString = [[UILabel alloc]initWithFrame:CGRectMake(0, height/2, width, height/2)];
    labelWeekString.backgroundColor = [UIColor clearColor];
    labelWeekString.textAlignment = NSTextAlignmentCenter;
    labelWeekString.textColor = [UIColor lightGrayColor];
    labelWeekString.text = @"Week";
    [labelWeek addSubview:labelWeekString];

    
    UILabel *labelMonthString = [[UILabel alloc]initWithFrame:CGRectMake(0, height/2, width, height/2)];
    labelMonthString.backgroundColor = [UIColor clearColor];
    labelMonthString.textAlignment = NSTextAlignmentCenter;
    labelMonthString.textColor = [UIColor lightGrayColor];
    labelMonthString.text = @"Month";
    [labelMonth addSubview:labelMonthString];
    
    [self.view bringSubviewToFront:dropDownMenu];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    ProjectsManager *mgr = [ProjectsManager sharedInstance];
    NSMutableArray *dropItems = mgr.dropdownItems;
    dropDownMenu.dropDownItems = dropItems;

    [dropDownMenu reloadView];
}



-(void) addButtonTapped {
    NSLog(@"Add Button Tapped ");
    UIStoryboard *stb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NewTaskViewController *nvc =  [stb instantiateViewControllerWithIdentifier:@"NewTaskViewController"];
    [self presentViewController:nvc animated:YES completion:nil];
}

-(void) startTimer:(UIButton *)sender {
    Boolean t = true;
    if (sender.tag == 2) {
        [startButton setHidden:YES];
        [pauseButton setHidden:NO];
        [stopButton  setHidden:NO];
        timerx = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timerx forMode:NSDefaultRunLoopMode];
        
    }
    //pause
    else if (sender.tag == 3)
    {
        [startButton setAttributedTitle:[[NSAttributedString alloc]initWithString:@"RESUME" attributes:@{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Light" size:25]}] forState:UIControlStateNormal];
        [startButton addTarget:self action:@selector(startTimer:) forControlEvents:UIControlEventTouchUpInside];
        [startButton setTag:2];
        [self.view addSubview:startButton];

        [startButton setHidden:NO];
    [pauseButton setHidden:YES];
    [stopButton  setHidden:YES];
        [timerx invalidate];
        labelDay.text = [NSString stringWithFormat:@"%d",secs];
    }
    //stop
    else if(sender.tag == 4) {
        [startButton setAttributedTitle:[[NSAttributedString alloc]initWithString:@"START" attributes:@{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Light" size:25]}] forState:UIControlStateNormal];
        [startButton addTarget:self action:@selector(startTimer:) forControlEvents:UIControlEventTouchUpInside];
        [startButton setTag:2];
        [self.view addSubview:startButton];
        [startButton setHidden:NO];
        [pauseButton setHidden:YES];
        [stopButton  setHidden:YES];
        [timerx invalidate];
        labelDay.text = [NSString stringWithFormat:@"%d",secs];
        secs = 0;
    }
}

-(void) timerTick:(NSTimer *)timer
{
    secs = secs+1;
    labelDay.text = [NSString stringWithFormat:@"%d",secs];
}

-(void) timerPause:(NSTimer *)timer
{
    labelDay.text = [NSString stringWithFormat:@"%d",secs];
}

-(void) timerStop:(NSTimer *)timer
{
    labelDay.text = [NSString stringWithFormat:@"%d",0];
}


@end
