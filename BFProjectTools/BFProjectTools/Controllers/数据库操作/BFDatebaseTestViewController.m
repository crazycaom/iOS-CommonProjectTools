//
//  ViewController.m
//  ObjectDatabase
//
//  Created by mac on 16/9/23.
//  Copyright © 2016年 jason.wang. All rights reserved.
//

#import "BFDatebaseTestViewController.h"
#import "ObjectDatabase.h"
#import "Teacher.h"
#import "Grade.h"

int gradeNum = 1;
int teacherNum = 0;
static NSString *const kTeacherTable = @"kTeacherTable";
static NSString *const kGradeTable = @"kGradeTable";

@interface BFDatebaseTestViewController ()<UITableViewDelegate , UITableViewDataSource>
{
    UITableView *_tableView;
    
    NSMutableArray *_gradeArray;
    
    NSArray *_gradeDataSource;
    
    NSArray *_teacherDataSource;
    
    
}
@property (strong, nonatomic) UISegmentedControl *teacherSegment;
@property (strong, nonatomic) UISegmentedControl *gradeSegment;
@property (nonatomic , strong) UIButton *insertBtn;
@property (nonatomic , strong) UIButton *clearBtn;

@end

@implementation BFDatebaseTestViewController

-(UISegmentedControl *)teacherSegment {
    if (_teacherSegment) {
        return _teacherSegment;
    }
    _teacherSegment = [[UISegmentedControl alloc] initWithFrame:CGRectMake(self.view.width / 2.0, 44 + 64, self.view.width / 2.0, 44)];
    [_teacherSegment insertSegmentWithTitle:@"Height" atIndex:0 animated:NO];
    [_teacherSegment insertSegmentWithTitle:@"Name" atIndex:1 animated:NO];
    [_teacherSegment addTarget:self action:@selector(changeTeacherCondition:) forControlEvents:UIControlEventValueChanged];
    return _teacherSegment;
}

- (UISegmentedControl *)gradeSegment {
    if (_gradeSegment) {
        return _gradeSegment;
    }
    _gradeSegment = [[UISegmentedControl alloc] initWithFrame:CGRectMake(0, 44 + 64, self.view.width / 2.0, 44)];
    [_gradeSegment insertSegmentWithTitle:@"GradeLevel" atIndex:0 animated:NO];
    [_gradeSegment insertSegmentWithTitle:@"ClassNum" atIndex:0 animated:NO];
    [_gradeSegment addTarget:self action:@selector(changeGradeCondition:) forControlEvents:UIControlEventValueChanged];
    return _gradeSegment;
}

- (UIButton *)insertBtn {
    if (_insertBtn) {
        return _insertBtn;
    }
    _insertBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 64, self.view.width / 2.0, 44)];
    [_insertBtn setTitle:@"插入一条数据" forState:UIControlStateNormal];
    [_insertBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    _insertBtn.layer.borderColor = [UIColor orangeColor].CGColor;
    _insertBtn.layer.borderWidth = 1;
    [_insertBtn addTarget:self action:@selector(insertData) forControlEvents:UIControlEventTouchUpInside];
    return _insertBtn;
}

- (UIButton *)clearBtn {
    if (_clearBtn) {
        return _clearBtn;
    }
    _clearBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width / 2.0, 64, self.view.width / 2.0, 44)];
    [_clearBtn setTitle:@"清空表" forState:UIControlStateNormal];
    [_clearBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    _clearBtn.layer.borderWidth = 1;
    _clearBtn.layer.borderColor = [UIColor orangeColor].CGColor;
    [_clearBtn addTarget:self action:@selector(clearDatabase) forControlEvents:UIControlEventTouchUpInside];
    return _clearBtn;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.insertBtn];
    [self.view addSubview:self.clearBtn];
    [self.view addSubview:self.gradeSegment];
    [self.view addSubview:self.teacherSegment];
    
    _gradeArray = [NSMutableArray array];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_teacherSegment.frame) + 5, self.view.frame.size.width, self.view.frame.size.height - CGRectGetMaxY(_teacherSegment.frame)) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [[ObjectDatabase shareDataBase] createDataBase:@"SchoolDatabase"];
    
    //建表
    [[ObjectDatabase shareDataBase] createTable:kTeacherTable usingModelClass:[Teacher class]];
    [[ObjectDatabase shareDataBase] createTable:kGradeTable usingModelClass:[Grade class]];
    
    [self reloadTableView];
}

- (void)reloadTableView {
    _gradeDataSource = [[ObjectDatabase shareDataBase] selectFromTable:kGradeTable targets:@"gradeLevel , classNum" arguments:@""];
    _teacherDataSource = [[ObjectDatabase shareDataBase] selectFromTable:kTeacherTable targets:@"name , height" arguments:nil];
    [_tableView reloadData];
}

#pragma mark ------- tableViewDelegate & dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _gradeDataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"cellIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
    }
    NSString *textPlaceholder;
    NSString *currentText;
    NSString *detailPlaceholder;
    NSString *currentDetailText;
    if (_gradeSegment.selectedSegmentIndex == 0) {
        textPlaceholder = @"gradeLevel为";
        currentText = [NSString stringWithFormat:@"%ld",((Grade *)_gradeDataSource[indexPath.row]).gradeLevel];
    } else {
        textPlaceholder = @"classNum为";
        currentText = [NSString stringWithFormat:@"%d",((Grade *)_gradeDataSource[indexPath.row]).classNum];
    }
    if (_teacherSegment.selectedSegmentIndex == 0) {
        detailPlaceholder = @"teacherHeight为";
        currentDetailText = [NSString stringWithFormat:@"%.1f",((Teacher *)_teacherDataSource[indexPath.row]).height];
    } else {
        detailPlaceholder = @"teacherName为";
        currentDetailText = ((Teacher *)_teacherDataSource[indexPath.row]).name;
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@:%@",textPlaceholder,currentText];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@:%@",detailPlaceholder,currentDetailText];
    return cell;
}

#pragma mark ------- actions
- (void)insertData {
    Grade *grade = [[Grade alloc] init];
    grade.gradeLevel = arc4random()%6 + 1;
    grade.classNum = arc4random()%16 + 1;
    [[ObjectDatabase shareDataBase] insert:@[grade] toTable:kGradeTable];
    
    Teacher *teacher = [[Teacher alloc] init];
    teacher.name = [NSString stringWithFormat:@"%d号老师",arc4random()%15 + 1];
    teacher.height = arc4random()%20 + 160 + arc4random()%10 * 0.1;
    [[ObjectDatabase shareDataBase] insert:@[teacher] toTable:kTeacherTable];
    
    [self reloadTableView];
}

- (void)clearDatabase {
    [[ObjectDatabase shareDataBase] deleteDataInTable:kGradeTable];
    [[ObjectDatabase shareDataBase] deleteDataInTable:kTeacherTable];
    [self reloadTableView];
}

- (void)changeGradeCondition:(UISegmentedControl *)sender {
    [self reloadTableView];
}
- (void)changeTeacherCondition:(UISegmentedControl *)sender {
    [self reloadTableView];
}

@end
