Dubsacks Vim — Syntastic Wrapper
================================

About This Plugin
-----------------

A simple wrapper around the fantastic
`Syntastic <https://github.com/scrooloose/syntastic>`__
plugin, which checks your code for syntax and style errors
when you open and save source files, or on demand.

Install Plugin
--------------

Standard Pathogen installation:

.. code-block:: bash

   cd ~/.vim/bundle/
   git clone https://github.com/landonb/dubs_syntastic_wrap.git

Or, Standard submodule installation:

.. code-block:: bash

   cd ~/.vim/bundle/
   git submodule add https://github.com/landonb/dubs_syntastic_wrap.git

Online help:

.. code-block:: vim

   :Helptags
   :help dubs-syntastic-wrap

Install Checkers
----------------

You'll need to install syntax checkers to use this tool.

And you'll want to be selective about which checkers you
choose, so the following is not a recommendation of any
specific tools, it's just an example.

Example Checker Installation: Pylint
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Installing the Python linter,
`Pylint <http://www.pylint.org/>`__,
is simple.

.. code-block:: bash

   sudo apt-get install -y pylint

Example Checker Installation: Jshint
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Installing the JavaScript syntax checker,
`jshint <http://jshint.com/>`__, which runs atop
`Node.js <http://nodejs.org/>`__,
is a tad more complicated.

Start with node's package manager,
`npm <https://www.npmjs.com/>`__.

.. code-block:: bash

   sudo apt-get install -y npm

Next, download and compile ``node``.

.. code-block:: bash

   cd path/to/your/opt/.downloads/
   wget -N http://nodejs.org/dist/v0.10.35/node-v0.10.35.tar.gz
   tar -xvzf node-v0.10.35.tar.gz
   cd node-v0.10.35
   ./configure
   make

Install node.
And install from root, lest ``sudo make install`` leaves
your node files unaccessible to the general user population.

.. code-block:: bash

   sudo su -
   cd path/to/your/opt/.downloads/node-v0.10.35
   make install

Finally, use ``npm`` to install ``jshint``.

.. code-block:: bash

   sudo su -
   npm install -g jshint

Painfully Easy Usage
--------------------

In a Vim window, type ``<Ctrl-e>`` to run Syntastic on the buffer
and open the location list if their are errors, and type
Ctrl-e again to close the location list.

* Note that nothing happens if there are no errors,
  or if the filetype is not associated with any checkers.

* Also, if you use the quickfix window, closing it can
  cause the height of the Syntastic location list to grow.
  The Dubsacks plugin, ``dubs_quickfix_wrap``, makes sure to
  resize the location list window when the quickfix window is
  closed, otherwise the height of the location list increases
  relative to the height of the quickfix window that was closed.

Other Configuration
^^^^^^^^^^^^^^^^^^^

The plugin also configures Syntastic to the author's liking:

.. code-block:: vim

   " Auto-open :Error(s) window when errors are detected.
   let g:syntastic_auto_loc_list = 1
   " Stick detected errors into location-list.
   let g:syntastic_always_populate_loc_list = 1

   " Automatically check files on open and save,
   " but only in 'active' mode (set next).
   let g:syntastic_check_on_open = 1
   let g:syntastic_check_on_wq = 1

   " If you don't like files being automatically linted when opened or
   " saved, it's easy to use Ctrl-e to run the checker and then again
   " to hide its output, so we indicate all filetypes as passive.
   let g:syntastic_mode_map = {
         \ "mode": "passive",
         \ "active_filetypes": [],
         \ "passive_filetypes": ["python", "javascript", "html", "rst"] }

Note: I've only got a few checkers setup; you'll probably want to add more.

Hint: Use ``:SyntasticToggleMode`` to switch between 'active' and 'passive'.

I assume most people will like the previous setup.

However, if you feel strongly that a file should be checked whenever
it's saved, I suggest that (a) you're not saving as often
as you should (or maybe you're not used to the days
of power outages equaling data loss), (b) showing the
Syntastic error window is disruptive, and (c) alternatively
leaving the error window showing consumes valuable screen
real estate or at least is distracting.

The remaining configuration is less universal;
you may find yourself wanting to change or expand
this configuration.

- I've remapped the Python executable to use Python3.

.. code-block:: vim

   let g:syntastic_python_python_exec = "/usr/bin/python3"

(I know this isn't ideal; it's on my list to find or write
a plugin that'll set ``g:syntastic_python_python_exec``
based on the project in which a file resides.)

- I've changed a few of the default checkers.
  Mostly to use a checker that's less strict
  and to just check syntax errors,
  and to not care so much about style.

.. code-block:: vim

   let g:syntastic_python_checkers = ['python']
   let g:syntastic_javascript_checkers = ['jshint']

Features Bound to Key Commands
------------------------------

==================================  ==================================  ==============================================================================
Key Mapping                         Description                         Notes
==================================  ==================================  ==============================================================================
 ``<Ctrl-E>``                       Toggle Syntastic checker            Toggles the `Syntastic <https://github.com/scrooloose/syntastic>`__ plugin.
                                                                        Calls either ``:SyntasticCheck`` or ``:SyntasticReset``, depending on
                                                                        whether or not the current window has a location list or not.
==================================  ==================================  ==============================================================================

