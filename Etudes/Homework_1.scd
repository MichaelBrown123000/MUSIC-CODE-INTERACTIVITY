(
// LFO modulation of Pulse waves and resonant filters
play({
	CombL.ar(
		RLPF.ar(LFPulse.ar(FSinOsc.kr(0.08,0,80,130),0,0.9,0.02),
		   FSinOsc.kr([0.6,0.1],0,4300,8000), 0.2),
		0.5, [0.2,0.75], 6)
}))
(
// moto rev
{
	RLPF.ar(LFPulse.ar(SinOsc.kr(0.4, 0, 20, 46), 0.4), 200, 0.5).clip2(0.3)
}.play)
(
// glissando function
{
f = LFSaw.kr(0.4, 0, 38, LFSaw.kr([8,7.23], 0, 3, 30)).midicps;
}.play)
(
// glissando function
{
f = LFSaw.kr(0.3, 0, 55, LFSaw.kr([2,7.10], 0, 2, 25)).midicps;
}.play)
(
// echoing sine wave
{
CombN.ar(SinOsc.ar(f, 0, 0.06), 0.5, 0.3, 6)
}.play)
(
{
	f = LFSaw.kr(0.6, 0, 27, LFSaw.kr([8,5.40], 0, 66, 32)).midicps; // glissando function
	f = LFSaw.kr(0.3, 0, 12, LFSaw.kr([2,7.23], 0, 3, 80)).midicps; // glissando function
	CombN.ar(SinOsc.ar(f, 0, 0.04), 0.8, 0.1, 0) // echoing sine wave
}.play)