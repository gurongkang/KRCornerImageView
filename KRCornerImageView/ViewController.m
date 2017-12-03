//
//  ViewController.m
//  KRCornerImageView
//
//  Created by RK on 2017/12/3.
//  Copyright © 2017年 KR. All rights reserved.
//

#import "ViewController.h"
#import "KRCornerTableViewCell.h"

static NSString *kKRCornerTableViewCell = @"KRCornerTableViewCell";

@interface ViewController () <UITableViewDataSource> {
    NSArray *_imageArray;
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

#pragma mark life

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageArray = @[
                   @"https://gss0.bdstatic.com/94o3dSag_xI4khGkpoWK1HF6hhy/baike/w%3D268%3Bg%3D0/sign=783d11acbf315c6043956ce9b58aac2e/1c950a7b02087bf49212ea50f1d3572c10dfcf89.jpg",
                   @"https://gss3.bdstatic.com/7Po3dSag_xI4khGkpoWK1HF6hhy/baike/w%3D268%3Bg%3D0/sign=1ef9303ddb1373f0f53f68999c342cc6/caef76094b36acafe1673eba76d98d1000e99cf5.jpg",
                   @"https://gss2.bdstatic.com/9fo3dSag_xI4khGkpoWK1HF6hhy/baike/w%3D268%3Bg%3D0/sign=3d85fbc3942f07085f052d06d11fdfa4/5fdf8db1cb134954b37001e85c4e9258d0094ad4.jpg",
                   @"https://gss3.bdstatic.com/7Po3dSag_xI4khGkpoWK1HF6hhy/baike/w%3D268%3Bg%3D0/sign=2a5302bd173853438ccf8027ab28d743/0e2442a7d933c895ce3a69aad61373f08302009e.jpg",
                   @"https://gss1.bdstatic.com/-vo3dSag_xI4khGkpoWK1HF6hhy/baike/w%3D268%3Bg%3D0/sign=c95d4e0cf1edab6474724ac6cf0dc8fe/7dd98d1001e939014c6dbdf971ec54e737d1968d.jpg",
                   @"https://gss3.bdstatic.com/7Po3dSag_xI4khGkpoWK1HF6hhy/baike/w%3D268%3Bg%3D0/sign=fb7c412754df8db1bc2e7b623118ba69/7af40ad162d9f2d3f0306450a3ec8a136327cc68.jpg",
                   @"https://gss3.bdstatic.com/-Po3dSag_xI4khGkpoWK1HF6hhy/baike/w%3D268%3Bg%3D0/sign=434fc5875b3d26972ed30f5b6dc0d5c6/241f95cad1c8a7862ab4b2436d09c93d71cf50e5.jpg",
                   @"https://gss3.bdstatic.com/-Po3dSag_xI4khGkpoWK1HF6hhy/baike/w%3D268%3Bg%3D0/sign=2a3fc9ccdba20cf44690f9d94e322c0b/79f0f736afc3793179e8c862e0c4b74542a911fc.jpg",
                   @"https://gss3.bdstatic.com/-Po3dSag_xI4khGkpoWK1HF6hhy/baike/w%3D268%3Bg%3D0/sign=9273c93d53ee3d6d22c680cd7b2d0a1f/d0c8a786c9177f3ea44726977acf3bc79f3d563d.jpg",
                   @"https://gss1.bdstatic.com/9vo3dSag_xI4khGkpoWK1HF6hhy/baike/w%3D268%3Bg%3D0/sign=0b5191ede250352ab161220e6b789ccf/7a899e510fb30f2473057259c395d143ac4b03c8.jpg",
                   @"https://gss3.bdstatic.com/7Po3dSag_xI4khGkpoWK1HF6hhy/baike/w%3D268%3Bg%3D0/sign=d3668cc1dc88d43ff0a996f44525b526/359b033b5bb5c9ea3aab2857df39b6003af3b32d.jpg",
                   @"https://gss3.bdstatic.com/-Po3dSag_xI4khGkpoWK1HF6hhy/baike/w%3D268%3Bg%3D0/sign=5cd27d4cc33d70cf4cfaad0bc0e7b63d/f31fbe096b63f624488c16768d44ebf81b4ca3f5.jpg",
                   @"https://gss3.bdstatic.com/7Po3dSag_xI4khGkpoWK1HF6hhy/baike/w%3D268%3Bg%3D0/sign=d1d77314f6faaf5184e386b9b46ff3d3/86d6277f9e2f070837f4f132e224b899a901f20b.jpg",
                   @"https://gss0.bdstatic.com/94o3dSag_xI4khGkpoWK1HF6hhy/baike/w%3D268%3Bg%3D0/sign=a1d43069d754564ee565e33f8be5fbbf/10dfa9ec8a1363278a50ce499b8fa0ec08fac70f.jpg",
                   @"https://gss0.bdstatic.com/-4o3dSag_xI4khGkpoWK1HF6hhy/baike/w%3D268%3Bg%3D0/sign=771a6aa0f2dcd100cd9cff274ab0202d/6a600c338744ebf85691a492d3f9d72a6159a7bf.jpg"
                   ];
    
    [self.view addSubview:self.tableView];
    
    [self registerCell];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _imageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KRCornerTableViewCell *cell = (KRCornerTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:kKRCornerTableViewCell forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imageUrl = _imageArray[indexPath.row];
    return cell;
}


#pragma mark tableView

- (void)registerCell {
    UINib *nib = [UINib nibWithNibName:kKRCornerTableViewCell bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:kKRCornerTableViewCell];
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]init];
        _tableView.rowHeight = 80;
        _tableView.dataSource = self;
    }
    
    return _tableView;
}

@end
