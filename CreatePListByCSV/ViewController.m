//
//  ViewController.m
//  CreatePListByCSV
//
//  Created by Eriko Ichinohe on 2014/11/28.
//  Copyright (c) 2014年 Eriko Ichinohe. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startCreatingPList:(id)sender {
    
    NSError *error;
    
    //プロジェクト内のファイルにアクセスできるオブジェクトを宣言
    NSBundle *bundle = [NSBundle mainBundle];
    
    //読み込むプロパティリストのファイルパス（場所）を指定
    NSString *path = [bundle pathForResource:@"read" ofType:@"csv"];
   
    NSString *text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];//NSUTF8StringEncoding
    if (error) {
        NSLog(@"error:%@",error);
    }
    
    NSMutableDictionary *outputArray = [NSMutableDictionary dictionary];
    
    //1行毎に配列へ格納
    NSArray *lines = [text componentsSeparatedByString:@"\n"];
    
    NSMutableArray *keys1;
    NSMutableArray *keys2;
    NSMutableArray *tranItem;
    NSMutableArray *arraryH2;
    
    BOOL header_flag = NO;
    
    for (NSInteger i = 0;i<[lines count];i++ ) {
        NSString *itemsStr = [lines objectAtIndex:i];
        NSArray *items = [itemsStr componentsSeparatedByString:@","];

        header_flag = NO;
        
        if ([items[0] isEqualToString:@"H1"]) {
            
            if (arraryH2.count > 0) {
                [outputArray setObject:arraryH2 forKey:keys1[0]];
            }
            
            keys1 = items.mutableCopy;
            [keys1 removeObjectAtIndex:0];
            header_flag = YES;
        }
        
        if ([items[0] isEqualToString:@"H2"]) {
            
            keys2 = items.mutableCopy;
            [keys2 removeObjectAtIndex:0];
            header_flag = YES;
            arraryH2 = [NSMutableArray new];
        }
        
        if (!header_flag) {
            tranItem = items.mutableCopy;
            [tranItem removeObjectAtIndex:0];
            NSMutableDictionary *contentH2 = [NSMutableDictionary dictionary];
            
            //1レコードのDictionary（contentsH2）を作成
            
            for (NSInteger k=0; k<[tranItem count]; k++) {
                NSString *item = [tranItem objectAtIndex:k];
                NSString *key = [keys2 objectAtIndex:k];
                [contentH2 setObject:item forKey:key];
            }
            
            //配列に追加
            [arraryH2 addObject:contentH2];
            

        }
    }
    
    if (arraryH2.count > 0) {
        [outputArray setObject:arraryH2 forKey:keys1[0]];
    }

    
    
//    NSString *keysStr = [lines objectAtIndex:0];
//    NSArray *keys = [keysStr componentsSeparatedByString:@","];
//    
//    
//    
//    
//    
//    for (NSInteger i = 1;i<[lines count];i++ ) {
//        NSString *itemsStr = [lines objectAtIndex:i];
//        NSArray *items = [itemsStr componentsSeparatedByString:@","];
//        NSMutableDictionary *content = [NSMutableDictionary dictionary];
//        for (NSInteger k=0; k<[items count]; k++) {
//            NSString *item = [items objectAtIndex:k];
//            NSString *key = [keys objectAtIndex:k];
//            [content setObject:item forKey:key];
//        }
//        [outputArray addObject:content];
//    }
    
    
    // ホームディレクトリを取得
    NSString *homeDir = NSHomeDirectory();
    NSString *fileName = @"created.plist";
    NSString *createdfilepath = [homeDir stringByAppendingPathComponent:fileName];
    
    BOOL result = [outputArray writeToFile:createdfilepath atomically:YES];
    NSString *msg;
    if (!result) {
        msg = @"ファイルの書き込みエラー";
    }else{
        msg = @"ファイルの書き込み成功";
        self.pathTextView.text = createdfilepath;
    }
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}
@end
