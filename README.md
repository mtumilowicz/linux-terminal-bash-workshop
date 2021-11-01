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

## preface
* goals of this workshops

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
  * tilde expansion
    * echo ~username -> /home/username
      * check if username is valid, if yes - convert to user's home directory
    * echo ~root -> /root
* commands are just text you type in the terminal
* commands are interpreted by the shell
* shell is a program that interprets the commands you type in your terminal
and passes them on to the operating system
  * the purpose of the shell is to make it more convenient
  for you to issue commands to your computer
  * the terminal is the window to the shell
* commands structure
  * commandName options inputs
  * echo $PATH
    * in what directories the shell will search for a specific command
    * example: which echo
      * type -a echo
        * echo is a shell builtin
        * echo is /usr/bin/echo
          * /usr/bin/echo 'Hello' or echo 'Hello'
    * that's how the shell knows where to find your commands
    * commandNames need to be on the shell's search path
  * chaining options
    * date -a -b -c -d -e -f -g
    * same as: date -abcdefg
    * option names
      * long: date --universal
      * short: date -u
  * there can be input for options
    * cal -A 1 12 2017
      * cal (-A 1) 12 2017: 1 is input for A option
      * cal -A=1 -B=1 12 2017
* open: ctrl alt t
* close: ctrl d
* terminal: user@computerName:~$
  * `~` shortcut for current user home directory
  * tilde expansion
    * echo ~username -> /home/username
      * check if username is valid, if yes - convert to user's home directory
    * echo ~root -> /root
* search in history
    * ctrl r
* suggestions: double tap TAB

### data streams
* data streams
  * standard input
  * standard output
  * standard error
  * data streams can be redirected from their default locations to wherever you wish
  * you can redirect the standard output of one commands to the standard input of another
    in a process known as piping
* How many ways in total are there to get data into and out of a command?
  * standard input (2): cmd arguments and standard
  * standard output (2): error and standard
  * What is Standard Output Connected to By Default?
    * terminal
  * What is the Standard Input Data Stream Connected to by default?
    * the keybord
* cat 1> output.txt
  * standard input: 0
  * standard output: 1
    * shortcut: cat > output.txt
      * by default removes everything from the file before writing
      * appends: cat >> output.txt
  * standard error: 2
    * cat -k bla 2>> error.txt
    * no error in terminal
  * program &>> result.txt
    * Redirect and append both stdout and stderr to file result.txt
  * discard stdout: > /dev/null

### commands
* history - list history of commands
    * then !1 - chose first and executes
    * !! - most recent cmd
    * !v latest cmd that starts with v
    * !. latest cmd that start with .
* tty
  * prints the file name of the terminal connected to standard input
* cut
  * file: A B C D / E F G H
  * cut < date.txt --delimiter " " --fields 1
    * output: A / E
  * When not specified, the default delimiter is “TAB”.
  * split only by single character
  * cut
    * cut -d "." -f1 // delimited by . and only first column
      * cut -d "." -f1-3 // delimited by . and range
    * cut c1 file // first char only
    * cut c1-4 file // fetch only first 4 from a line
      * cut c5- file // since 5 to the end
    * --complement - negate
      * example --complement f1-3 means skip 1-3 columns
    * -s // skip incorrect data
* cat
  * use cases
    * view content
    * create new file with content
      * cat > FileWithContent enter then insert content ctr c
    * copy content of 1 file to another
      * cat file > file2
      * cat file1 file2 > file3
    * copy content of more than 1 file to another
    * append data
      * cat file1 >> file2
  * cat is a standard Unix utility that reads files sequentially, writing them to standard output.
    * The name is derived from its function to concatenate files.
* tee
  * redirection of stdout breaks pipeline
    * to save a data snapshot without breaking pipelines use the tree command
* echo
* pwd
    * $oldpwd - prev directory
    * ~+ for pwd
    * ~- for oldpwd
* ls
      * ls -F (shows differences between dirs and files)
        * directories: Downloads/
        * files: file.txt - without "/"
      * ls -a
        * all stuff even hidden files / directories
        * always `.` and `..`
          * cd . - stay where it is
            * . folder refers to this
          * cd .. - go to parent folder
            * .. folder refers to parent folder
* cd
  * return to home
* file tux.png
  * shows type of the file
  * if you change the name of the file to xxx.jpg it still prints png
    * filetype is in the header
    * in linux file extensions doesn't matter
    * if you name xxx.blablabla it will load the program to open the file
    from header (blablabla cannot be find), but if you call it xxx.txt it will
    make a shortcut and use txt player
