//
//  BDRecorder.m
//  AVAudioRecorderDemo
//
//  Created by sunyazhou on 2017/3/29.
//  Copyright © 2017年 Baidu, Inc. All rights reserved.
//

#import "BDRecorder.h"

@interface BDRecorder () <AVAudioRecorderDelegate>

@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, strong) AVAudioRecorder *recorder;
@property (nonatomic, strong) BDRecordingStopCompletionHanlder completionHandler;

@end

@implementation BDRecorder

- (instancetype)init {
    self = [super init];
    if (self) {
        NSString *temDir = NSTemporaryDirectory();
        NSString *filePath = [temDir stringByAppendingPathComponent:@"test1.caf"];
        NSURL *fileURL = [NSURL fileURLWithPath:filePath];
        
        NSDictionary *setting = @{AVFormatIDKey: @(kAudioFormatAppleIMA4),
                                  AVSampleRateKey: @44100.0f,
                                  AVNumberOfChannelsKey: @1,
                                  AVEncoderBitDepthHintKey: @16,
                                  AVEncoderAudioQualityKey: @(AVAudioQualityMedium)
                                  };
        NSError *error;
        self.recorder = [[AVAudioRecorder alloc] initWithURL:fileURL settings:setting error:&error];
        if (self.recorder) {
            self.recorder.delegate = self;
            [self.recorder prepareToRecord];
        } else {
            NSLog(@"Create Recorder Error: %@",[error localizedDescription]);
        } 
    }
    return self;
}

- (BOOL)record {
    return [self.recorder record];
}

- (void)pause {
    [self.recorder pause];
}

- (void)stopWithCompletionHandler:(BDRecordingStopCompletionHanlder)handler {
    self.completionHandler = handler;
    [self.recorder stop];
}

- (void)saveRecordingWithName:(NSString *)name
            completionHandler:(BDRecordingSaveCompletionHanlder)handler {
}

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder
                           successfully:(BOOL)flag {
    if (self.completionHandler) { self.completionHandler(flag); }
}

@end
