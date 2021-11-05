# bash-workshop
* references
    * https://www.udemy.com/course/linux-mastery/
    * https://www.udemy.com/course/linux-shell-scripting-projects/
    * https://www.udemy.com/course/bash-scripting/
    * https://www.udemy.com/course/bash-mastery/
    * https://www.udemy.com/course/advance-unix-commands
    * https://medium.com/factualopinions/process-substitution-in-bash-739096a2f66d
    * https://www.cyberciti.biz/tips/understanding-unixlinux-file-system-part-i.html
    * https://www.cyberciti.biz/tips/understanding-unixlinux-filesystem-directories.html
    * https://www.cyberciti.biz/tips/understanding-unixlinux-filesystem-inodes.html
    * https://www.cyberciti.biz/tips/description-of-linux-file-system-directories.html
    * https://www.cyberciti.biz/tips/understanding-unixlinux-symbolic-soft-and-hard-links.html
    * https://www.interserver.net/tips/kb/linux-binary-directories-explained/
    * https://www.javatpoint.com/linux-home-directory
    * https://www.bluematador.com/blog/what-is-an-inode-and-what-are-they-used-for
    * https://medium.com/@307/hard-links-and-symbolic-links-a-comparison-7f2b56864cdd
    * https://askubuntu.com/questions/108771/what-is-the-difference-between-a-hard-link-and-a-symbolic-link
    * https://stackoverflow.com/questions/5607542/why-does-find-exec-mv-target-not-work/5607677
    * https://www.microsoft.com/en-us/download/details.aspx?id=37003
    * https://unix.stackexchange.com/questions/85461/piping-search-term-not-filename-to-grep
    * https://unix.stackexchange.com/questions/521775/how-to-debug-trace-bash-function
    * https://unix.stackexchange.com/questions/138463/do-parentheses-really-put-the-command-in-a-subshell
    * https://www.gnu.org/software/bash/manual/html_node/Command-Substitution.html

## preface
* goals of this workshops
    1. introduction to linux filesystem
        * files
        * directories
        * permissions
        * symbolic links
        * hard links
    1. introduction to command line
        * standard commands with examples
        * data streams (with redirection)
    1. workshop tasks are in `workshop` file and the answers are in `answers` file

## linux filesystem
* file is a collection of data items stored on disk
    * is always associated with devices like hard disk, floppy disk, USB pen drive and more
    * inode
        * is a file data structure that stores information about any file except its name and data
        * stores the file’s metadata, including all the storage blocks on which the file’s data can be found
            * if you save a file that exceeds a standard block, your computer will find the next available segment
            on which to store the rest of your file
                * over time, that can get super confusing
* directory is a group of files
    * two types
        * root directory
            * only one root directory
            * denoted by `/`
            * root of your entire file system tree
        * sub directory
            * directory under root
    * inside every directory, you will find out two default sub-directories
        * `.` – current directory
        * `..` – pointer to previous directory
            * directory immediately above the current one I am in now
    * some typical directories
        * `/` - root directory
        * `/bin` - executable programs which are needed in single user mode
            * contains common commands like cat, cp, cd, ls, etc.
        * `/dev` - files, which refer to physical devices such as hard disk, keyboard, monitor, mouse and modem etc
        * `/etc`- all your system configuration files in it
        * `/home` - for a particular user of the system and consists of individual files
        * `/lib` - hold shared libraries that are necessary to boot the system and to run the commands
        * `/opt` - contains packages not part of the Operating System distribution, but provided by an independent source
        * `/root` - home directory for the root user
        * `/tmp` - temporary files which may be deleted with no notice
* permissions
    * four groups X(XXX)(XXX)(XXX)
        * example: drwxr-xr-x
    * group 1: type
        * `-`: regular file
        * `d`: directory
        * `l`: symbolic link
        * `s`: socket
    * group 2: owner permissions
        * `r`: read only file permission
        * `w`: write only file permission
        * `x`: execute only file permission
        * `–`: no permission
    * group 3: group permissions
    * group 4: other permissions
* symbolic link vs hard link
    * symbolic link
        * shortcut that reference to a file instead of its inode value
        * like a shortcut in Windows
        * can be seen as a static link to the last known location of the original file
    * hard links
        * direct reference to a file via its inode
        * only files and not directories

