//
//  ServerContentViewController.m
//  PydioSDK
//
//  Created by ME on 04/02/14.
//  Copyright (c) 2014 MINI. All rights reserved.
//

#import "ServerContentViewController.h"
#import "FileNode.h"
#import "PydioClient.h"
#import "Workspace.h"


static NSString * const TABLE_CELL_ID = @"TableCell";


@interface ServerContentViewController ()
@property (nonatomic,strong) NSArray *files;
@property (nonatomic,strong) PydioClient* client;
@end

@implementation ServerContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.activityIndicator stopAnimating];
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.client = [[PydioClient alloc] initWithServer:[self.server absoluteString]];
    
    [self.client listFiles:@{
                             @"tmp_repository" : self.workspace.workspaceId,
                             @"dir": self.path,
                             @"options":@"al"
                             } WithSuccess:^(NSArray *files) {
        self.files = ((FileNode*)[files objectAtIndex:0]).children;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%s %@",__PRETTY_FUNCTION__,error);
    }];
    
    self.navigationItem.title = self.workspace.label;
    
}

#pragma mark - UITableViewDataSource

-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TABLE_CELL_ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TABLE_CELL_ID];
    }
    
    cell.textLabel.text = [self fileNameAt:indexPath.row];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.files.count;
}

-(NSString*)fileNameAt:(NSInteger)row {
    return ((FileNode*)[self.files objectAtIndex:row]).name;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    int row = [self.tableView indexPathForSelectedRow].row;
    
    ServerContentViewController *destination = segue.destinationViewController;
    destination.workspace = self.workspace;
    destination.server = self.server;
    destination.path = [NSString stringWithFormat:@"%@%@/",self.path,((FileNode*)[self.files objectAtIndex:row]).path];
}


@end
