//
//  NewTaskViewController.m
//  TimesheetPlus
//
//  Created by Deepthi Kaligi on 27/06/2016.
//  Copyright © 2016 Banana Apps. All rights reserved.
//

#import "NewTaskViewController.h"
#import "CustomViewWithShadow.h"
@import IGLDropDownMenu;


@interface NewTaskViewController () <UITableViewDataSource,UITableViewDelegate>
@property IBOutlet UITableView *tableView ;
@property IBOutlet UITextField *company;
@property IBOutlet UITextField *project;
@property IBOutlet UITextField *budget;
@property IBOutlet UITextField *tax;
@property IBOutlet UITextView *taskdescription;






@end

@implementation NewTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

# pragma mark - Table View Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 5;
    }
    if (section == 1) {return 3;}
    {return 1;}
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cells" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        NSArray *dict = @[@"Customer",@"Service Type",@"Class",@"Billable",@"Taxable"];
        cell.textLabel.text = dict[indexPath.row];
    } else if (indexPath.section == 1){
        NSArray *dict = @[@"Start Time",@"End Time",@"Duration"];
        cell.textLabel.text = dict[indexPath.row];
    } else {
        cell.textLabel.text = @"Notes";
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomViewWithShadow *overlay = [[CustomViewWithShadow alloc]initWithFrame:CGRectMake(10, 20, self.view.bounds.size.width-20, self.view.bounds.size.height-40)];
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 20, self.view.bounds.size.width-20, self.view.bounds.size.height-40)];
    [self.tableView addSubview:overlay];
    [overlay addSubview:textView];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:true];
    NSArray *arr = [self.tableView subviews];
    for ( id i in arr ){
        [i removeFromSuperview];
    }
}


-(IBAction)saveButtonPressed : (UIButton *) button {
    
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:self.project.text forKey:@"project"];
    [dict setObject:self.company.text forKey:@"company"];

    if(self.budget.text.length<=0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Please enter Budget Details" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
        
        return;

  
    }
        
    [dict setObject:self.budget.text forKey:@"budget"];
    [dict setObject:self.tax.text forKey:@"tax"];
    [dict setObject:self.taskdescription.text forKey:@"taskdescription"];
    
    ProjectsManager *mgr = [ProjectsManager sharedInstance];
    NSMutableArray *marray = mgr.sharedProjectsArray;
    [marray addObject:dict];
    NSMutableArray *dropdownItems = mgr.dropdownItems;
    
    IGLDropDownItem *item2 = [[IGLDropDownItem alloc] init];
    [item2 setIconImage:[UIImage imageNamed:@"taskicon.png"]];
    [item2 setText:self.project.text];
    [dropdownItems addObject:item2];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];

}











@end
