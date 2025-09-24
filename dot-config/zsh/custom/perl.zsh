# PERL ==================================================

# perl stuff? I only vaguely remember what this was for
# syntax is definitely for osx
# I think this was for haskell
PATH="/Users/Andrew/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/Andrew/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/Andrew/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/Andrew/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/Andrew/perl5"; export PERL_MM_OPT;
[ -f "/Users/Andrew/.ghcup/env" ] && source "/Users/Andrew/.ghcup/env" # ghcup-env