* wildcards
  * `*`
    * ls Documents/ Downloads/ Pictures/
    * ls Do* Pi*
    * matches all
  * ?
    * matches 1 place
  * [123456]
    * ls file[12345].txt
    * matches 1 place
    * [1-9]
    * ls file[1-9][1-9]
  * https://tldp.org/LDP/GNU-Linux-Tools-Summary/html/x11655.htm
  * http://www.linfo.org/wildcard.html
  * cd /var/www
    * for FILE in *.html
    * for FILE in /var/www/*.html
* creating files and directories
  * touch file1
    * create empty file
  * mkdir folder
    * create folder
    * mkdir a/b/c - cannot create
      * mkdir -p /a/b/c - create whole path even if dir doesn't exist
    * mkdir {a,b,c,d,e,f}_{1,2,3}
      * mkdir {a,b,c,d,e,f}_{1..3}
      * brace expansion
      * touch {a,b,c,d,e,f}_{1..3}/file{1..100}
        * create in each directory a file
    * ls {a,b,c,d,e,f}_{1..3}
* deleting
  * rm
    * remove file
  * rm -r
    * remove directory
    * rm -ri
      * asks interactively if delete each file
  * rmdir
    * removes if empty
* copying
  * cp sourceFile targetFile
  * cp sourceFile targetFile targetDir
  * cp destination/* .
    * to this folder
    * . means current folder
  * cp destination/* ..
    * to parent folder
  * cp -r source target
    * for copying dirs
* renaming and moving (mv)
  * mv oldName newName
    * works for dirs
  * mv oldFolder/* .
  * mv oldFolder ./newfolder
    * moves all from oldFolder to newfolder
  * search for files (locate)
    * https://osxdaily.com/2011/11/02/enable-and-use-the-locate-command-in-the-mac-os-x-terminal/
    * locate *.log
    * locate -S
      * database info
    * updatedb
      * sudo updatedb (to run as an root)
        * sudo - super user do
      * very fast but requires updating
      * add --existing and -follow options
      * best thing to do is just update the database (done automatically daily)
  * sophisticated search tasks (find)
    * find
      * list all files, unlimited depth
      * doesn't use database
    * find . -maxdepth 1
    * find . -maxdepth 1 -type d // directory
    * find . -maxdepth 1 -type f // file
    * find . -name "5.txt"
      * find . -name "*.txt"
      * find . -iname "*.txt" // case insensitive
    * find / -type f -size +100k // more than 100 kb
    * find / -type f -size +100k -size -5M // more than 100 kb and less than 5 mb
    * find / -type f -size +100k | wc -l
      * count
    * find / -type f -size +100k -size -5M -exec {} target \;
      * copy all files into directory
    * find / -type f -size +100k -size -5M -ok {} target \;
      * asks every time
    * find haystack/ -type f -name "needle.txt" -exec mv what where \;
  * view
    * cat - shortcut for concatenate
      * cat file1.txt // print to standard outuput
      * cat file1.txt file2.txt file3.txt // concatenates all files
      * cat file[1-5].txt
    * tac - reverse of cat
      * reads all file from the end but does not affect text on any line
      * flips upside down
    * rev - reverse lines
      * cat ... | rev
    * less file
      * cat file | less
      * scroll line by line
    * cat file | head
      * show by default 10
      * cat file | head -n 2
    * cat file | tail
  * sort
    * sort words.txt
    * sort -r words.txt
      * sort words.txt | tac
    * sort -n numbers.txt // sort by whole number not lexicographical
    * sort -u number.txt // unique
    * ls -l /etc | head -n 20 | sort -k 5nr // by 5th column by number and reverse
      * ls -lh /etc | head -n 20 | sort -k 5hr // by 5th column by human readable data and reverse
      * ls -lh /etc | head -n 20 | sort -k 5Mr // by 5th column by month and reverse
  * searching file content
    * grep textToSearch file // find all lines containing e
    * grep -c e hello.txt // how many lines containing e
    * grep -i e hello.txt // case insensitive
    * grep -v e hello.txt // dont have e
    * ls hello/ | grep hello.txt
  * archiving
    * tar -cvf filename.tar file[1..3].txt
      * c – create an archive file
      * v – show the progress of the archive file
      * f – filename of the archive file
    * file ourarchive.tar
      * checks if it's a tarball
    * tar -tf ourarchive.tar
      * t – viewing the content of the archive file
    * tar -xvf ourarchive.tar
      * x - extract
  * compression
    * gzip
      * gzip ourarchive.tar // compressed in place
      * gunzip ourarchive.tar // uncompress in place
    * bzip2
    * zip archive.zip file[1..3].txt
      * unzip ...
    * tar -cvzf archive.tar.gz ... // z - gzip
      * tar -xvzf archive.tar.gz // extract gzip
    * tar -cvjf archive.tar.bz2 ... // z - bzip2
      * tar -xjzf ... // extract
  * xargs
    * converts input from standard input into arguments to a command
    * date | xargs echo
      * print current date
    * cat filestodelete.txt | xargs rm
* sed
    * sed 's/search-pattern/replacement-string/flags' doc
    * replaces toReplace -> Replace
    * sed 's/a/b/' 'a'
      * -> 'b'
    * doesn't modify the original file
    * replace only first occurence
      * set/a/b/g
      * use g flag
  * awk
    * operations
      1. scans a file line by line
      2. splits each input line into fields
      3. compares input line/fields to pattern
      4. performs action(s) on matched lines
    * used for
      * transform (processing, manipulating, formatting) data files
      * searching
      * produce reports
    * fetch column from space separated file
      * fetch any specific column data and print
        * awk '{print $1}' file
          * you could use printf
        * awk '{print $1 "," $2}' file
        * awk -F '.' '{print $1 "," $2}' file // separator
        * without first line: command | tail -n +2
        * awk 'NR>=122 && NR<=129 { print }' // for row numbers
        * awk '$1>5 { print }' // filtering by column
        * awk '/gmail.com/{ print }' // fetch the row if gmail.com appears anywhere in the row
        * awk '!/gmail.com/{ print }' // fetch the row not if gmail.com appears anywhere in the row
        * awk '$5~"Co"{ print }' // if 5 column starts with
        * awk '$5~/e/{ print }' // contains e somewhere
        * awk '$5~/^A/ && $5~/n$/ { print }' // contains e somewhere
        * awk '{ if ($3 > 200) print $0;}' // contains e somewhere
        * awk 'BEGIN{print "XXX"}END{"YYY"}' // prints XXX at the beginning then actions then YYY
        * awk 'BEGIN{count=0}{count=count+1}END{"YYY"}' // declaring variable
      * replace
        * sub - only 1 occurrence
        * gsub(oldValue, newValue, column) - all occurrences
    * storing in a variable
      * a=awk ...
  * SED - stream editor
    * display and edit data
    * options: insert / add / delete
    * display specific line
      * sed -n '3p' file // 3rd row
      * sed -n '$p' file // last line
      * sed -n '2,4p' file // range of lines
    * search
      * sed -n '/Amit/p' file
    * replace
      * sed 's/old/new/' file // single data
      * sed -e 's/old/new/' -e's/old/new/' file
      * sed '/condition/s/old/new/' file
    * delete
      * sed '/data/d' file // deleSte with all with data
    * add
      * sed '1 a #This is just a commented line' sedtest.txt
    * while Sed is used to process and modify text, Awk is mostly used as a tool for analysis and reporting
    * write to the file
      * sed -n '/pattern/w targetFile' file
* grep
  * grep -i wordToSeach file
  * grep -i -v wordToExclude file
  * grep -c // count
  * grep -n // line number
  * grep -B 1 // display line before
  * grep -A 1 // display line after
  * grep -C 5 // preceding and following rows
  * grep -l // show file name
  * grep -v // without text
  * grep -w // exact word
  * grep -e text1 -e text2 // multiple words
  * grep toSearch "." // in the current location
  * egrep - extended grep
* cut
  * cut -d "." -f1 // delimited by . and only first column
    * cut -d "." -f1-3 // delimited by . and range
  * cut c1 file // first char only
  * cut c1-4 file // fetch only first 4 from a line
    * cut c5- file // since 5 to the end
  * --complement - negate
    * example --complement f1-3 means skip 1-3 columns
  * -s // skip incorrect data

## bash
* bash = most commonly used linux shell today
* what is script
  * a shell script is a file containing commands for the shell
* different shells can interpret same text different ways
* aliases
  * aliases go in a .bash_aliases file in your home folder
  * alias getdates="..."

## workshop
### filesystem
1. Create two files:

   $ touch blah1
   $ touch blah2
1. Enter some data into them:

   $ echo "Cat" > blah1
   $ echo "Dog" > blah2
1. And as expected:

   $cat blah1; cat blah2
   Cat
   Dog
1. Let's create hard and soft links:

   $ ln blah1 blah1-hard
   $ ln -s blah2 blah2-soft
1. Let's see what just happened:

   $ ls -l

   blah1
   blah1-hard
   blah2
   blah2-soft -> blah2
1. Changing the name of blah1 does not matter:

   $ mv blah1 blah1-new
   $ cat blah1-hard
   Cat
1. blah1-hard points to the inode, the contents, of the file - that wasn't changed.

   $ mv blah2 blah2-new
   $ ls blah2-soft
   blah2-soft
   $ cat blah2-soft
   cat: blah2-soft: No such file or directory
1. Similarly, If blah1 is deleted, blah1-hard still holds the contents; if blah2 is deleted, blah2-soft is just a link to a non-existing file.
### terminal
* tty
    * open two terminals
    * type `tty` in each
    * in terminal1
        * cat < test.txt > /dev/pts/1 // address of terminal2
    * in terminal2 - it should appear
### bash
* create 100 dir with 100 files each and put needle.txt somewhere
  * random: echo ${RANDOM}
* find that file and move to desktop
  * using grep