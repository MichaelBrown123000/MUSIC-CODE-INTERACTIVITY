(
//~dirpath = "MySounds/*".resolveRelative; //when you load up a folder, you gotta have the slash after it!
~dirpath = "/Users/michaelbrown/Documents/GitHub/MUSIC-CODE-INTERACTIVITY/class7/MySounds/*".resolveRelative; //this folder also sounds good for these examples.
~filepaths = ~dirpath.pathMatch;
~buffers = ~filepaths.collect { |path|  Buffer.read(s, path) };
~buffers = ~filepaths.collect { |path|  Buffer.readChannel(s, path, channels: [0]);};

s.options.maxSynthDefs = 2048;  // Default is 1024, doubling number of synthdefs so we can not overrun the server.

// Make sure the server is booted first
s.boot;

// Wait until server is ready, then create and use the NodeProxy
s.waitForBoot({
  ~np = NodeProxy.audio(s, 2);
  // Set some audio content before playing
  ~np.source = { nil };
  // Now play it
  ~np.play;
});



// Define the slow section
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

// Define the speedy section
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
            var rate = [-2, -3, 1, 4, 8].choose; //negative rates play backward. may result in some frames dropped. see earlier example for hack to fix
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
			var tuningIndex = (0..~michael_harrison.ratios.size-1).choose;  // Choose a random index from the 5-ET tuning
			var rate = ~michael_harrison.ratios[tuningIndex];  // Use the ratio from your 5-ET tuning
		    var octaverate = [-2, -1, 1, 2, 4].choose; //negative rates play backward. may result in some frames dropped. see earlier example for hack to fix
			var amp = rrand(-40, 0).dbamp; //random dynamics
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


// Create the looping task
~loopingTask = Task({
    inf.do { |cycle|
        "Starting cycle %...".format(cycle + 1).postln;

		   // Play slow section
		~michael_harrisonglitchy.value;
		~np.source = { nil };

        // Play slow section
		~slow.value;
		~np.source = { nil };

		// Play glitchy section
        ~glitchy.value;
		~np.source = { nil };

        // Play fast section
        ~fast.value;
		~np.source = { nil };

        "Completed cycle %".format(cycle + 1).postln;
    };
});

// Simple controls
~start = { ~loopingTask.play; "Starting the loop...".postln; };
~stop = { ~loopingTask.stop; "Stopping the loop...".postln; };
)
// Show instructions
"SIMPLE CONTROLS:".postln;
"~start.value - Start the loop".postln;
"~stop.value - Stop the loop".postln;

//In SuperCollider, when you use .value on a variable that contains a function, you're saying "read whatever function is stored in this variable, and execute it now."
~start.value
~stop.value