## terminal
* terminal: user@computerName:~$
  * `~` shortcut for current user home directory
* commands are just text you type in the terminal
* commands are interpreted by the shell
    * shell - program that interprets the commands and passes them on to the operating system
* the terminal is the window to the shell
* commands structure
    * commandName options inputs
    * `echo $PATH`
        * in what directories the shell will search for a specific command
        * example: `which echo`
            * echo is /usr/bin/echo
            * you could type /usr/bin/echo 'Hello' or echo 'Hello'
            * type -a echo
                * echo is a shell builtin
        * that's how the shell knows where to find your commands
        * commandNames need to be on the shell's search path
    * there can be input for options
        * `cal -A 1 12 2017`
          * `cal (-A 1) 12 2017`: 1 is input for A option
          * `cal -A=1 -B=1 12 2017`
* open: ctrl alt t
* close: ctrl d
* terminal: `user@computerName:~$`
  * `~` shortcut for current user home directory
* search in history
    * ctrl r
* suggestions: double tap TAB

### data streams
* types
    * standard input
    * standard output
    * standard error
* redirections
    * data streams can be redirected from their default locations to wherever you wish
    * piping: redirecting the standard output of one commands to the standard input of another
    * example
        * standard input: 0
            * `wc -l < test.txt`
        * standard output: 1
            * discard stdout: `> /dev/null` // or `1> /dev/null` > is just a shortcut
                * `/dev/null` is known as the null device
                * whatever you write to `/dev/null` will be discarded
        * standard error: 2
            * `cat -k bla 2>> error.txt` // k not existing option
            * no error in terminal
        * `&>> result.txt`
            * redirect and append both stdout and stderr to file result.txt
* ways to get data into and out of a command
    * standard input (2)
        * cmd arguments and standard
    * standard output (2)
        * error and standard
    * standard output is connected by default to terminal
    * standard input is connected by default to the keybord

### commands
* history
    * list history of commands
    * then !1 - chose first and executes
    * !! - most recent cmd
    * !v latest cmd that starts with v
    * !. latest cmd that start with .
* cut
    * used to extract sections from each line of input — usually from a file
    * cut -d "." -f1 // delimited by . and only first column
        * default delimiter is "TAB"
        * split only by single character
    * cut -d "." -f1-3 // delimited by . and range
    * cut c5- file // since 5 to the end
* cat
    * name derived from its function to concatenate files
    * view content
        * cat file
    * create new file with content
        * cat > FileWithContent then enter then insert content ctr c
    * copy content of 1 file to another
        * cat file > file2
        * cat file1 file2 > file3
    * append data
        * cat file1 >> file2
* tee
    * save a data snapshot without breaking pipeline
        * redirection of stdout breaks pipeline
    * find "4DOS" wikipedia.txt | tee 4DOS.txt | sort > 4DOSsorted.txt
        * searches the file wikipedia.txt for any lines containing the string "4DOS"
        * makes a copy of the matching lines in 4DOS.txt
        * sorts the lines
        * writes them to the output file 4DOSsorted.txt
* touch filename
    * create empty file
* pwd
    * writes the full pathname of the current working directory
    * $oldpwd - prev directory
    * ~+ for pwd
    * ~- for oldpwd
* ls
    * list files or directories
    * ls -F (shows differences between dirs and files)
        * directories: Downloads/
        * files: file.txt - without "/"
    * ls -a
        * plus hidden files / directories
* cd
    * change directory
    * cd dirName
    * cd
        * return to home
* file filename
    * shows type of the file
    * if you change the name of the file to xxx.jpg it still prints png
        * in linux file extensions doesn't matter
* wildcards
  * `*`
    * matches zero or more occurrences
    * ls Documents/ Downloads/ Pictures/
        * same as: ls Do* Pi* // assuming that there are only
  * ?
    * matches single occurrence
    * ls file?.txt
  * [123456]
    * matches 1 place
    * ls file[12345].txt
* mkdir folder
    * create folder
    * mkdir -p /a/b/c
        * create whole path even if dir doesn't exist
        * mkdir a/b/c - error
* rm
    * remove file
* rm -r
    * remove directory
    * rmdir - removes if empty
