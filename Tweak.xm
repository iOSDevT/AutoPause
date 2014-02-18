/*
 * Automatically Pause Music when volume is decreased to zero
 */

@interface VolumeControl
- (float)getMediaVolume;
- (float)volumeStepUp;
@end

@interface SBMediaController
+ (id)sharedInstance;
- (BOOL)isPlaying;
//- (BOOL)pause;
- (BOOL)play;
@end

%hook VolumeControl
- (void)decreaseVolume {
	%orig;
	if (![[%c(SBMediaController) sharedInstance] isPlaying])
		return; //Nothing is playing
	if ([self getMediaVolume] <= 0.0)
		[[%c(SBMediaController) sharedInstance] pause];
}

- (void)increaseVolume {
	%orig;
	if ([self getMediaVolume] > [self volumeStepUp])
		return; //
	if (![[%c(SBMediaController) sharedInstance] isPaused])
		return; //Nothing is playing
	if ([self getMediaVolume] > 0.0)
		[[%c(SBMediaController) sharedInstance] play];
}
%end