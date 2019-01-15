Author: Heiko Robert
# 01/14/2019
# http://www.ecm4u.de
##################################################################


# requires ar from binutils:
# apt install binutils

OLDPWD=$PWD # save current path
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

if [ -f $DIR/vib.env ];then
    . $DIR/vib.env
fi

vibversion="${version}"

mkdir -p $DIR/dist

cd $DIR/$STAGE_ROOT
STAGE_DIRS=$(ls -d *)
FILE_LIST=$(find $STAGE_DIRS -type f)

get_xml_filelist () {
    echo "    <file-list>"
    for dir in $FILE_LIST; do
        find $dir -not -path '*/\.*' -type f | while read file;do
            echo "        <file>${file}</file>"
        done
    done
    echo "    </file-list>"
}
XML_FILELIST=$(get_xml_filelist $FILE_LIST)

tar -cf $DIR/dist/${module_name:0:8} -C $DIR/$STAGE_ROOT $STAGE_DIRS # tar name is limited to 8 chars
cd $DIR/dist
TAR_SHA1=$(sha1sum ${module_name:0:8} | cut -d" " -f1)

gzip ${module_name:0:8}
mv ${module_name:0:8}.gz ${module_name:0:8}
GZIP_SHA256=$(sha256sum ${module_name:0:8} | cut -d" " -f1)
GZIP_SIZE=$(du --bytes ${module_name:0:8} | cut -f1)

touch sig.pkcs7

eval "echo \"$(cat $DIR/descriptor.xml.tmpl)\"" > $DIR/dist/descriptor.xml

ar -r $module_name-${vibversion}.vib descriptor.xml sig.pkcs7 ${module_name:0:8}

echo "FINISHED"
echo ""
echo "you could deploy the new vib by running:"
echo "scp dist/$module_name-${vibversion}.vib root@$esxserver:/tmp/"
echo "ssh root@$esxserver \"esxcli software vib remove -f -n $module_name\""
echo "ssh root@$esxserver \"esxcli software vib install -f -v /tmp/$module_name-${vibversion}.vib\""

cd $OLDPWD
