#!/bin/sh

# ${#parameter}
# 上面这种可以获得字符串的长度。

# ${parameter%word} 最小限度从后面截取word
# ${parameter%%word} 最大限度从后面截取word
# ${parameter#word} 最小限度从前面截取word
# ${parameter##word} 最大限度从前面截取word
# 上面4个就是用来截取字符串的方法了。

if [ $# != 0 ]; then
	param=$1
	# 判断后缀
	if [ "${param#*.}" == "tar.xz.des3" ]; then
		echo decompression...
		openssl des3 -d -k '123456' -salt -in $* | tar Jxvf -
	else
		echo compression...
		tar Jcvf - $* | openssl des3 -salt -k '123456' -out ${param%%.*}.tar.xz.des3
	fi
fi
