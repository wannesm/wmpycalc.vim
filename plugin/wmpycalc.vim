" Author: Wannes Meert
" Date: 2011/11/20

" Example:
" Select 4*.2 and do :PyCal
"
" Example:
" Select the column of numbers and do :PyCal
" - Description one       +12.38
" - Description two       +31.54
" - Description three     -22.23
" - Description four      +12.00
"
" Example:
" - Description one        12.38
" - Description two        31.54
" - Description three     -22.23
" - Description four       12.00
"
" Example:
" Select the lines underneath and do :PyCmd
" for i in range(4):
"    print str(i)
"

function! WMVisualSelection()
	try
		let a_old = @a
		normal! gv"ay
		return @a
	finally
		let @a = a_old
	endtry
endfunction


" Perform arithmetics through python and stores the result in register 0
function! PythonCalc()
	let expr = WMVisualSelection()
python << endpython
import vim
expr = vim.eval("expr")
#print(expr)
newsignexp = ["\n", "\r", " "]
ignore = ["\n", "\r"]
nexpr = ""
expectsign = True
foundsign = False
for c in expr:
	if c.isdigit() or c == ".":
		if expectsign and not foundsign:
			nexpr += "+"
		expectsign = False
		foundsign = False
		nexpr += c
	else:
		if c in newsignexp:
			expectsign = True
		else:
			foundsign = True
		if c not in ignore:
			nexpr += c
result = eval(nexpr)
print expr+" = "+str(result)+" (@0)"
vim.command('let @0 = "'+str(result)+'"')
endpython
endfunction
com! -nargs=0 -range PyCalc :call PythonCalc()
map <Leader>pc :PyCalc<CR>


" Perform arbitrary python command and store the result in register 0
function! PythonCommand()
	try
		let expr = WMVisualSelection()
		let a_old = @a
		redir @a
python << endpython
import vim
expr = vim.eval("expr")
exec expr
#print str(result)+"\n(@0)"
#vim.command('let @0 = "'+str(result)+'"')
endpython
	redir END
	let @0 = @a
	echo "Result in register @0"
	"normal gv
	"normal "0p
	finally
		let @a = a_old
	endtry
endfunction
com! -nargs=0 -range PyCmd :call PythonCommand()
map <Leader>pcc :PyCmd<CR>

