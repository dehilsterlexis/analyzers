###############################################
# FILE: fin.pat
# SUBJ: Cleanups.
# AUTH: AM
# CREATED: 05/Jul/04 20:08:41
# NOTE:	Cleanups for TAIParse analyzer.
###############################################

@CODE

if (!G("pretagged"))
  exitpass();

posacctdump();

if (G("mismatch out"))
  closefile(G("mismatch out"));
if (G("zero out"))
  closefile(G("zero out"));

# Get current doc score.
L("currgood") = numval(G("scorepos"),"currgood");
L("currtot") = numval(G("scorepos"),"currtot");

if (!L("currtot"))
  {
  "err.txt" << "Currtot is zero." << "\n";
  exitpass();
  }
# Accumulate overall scores.
L("allgood") = numval(G("scorepos"),"allgood") + L("currgood");
L("alltot") = numval(G("scorepos"),"alltot") + L("currtot");

# Printout scores.
L("fname") = G("$apppath") + "\\data\\score.txt";
L("out") = openfile(L("fname"),"app");
L("out") << G("$inputhead") << " "

	<< rightjustifynum(L("currgood"),4)
	<< "/"
	<< rightjustifynum(L("currtot"),4)
	<< " = "
	<< rightjustifynum(100 * L("currgood") / L("currtot"),3)

	<< "  "

	<< rightjustifynum(L("allgood"),6)
	<< "/"
	<< rightjustifynum(L("alltot"),6)
	<< " = "
	<< rightjustifynum(100 * L("allgood") / L("alltot"),3)

	<< "\n"
	;
# Update overall scores.
replaceval(G("scorepos"),"allgood",L("allgood"));
replaceval(G("scorepos"),"alltot",L("alltot"));
@@CODE
