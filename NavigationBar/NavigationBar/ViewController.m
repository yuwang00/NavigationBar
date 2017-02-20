//
//  ViewController.m
//  testNavigation
//
//  Created by mathewchen on 17/2/16.
//  Copyright © 2017年 mathewchen. All rights reserved.
//

#import "ViewController.h"
#import "ExampleView.h"
@interface ViewController (){
    
    ExampleView *view1;
    ExampleView *view2;
    ExampleView *view3;
    ExampleView *view4;
    CGFloat scrollViewHight;
    CGFloat titilPositionY;
    CGRect labelFrame;
}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UILabel *titleLable;
@property(nonatomic,strong)UIView *navgationBar;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    scrollViewHight=60;
    [self setupTableview];
    [self setupNavigation];
    [self setupScrollview];
    
    
    
}

-(void)setupNavigation{
    [self.navigationController setNavigationBarHidden:YES];
    _navgationBar=[[UIView alloc]initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, 64+scrollViewHight)];
    _titleLable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    _titleLable.center=CGPointMake(_navgationBar.frame.size.width/2, 64/2);
    titilPositionY=_titleLable.frame.origin.y;
    _titleLable.text=@"鱼王";
    _titleLable.textAlignment=NSTextAlignmentCenter;
    
    [_navgationBar addSubview:_titleLable];
    [self.view addSubview:_navgationBar];
    
}

-(void)setupScrollview{
    self.scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, scrollViewHight)];
    view1=[[ExampleView alloc]initWithFrame:CGRectMake(0, 0, self.scrollView.frame.size.width/3, self.scrollView.frame.size.height)];
    [view1.text setText:@"第一个"];
    
    
    view2=[[ExampleView alloc]initWithFrame:CGRectMake(self.scrollView.frame.size.width/3, 0, self.scrollView.frame.size.width/3, self.scrollView.frame.size.height)];
    [view2.text setText:@"第二个"];
    
    view3=[[ExampleView alloc]initWithFrame:CGRectMake(self.scrollView.frame.size.width*2/3, 0, self.scrollView.frame.size.width/3, self.scrollView.frame.size.height)];
    [view3.text setText:@"第三个"];
    
    view4=[[ExampleView alloc]initWithFrame:CGRectMake(self.scrollView.frame.size.width*3/3, 0, self.scrollView.frame.size.width/3, self.scrollView.frame.size.height)];
    
    [view4.text setText:@"第四个"];
    
    labelFrame=view1.text.frame;
    _scrollView.pagingEnabled = NO;
    _scrollView.bounces=NO;
    [self.scrollView addSubview:view1];
    [self.scrollView addSubview:view2];
    [self.scrollView addSubview:view3];
    [self.scrollView addSubview:view4];
    self.scrollView.contentSize=CGSizeMake(4*view1.frame.size.width,0);
    [self.navgationBar addSubview:self.scrollView];
}

-(void)setupTableview{
    
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, self.view.bounds.size.width, self.view.bounds.size.height-44) style:UITableViewStylePlain];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    
    [self.tableView setContentInset:UIEdgeInsetsMake(scrollViewHight, 0, 0, 0)];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    [cell.textLabel setText:@"666"];
    
    return cell;
}


# pragma mark - UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView==self.tableView) {
        CGFloat preccess =scrollView.contentOffset.y+scrollViewHight;
        CGFloat x=(1-preccess/64)>0.5?1-preccess/64:0.5;
        x>1?x=1:x;
        NSLog(@"%f/%f",x,preccess);
        CGRect frame=CGRectMake(labelFrame.origin.x*x, labelFrame.origin.y*x, labelFrame.size.width*x, labelFrame.size.height*x);
        [UIView animateWithDuration:0 animations:^{
            self.scrollView.frame=CGRectMake(self.scrollView.frame.origin.x, 64-preccess>20?64-preccess:20, self.scrollView.frame.size.width, scrollViewHight*x);
            _titleLable.alpha=x;
            _titleLable.frame=CGRectMake(_titleLable.frame.origin.x, titilPositionY-preccess, _titleLable.frame.size.width, _titleLable.frame.size.height);
            _navgationBar.frame=CGRectMake(0, 0, self.view.bounds.size.width, 64+self.scrollView.frame.size.height-preccess>50?64+self.scrollView.frame.size.height-preccess:50);
            
            //子view动
            view1.frame=CGRectMake(0, 0, self.scrollView.frame.size.width/3*x, scrollViewHight*x);
            view1.text.frame=frame;
            view2.frame=CGRectMake(view1.frame.size.width, 0, self.scrollView.frame.size.width/3*x, scrollViewHight*x);
            view2.text.frame=frame;
            view3.frame=CGRectMake(view1.frame.size.width*2, 0, self.scrollView.frame.size.width/3*x, scrollViewHight*x);
            view3.text.frame=frame;
            view4.frame=CGRectMake(view1.frame.size.width*3, 0, self.scrollView.frame.size.width/3*x, scrollViewHight*x);
            view4.text.frame=frame;
        } completion:^(BOOL finished) {
            self.scrollView.contentSize=CGSizeMake(4*view1.frame.size.width,0);
            
        }];
        
    }
}


@end
