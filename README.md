WMPyCalc
========

Add the number in the selection or execute the selection as Python and store 
the result in register 0.

Examples
--------

Example:

	Select 4*.2 and do :PyCal

Example:

	Select the column of numbers and do :PyCal
	- Description one       +12.38
	- Description two       +31.54
	- Description three     -22.23
	- Description four      +12.00

Example:

	Select the lines underneath and do :PyCmd
	for i in range(4):
	   print str(i)

Settings
--------

Change the register the result is saved to to @p by adding the following to 
your .vimrc:

    let g:WMPyCalc_register='p'

Contact
-------

Wannes Meert  
<http://people.cs.kuleuven.be/wannes.meert>  
Wim De Smet  
<http://people.cs.kuleuven.be/wim.desmet>


License
-------

FreeBDS License
Copyright (c) 2011, Wannes Meert and Wim De Smet (KULeuven).  
All rights reserved.

