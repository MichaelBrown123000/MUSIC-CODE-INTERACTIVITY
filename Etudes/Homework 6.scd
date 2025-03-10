(
~dirpath = "MySounds/*".resolveRelative;
~filepaths = ~dirpath.pathMatch;
~buffers = ~filepaths.collect { |path|  Buffer.read(s, path) };
~buffers = ~filepaths.collect { |path|  Buffer.readChannel(s, path, channels: [0]);};

s.options.maxSynthDefs = 2048;


s.boot;


s.waitForBoot({
  ~np = NodeProxy.audio(s, 2);
  ~np.source = { nil };
  ~np.play;
});




~slow = {
    "Playing slow section...".postln;
    20.do { |i|
		var buf = ~buffers.at(2);
        ~np.add({
            Pan2.ar(
                PlayBuf.ar(buf.numChannels, buf.bufnum,
                    rate: (1..12).choose.midiratio,
                    doneAction: 2) * rrand(-50, 0).dbamp,
                Rand(-1.0, 1.0)
            )
        });
        (buf.duration/4).wait;
    };
};


~fast = {
    "Playing speedy section...".postln;
    100.do { |i|
		var buf = ~buffers.at(5);
        ~np.add({
            Pan2.ar(
                PlayBuf.ar(buf.numChannels, buf.bufnum,
                    rate: (1..12).choose.midiratio,
                    doneAction: 2) * rrand(-40, 0).dbamp,
                Rand(-1.0, 1.0)
            )
        });
        rrand(0.05, 0.3).wait;
    };
};


~glitchy= {
        "Playing glitchy section...".postln;
        80.do { |i|
		var buf = ~buffers.at(20);
            var rate = [-2, -3, 1, 4, 8].choose;
            var start = rrand(0, 0.8);
            ~np.add({
                Pan2.ar(
                    PlayBuf.ar(buf.numChannels, buf.bufnum,
                        rate: rate,
                        startPos: start * buf.numFrames,
                        doneAction: 2) * rrand(-40, -8).dbamp,
                    Rand(-1.0, 1.0)
                )
            });
            rrand(0.1, 0.4).wait;
        };
        "Glitchy section complete.".postln;
    }
;

~michael_harrisonglitchy={
        "Playing MICHAEL_HARRISON section...".postln;
	~michael_harrison = Tuning.new(Tuning.calcET(7));
        100.do { |i|
		var buf = ~buffers.at(6);
            var start = rrand(0, 0.8);
			var tuningIndex = (0..~michael_harrison.ratios.size-1).choose;
			var rate = ~michael_harrison.ratios[tuningIndex];
		    var octaverate = [-2, -1, 1, 2, 4].choose;
			var amp = rrand(-40, 0).dbamp;
            ~np.add({
                Pan2.ar(
                    PlayBuf.ar(buf.numChannels, buf.bufnum,
                        rate: rate,
                        startPos: start * buf.numFrames,
                        doneAction: 2) * amp,
                    Rand(-1.0, 1.0)
                )
            });
            rrand(0.1, 0.4).wait;
        };
        "MICHAEL_HARRISON section complete.".postln;
    };



~loopingTask = Task({
    inf.do { |cycle|
        "Starting cycle %...".format(cycle + 1).postln;


		~michael_harrisonglitchy.value;
		~np.source = { nil };


		~slow.value;
		~np.source = { nil };


        ~glitchy.value;
		~np.source = { nil };


        ~fast.value;
		~np.source = { nil };

        "Completed cycle %".format(cycle + 1).postln;
    };
});


~start = { ~loopingTask.play; "Starting the loop...".postln; };
~stop = { ~loopingTask.stop; "Stopping the loop...".postln; };
)

"SIMPLE CONTROLS:".postln;
"~start.value - Start the loop".postln;
"~stop.value - Stop the loop".postln;


~start.value
~stop.value




