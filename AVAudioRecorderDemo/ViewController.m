//
//  ViewController.m
//  AVAudioRecorderDemo
//
//  Created by sunyazhou on 2017/3/28.
//  Copyright © 2017年 Baidu, Inc. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
@property (nonatomic, strong) AVAudioRecorder *recorder;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
}


/**
 创建录音器
 */
- (void)createRecorder {
    NSString *directory = NSTemporaryDirectory();
    NSString *filePath = [directory stringByAppendingPathComponent:@"voice1.m4a"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    
    NSDictionary *setting = @{AVFormatIDKey : @(kAudioFormatMPEG4AAC),
                              AVSampleRateKey: @22050.0f,
                              AVNumberOfChannelsKey: @1};
    NSError *error;
    self.recorder = [[AVAudioRecorder alloc] initWithURL:url
                                                settings:setting
                                                   error:&error];
    if (self.recorder) {
        [self.recorder prepareToRecord];
    } else {
        NSLog(@"Recorder Create Error: %@", [error localizedDescription]);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
