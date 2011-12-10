" USACO 文件头自动生成,并加入相关代码（只限C/C++)
" 格式：
" /*
" ID: odayfan1
" LANG: C++
" TASK: gift1
" */
function! NewUsacoTask( Task, ...)
	call setline(1,'/*')
	" if not specify language or id, use defaults
	let id = 'odayfan1'
	let lang = 'C'
	if a:0 == 1
		let id = a:1
	else
		if a:0 == 2
			let lang = a:2
		endif
	endif
	" write content
	call setline(2,'ID: '.id)
	call setline(3,'LANG: '.lang)
	call setline(4,'TASK: '.a:Task)
	call setline(5,'*/')
	" insert commen codes only for cpp
	if lang !=? 'c++' && lang !=? 'c'
		exec "echo 'Not C/C++'"
		return
	endif
	call append(line('$'),"")
	if lang ==? 'c++'
		call append(line('$'),"#include <iostram>")
		call append(line('$'),"#include <fstream>")
		call append(line('$'),"#include <cstdlib>")
		call append(line('$'),"#include <cstring>")
		call append(line('$'),"")
		call append(line('$'),"using namespace std;")
		let ext=".cpp"
		:set filetype=cpp
	elseif lang ==? 'c'
		call append(line('$'),"#include <stdio.h>")
		call append(line('$'),"#include <stdlib.h>")
		call append(line('$'),"#include <string.h>")
		call append(line('$'),"#include <math.h>")
		let ext=".c"
		:set filetype=c
	endif

	call append(line('$'),"")
	call append(line('$'),"int main() {")
	call append(line('$'),"//	freopen(\"".a:Task.".in\",\"r\",stdin);")
	call append(line('$'),"//	freopen(\"".a:Task.".out\",\"w\",stdout);")
	call append(line('$'),"	")
	call append(line('$'),"	return 0;")
	call append(line('$'),"}")

	call cursor(line('$')-2,1)
	:startinsert!
	exec "cd usaco"
	exec ":w! ".a:Task.ext
	exec ":up"
	exec ":e! ".a:Task.ext
	call setline(1,"/* file: " .expand("%"))
	exec "echomsg 'Current directory changed to ".getcwd()."'"
endfunction

function NNewUsacoTask()
	"let ID="odayfan1"
	let Task=input("Task: ")
	let Lang=input("LANG: ","C++")
	let ID=input("ID: ","odayfan1")
	if Task==""
		exec 'echoe "You must specify a task name!"'
		return
	endif
	call NewUsacoTask(Task,ID,Lang)
endfunction

function AddCommonCode(site,code)
		call setline(1,"")
		call setline(2,"/* ".toupper(a:site)." Problem Code: ".a:code." */")
		call setline(3,"#include <stdio.h>")
		call setline(4,"#include <stdlib.h>")
		call setline(5,"#include <string.h>")
		call setline(6,"#include <math.h>")
		call setline(7,"")
		call setline(8,"int main() {")
		call setline(9,"	")
		call setline(10,"	return 0;")
		call setline(11,"}")
endfunction


function NewNormalTask(site,ProbCode)
	exec "cd ".a:site
	if a:ProbCode!=""
		let ProblemCode=toupper(a:ProbCode)
	else
		let ProblemCode=input("Problem Code: ")
	endif
	call AddCommonCode(a:site,ProblemCode)
	let FileName=ProblemCode.".c"
	call setline(1,"/* file: ".FileName." */")
	exec ":w! ".FileName
	exec ":e! ".FileName
	call cursor(line('$')-2,1)
	exec ":start"
endfunction

function NewTask(Site,TaskName,...)
	let sp_mode = get(a:000,0,"NOSPLIT")
	if sp_mode==?"sp"
		exec ":sp"
	elseif sp_mode==?"vsp"
		exec ":vsp"
	endif

	exec ":e! ".a:TaskName

	if a:Site==?"usaco"
		call NewUsacoTask(a:TaskName)
	else
		call NewNormalTask(a:Site,a:TaskName)
	endif
endfunction


function OpenTask(Site,Taskname,...)
	exec "cd ".a:Site
	let Fname=toupper(a:Taskname)
	
	if filereadable(Fname.".c")
		let Filename=Fname.".c"
	elseif filereadable(Fname.".cpp")
		let Filename=Fname.".cpp"
	else
		exec ":echoerr 'Task file Not Found!'"
		return
	endif

	let sp_mode = get(a:000,0,"NOSPLIT")
	if sp_mode==?"sp"
		exec ":sp! ".Filename
		return
	elseif sp_mode==?"vsp"
		exec ":vsp! ".Filename
		return
	endif
	exec ":e! ".Filename
endfunction

" 自定义名令Ntask，新建一个Task
command -nargs=+ Ntask call NewTask(<f-args>)
" 打开一个已经存在的Task
command -nargs=+ Etask call OpenTask(<f-args>)