* cp source target
    * used for copying files and directories to another location
    * cp a.txt b.txt
    * cp -r source target
        * for copying dirs
* mv source target // for files and directories
    * moves files or directories from one place to another
    * mv foo.txt bar.txt
        * rename foo.txt to bar.txt
    * mv file1.txt file.2.txt file3.txt folder
* locate *.log
    * search for files
        * doesn't read the file system for the searched file or directory name
        * refers to a database (prepared by the command updatedb)
    * very fast but requires updating
        * updatedb
            * sudo updatedb (to run as an root)
        * sudo - super user do
        * done automatically daily
* find haystack/ -type f -name "needle.txt" -exec command {} \;
    * used to find files and directories and perform subsequent operations on them
    * for each result, command {} is executed
        * all occurences of {} are replaced by the filename
* less file
    * displays the contents of a file or a command output, one page at a time
* head/tail file
    * display the beginning of a text file or piped data
* sort words.txt
    * sort -r words.txt // sort words.txt | tac
    * sort -n numbers.txt // sort by number not lexicographical
    * sort -u number.txt // unique
    * sort -k 2 employee.txt
    * sort -t : -k 2n employee.txt
        * set delimiter to `:` // default is blank spaces
* grep textToSearch file
    * used for searching plain-text data sets for lines that match a regular expression
    * grep -v textToSearch fileToSearchIn // line that does not have textToSearch
    * grep -f - fileToSearchIn
        * -f tells grep to obtain its search pattern from a file and - tells it that this file is actually stdin
* tar
    * create, extract, or list files from a tar file
    * tar -cvf filename.tar file[1..3].txt
        * c – create an archive file
        * v – show the progress of the archive file
        * f – filename of the archive file
        * t – viewing the content of the archive file
    * tar -xvf ourarchive.tar
        * x - extract
    * compression
        * gzip
            * gzip ourarchive.tar // compressed in place
            * gunzip ourarchive.tar // uncompress in place
            * tar -cvzf archive.tar.gz ... // z - gzip
            * tar -xvzf archive.tar.gz // extract gzip
* xargs
    * converts input from standard input into arguments to a command
    * cat file | xargs echo // vs echo file
* sed 's/search-pattern/replacement-string/flags' file
    * display and edit data
    * edit
        * sed 's/a/b/' 'a'
          * result: 'b'
        * doesn't modify the original file
        * replace only first occurrence
        * g flag
            * replace all
    * display
        * sed -n '3p' file // 3rd row
        * sed -n '2,4p' file // range of lines
* awk
    * operations
        1. scans a file line by line
        2. splits each input line into fields
        3. compares line/fields to pattern
        4. performs action(s) on matched lines
    * used for
        * transform (processing, manipulating, formatting) data files
        * searching
        * produce reports
    * awk '{print $1}' file
    * awk '{print $1 "," $2}' file
    * awk -F '.' '{print $1 "," $2}' file // separator
    * awk 'NR>=122 && NR<=129 { print }' // for row numbers
    * awk '$1>5 { print }' // filtering by column
* sed vs awk
    * sed is used to process and modify text, awk is used for analysis and reporting

## bash
* conventions
    * https://google.github.io/styleguide/shellguide.html
* bash = most commonly used linux shell today
* what is script
    * a shell script is a file containing commands for the shell
    * different shells can interpret same text different ways
* `#!/bin/bash` // first line; use bash to interpret this file
    * path to the bash shell: which bash
    * # = sharp, ! = bang, #! = shebang
* declaring variables
* control structures
* arguments
    * $1 // without default
    * ${1:-foo} // with default
* options
* intercepting output of commands
    * `$(command)`
    * called command substitution
        * bash performs the expansion by executing command in a subshell environment
        and replacing the command substitution with the standard output of the command
    * subshell starts out as an almost identical copy of the original shell process
        * under the hood, the shell calls the fork system call, which creates a new process
        whose code and memory are copies
        * in particular, they have the same variables
        * subshell is thus different from executing a script
* debugging
    * add lines before section you want to debug
        ```
        set -x // print commands and their arguments as they are executed
        set -v // print shell input lines as they are read
        ```
    * other flags: `help set`
* traps