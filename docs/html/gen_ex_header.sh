#! /bin/sh -e

cat << HERE
<ul id="submenu">
HERE
for i in $@; do
	title=`./gen_text.sh $i`
	echo "  <li class=\"menu-item\"><a href=\"$i\">$title</a></li>"
done

cat << HERE
</ul>
HERE
