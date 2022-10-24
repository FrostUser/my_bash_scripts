# Environment file to use with local_rpm
# (if you are installing all of your rpm files info $HOME/opt)


export PATH="$HOME/opt/bin:$PATH"
export PATH="$HOME/opt/usr/bin:$PATH"
export PATH="$HOME/opt/usr/local/autoconf/2.69/bin/:$PATH"
export CPATH="$HOME/opt/include:$CPATH"
export CPATH="$HOME/opt/usr/include:$CPATH"
export CPATH="$HOME/opt/usr/include/gtk-2.0/:$CPATH"
export CPATH="$HOME/opt/usr/lib/gtk-2.0/include/:$CPATH"
export LD_LIBRARY_PATH="$HOME/opt/lib:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH="$HOME/opt/usr/lib:$LD_LIBRARY_PATH" # For runtime
export LD_RUN_PATH="$LD_LIBRARY_PATH"
export CMAKE_LIBRARY_PATH="$LD_LIBRARY_PATH"
export CMAKE_INCLUDE_PATH="$CPATH"
export LIBRARY_PATH="$LD_LIBRARY_PATH" # For g++ linking

export PYTHONPATH="$HOME/opt/lib/python2.6/site-packages/gtk-2.0:$PYTHONPATH"
# export PYTHONHOME="$HOME/opt:$PYTHONHOME"

export FRIBIDI_LIBS="-L$HOME/opt/usr/lib"
export FRIBIDI_CFLAGS="-I$HOME/opt/usr/include/fribidi"

# For WAF
# export LIBPATH="$HOME/opt/lib"
# export STLIBPATH="$HOME/opt/lib"
# export CFLAGS="-I$HOME/opt/include:$CPPFLAGS"
export CPPFLAGS="-I$HOME/opt/include -I$HOME/opt/usr/include -I$HOME/opt/usr/include/python2.6 -I$HOME/opt/usr/include/libwnck-1.0 -I$HOME/opt/usr/include/glib-2.0/ $CPPFLAGS"
export CPPFLAGS="-I$HOME/opt/usr/lib/glib-2.0/include -I$HOME/opt/usr/include/gdk-pixbuf-2.0 -I$HOME/opt/usr/include/cairo -I$HOME/opt/usr/include/pango-1.0 -I$HOME/opt/usr/include/atk-1.0 $CPPFLAGS"
export CPPFLAGS="-I$HOME/opt/usr/include/pygtk-2.0 $CPPFLAGS"
export LDFLAGS="-L$HOME/opt/lib -L$HOME/opt/usr/lib $LDFLAGS"

export PERL5LIB="$HOME/opt/lib/perl5/site_perl/5.26.1:$HOME/opt/lib"
export PERL5LIB="$HOME/opt/lib/perl5/5.26.1:$PERL5LIB"
export PERL5LIB="$HOME/opt/usr/share/perl5:$PERL5LIB"
export PERL5LIB="$HOME/opt//usr/local/autoconf/2.69/share/autoconf:$PERL5LIB"
export PERLLIB="$HOME/opt/lib"

export M4="$HOME/opt/usr/bin/m4"
export AC_MACRODIR="$HOME/opt/usr/local/autoconf/2.69/share/autoconf"

export PKG_CONFIG_PATH="$HOME/opt/lib/pkgconfig/"
export PKG_CONFIG_PATH="$HOME/opt/usr/lib/pkgconfig/"

export PYGTK_CFLAGS="-I$HOME/opt/usr/include"
export PYGTK_LIBS="-L$HOME/opt/usr/lib/pygtk/2.0"

export WNCK_CFLAGS="-I$HOME/opt/usr/include"
export WNCK_LIBS="-L$HOME/opt/usr/lib"

export PYTHONPATH="$HOME/opt/usr/lib/python2.6/site-packages:$PYTHONPATH"
export PYTHONPATH="$HOME/opt/lib/python2.6/site-packages:$PYTHONPATH"

# alias tmux='tmux -2'

