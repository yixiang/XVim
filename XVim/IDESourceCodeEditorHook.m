//
//  XVimSourceCodeEditor.m
//  XVim
//
//  Created by Tomas Lundell on 31/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IDESourceCodeEditorHook.h"
#import "IDEKit.h"
#import "XVimWindow.h"
#import "Hooker.h"
#import "Logger.h"
#import "XVimStatusLine.h"
#import "XVim.h"
#import "NSObject+XVimAdditions.h"

@implementation IDESourceCodeEditor(XVim)
+ (void)load{
    if (self == [IDESourceCodeEditor class]) {
        [self xvim_swizzleInstanceMethod:@selector(keyDown:) with:@selector(xvim_keyDown:)];
    }
}

- (void)xvim_keyDown:(NSEvent*)event{
    TRACE_LOG("keyDown:!!!!");
    [self xvim_keyDown:event];
}

@end

@implementation IDESourceCodeEditorHook

+ (void) hook
{
    Class delegate = NSClassFromString(@"IDESourceCodeEditor");
	[Hooker hookMethod:@selector(textView:willChangeSelectionFromCharacterRanges:toCharacterRanges:) 
			   ofClass:delegate 
			withMethod:class_getInstanceMethod([self class], @selector(textView:willChangeSelectionFromCharacterRanges:toCharacterRanges:)) 
   keepingOriginalWith:@selector(textView_:willChangeSelectionFromCharacterRanges:toCharacterRanges:)];
}

- (NSArray*) textView:(NSTextView *)textView willChangeSelectionFromCharacterRanges:(NSArray *)oldSelectedCharRanges toCharacterRanges:(NSArray *)newSelectedCharRanges
{
    return newSelectedCharRanges;
}
@end