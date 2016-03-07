//
//  ViewController.m
//  SSZipArchive-test
//
//  Created by Mr.Li on 16/3/7.
//  Copyright © 2016年 Mr.Li. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<SSZipArchiveDelegate>
{
    UIImageView *_imageView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 200, 200)];
    
    [_imageView setContentMode:UIViewContentModeScaleAspectFit];
    
    [self.view addSubview:_imageView];
    
    //第一步解压.ZIP
    NSString *sourcePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"zipManagerTest.zip"];
    
    NSString *destinationPath = [[(NSArray *)NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject] stringByAppendingPathComponent:@"zipDestination"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:sourcePath]) {
        
        [SSZipArchive unzipFileAtPath:sourcePath toDestination:destinationPath delegate:self];
    }else{
    
        NSLog(@"不存在解压文件");
    }
    
    
    
}

#pragma makr zip info
- (void)zipArchiveWillUnzipArchiveAtPath:(NSString *)path zipInfo:(unz_global_info)zipInfo
{
    
}

- (void)zipArchiveDidUnzipArchiveAtPath:(NSString *)path zipInfo:(unz_global_info)zipInfo unzippedPath:(NSString *)unzippedPath
{
//    NSLog(@"1---%@ 2--%@ 3---%@",path,zipInfo,unzippedPath);
    
    NSLog(@"path%@",path);
    NSLog(@"unzippedPath %@", unzippedPath);
    NSString *imageString = [[unzippedPath  stringByAppendingPathComponent:@"zipManagerTest"]stringByAppendingPathComponent:@"testImage.jpg"];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:imageString])
    {
        NSLog(@"图片存在");
        _imageView.image = [UIImage imageWithContentsOfFile:imageString];
        NSLog(@"%@",_imageView.image);
    }
    NSLog(@"size_comment %lu",zipInfo.size_comment);
    NSLog(@"number_entry %lu", zipInfo.number_entry);

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
