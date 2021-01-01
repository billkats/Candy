s.boot;
s.plotTree;

                                     /*follow the three steps with the correct order */

//step 1 comand/control+enter inside ''a code''

(                     /* a code */
~reverbBus = Bus.audio(s, 2);
~sourceGrp = Group.new;
~fxGrp = Group.after(~sourceGrp);
)



//step 3 comand/control+enter inside ''play code''

(                                   /* play code */
{
	~candy.value;
}.fork;

{7 do: {
		{ ~w.value }.fork;
		15.wait;
	};
}.fork;
)




//step 2 comand/control+enter inside ''candy code''

(                                   /* candy code */



~candy =
{



	                       /* REVERB */

	SynthDef.new(\reverb, {
	arg in;
	var sig, env;
	sig = In.ar(in, 2);
	env = EnvGen.kr(Env.new([0, 1, 1, 0], [0.1, 180, 1]), doneAction:2);
	sig = FreeVerb.ar(sig, 0.5, 0.8, 0.2)*env;
	Out.ar(0, sig);
	}).add;

	                     /* DRONES */
	/*
	bassnote
	*/

	SynthDef.new(\bassnote, {
		arg t1=3, t2=87, t3=5, out, off=1;
		var temp, sum, env;
		sum = 0;
		10.do{
		temp = VarSaw.ar(
			40 * {Rand(0.99, 1.02)}!2,
			{Rand(0.0, 1.0)}!2,
			0.05
		);
		sum = sum + temp;
	};
	env = EnvGen.kr(Env.new([0, 1, 1, 0], [t1, t2, t3]), doneAction:2);
	sum = sum*0.1*env*off;
	Out.ar(out, sum);

	}).add;




	/*
	drone
	*/

	SynthDef.new(\drone,
		{

	arg freq=200, dev=1.02, out, t1=2, t2=77, t3=1,off=1;
	var temp, sum, env;
	sum = 0;
	10.do{
		arg count;
		temp = SinOsc.ar(
			freq *
			(count + 1) *
			LFNoise1.kr({Rand(0.05, 0.2)}!2).range(dev.reciprocal, dev)
		);
		temp = temp * LFNoise1.kr({Rand(0.5, 8)}!2).exprange(0.01, 1);
		sum = sum + temp;
	};
	env = EnvGen.kr(Env.new([0, 1, 1, 0], [t1, t2, t3]), doneAction:2); // εδώ ορίζω τους χρόνους
	sum = sum * 0.2 * env*off;

	Out.ar(out, sum);
		},[5!3]
	).add; // μέσα στην παρένθεση [..] επιλέγω τον χρόνο που θα γίνει η μετάβαση στα ριθμιστικά




	                      /* SYNTHS */

	/*
	simplesig
	*/

	SynthDef(\simplesig, {
		arg freq1 = 201, freq2 = 201.5, mul = 0.3, t1=1, t2=63, t3=1, out, off=1;
		var env;
		env = EnvGen.kr(Env.new([0, 1, 1, 0], [t1, t2, t3]), doneAction:2);
		Out.ar(out,SinOsc.ar
			([freq1, freq2],
				0, mul*env*off)
	)
	},[2, 2.5]).add;



	/*
	ufo
	*/

SynthDef.new(\ufo, {
		arg t1=2, t2=56, t3=2, out, off=1;
	var sig, amp, env;
	env = EnvGen.kr(
		Env.new([0,1,1,0], [t1, t2, t3], [1, -1]),
	doneAction:2
	);
	amp = SinOsc.kr({ExpRand(0.2,12)}!7).range(0,1);
	sig = SinOsc.ar({ExpRand(300,6000)}!7);
	sig = sig * amp * env*off;
	sig = Splay.ar(sig) * 0.3;
	Out.ar(out, sig);
}).add;



	/*
	blip
	*/

	SynthDef.new(\blip, {
	arg out, fund=300, dens=0.5, decay=0.9, t1=3, t2=54, t3=3;
	var freq, trig, sig, env;
	freq = LFNoise0.kr(3).exprange(fund,fund*4).round(fund);
	sig = SinOsc.ar(freq) * 0.3;
	trig = Dust.kr(dens);
	env = EnvGen.kr(Env.new([0, 1, 1, 0], [t1, t2, t3]), doneAction:2);
	sig = sig * EnvGen.kr(Env.perc(0.01, decay), trig) * env;
	sig = Pan2.ar(sig, LFNoise1.kr(10));
	Out.ar(out, sig);
	}).add;




	                      /* Time arrangement */


	0.wait;
	r = Synth.new(\reverb, [\in, ~reverbBus],~fxGrp);
	r.release(2);


	0.1.wait; //0 sec
	a = Synth.new(\bassnote, [\out, ~reverbBus],~sourceGrp);
	a.release(2);

	5.wait; //5 sec
	c = Synth.new(\simplesig, [\out, ~reverbBus],~sourceGrp);
	c.release(2);

	15.wait; //20 sec
	c.set(\freq1, 501.5, \freq2, 501);
	c.release(2);

	10.wait; //30 sec
	c.set(\freq1, 801.5, \freq2, 801.9);
	c.release(2);

	30.wait; //60 sec
	e = Synth.new(\ufo, [\out, ~reverbBus],~sourceGrp);
	e.release(2);

	35.wait; //95 sec
	a.set(\off, 0);
	a.release(2);
	0.01.wait;
	c.set(\off, 0);
	c.release(2);
	0.01.wait;
	e.set(\off, 0);
	e.release(2);

	5.wait; //100 sec
	a.set(\off, 1);
	a.release(2);
	0.01.wait;
	c.set(\off, 1);
	c.release(2);
	0.01.wait;
	e.set(\off, 1);
	e.release(2);
	0.01.wait;
	b = Synth.new(\drone, [\out, ~reverbBus],~sourceGrp);
	b.release(2);
	0.01.wait; //5 sec
	c.set(\freq1, 401.5, \freq2, 401);
	c.release(2);

	20.wait; //120 sec
	f = 8.do{Synth.new(\blip,[\out, ~reverbBus,\fund, exprand(600,1000).round(1000)],~sourceGrp)};
	f.release(2);
	0.01.wait;
	b.set(\freq, 50,\dev, 1.0);
	b.release(2);
	//180 sec

};



~w ={

	               /* SYNTHS */

	/*
	crazysynth
	*/

SynthDef.new(\crazysynth, {
	arg plus=1, adsr1=1, adsr2=2, adsr3=3, circle=0.2, out, t1=1, t2=5, t3=3;
	var sig, env, freq, en;
	freq = EnvGen.kr(Env.adsr(adsr1,adsr2,adsr3), 200, circle);
	en = EnvGen.kr(Env.new([0, 1, 1, 0], [t1, t2, t3]), doneAction:2);
	sig = VarSaw.ar(SinOsc.kr(freq,rrand(0.0,1.0)).range(80+plus, 300+plus)) * 0.4 * en;
	Out.ar(out, sig!2);
}).add;

	rrand(30.0,40.0).wait;
	d = Synth.new(\crazysynth,
	[\plus, rrand(100,210),
		\adsr1, rrand(0.1,1.0),
		\adsr2, rrand(1.1,2.0),
		\adsr3, rrand(3.0,3.9),
		\circle, rrand(0.1,2.0),
		\out, ~reverbBus
		], ~sourceGrp);
	d.release(2);

};
)






