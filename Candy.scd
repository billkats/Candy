/*
1) Before you boot the server, copy all the code from “start up file_synthdefs.scd”.  
2) Open startup file and paste the code. 
3) Save and exit.
4) Start SC and open “Candy.scd”.
*/

s.boot;
s.plotTree;

                                     /*follow the three steps with the correct order */

//step 1 comand/control+enter inside ''a code''

(                     /* a code */
/* This step creates busses to sent the output of the SynthDefs to the Reverb input  */
~reverbBus = Bus.audio(s, 2);
~sourceGrp = Group.new;
~fxGrp = Group.after(~sourceGrp);
)





//step 2 comand/control+enter inside ''candy code''

(                                   /* candy code */



~candy =
{



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



~crazysynthloop ={

	               /* SYNTHS */



	rrand(30.0,40.0).wait;
	d = Synth.new(\crazysynth,
	[\plus, rrand(100,210),
		\attack, rrand(0.1,1.0),
		\decay, rrand(1.1,2.0),
		\release, rrand(3.0,3.9),
		\circle, rrand(0.1,2.0),
		\out, ~reverbBus
		], ~sourceGrp);
	d.release(2);

};




)




//step 3 comand/control+enter inside ''play code''

(                                   /* play code */
{
	~candy.value; // this plays the candy code with the time arrangements
}.fork;

{7 do: { // this loops the crazysynth SynthDef 7 times randomly evry 45 to 55 sec
		{ ~crazysynthloop.value }.fork;
		15.wait;
	};
}.fork;
)




