USER_FILE=$SHELL_ROOT/user.sh
if [ -f $USER_FILE ] ; then
  source $USER_FILE
fi

function uninit_local()
{
  echo "#user defined" > $USER_FILE
  echo "CUR_PROJECT_ROOT=" >> $USER_FILE
  CUR_PROJECT_ROOT=
  ANDROID_ROOT=
}

function init_local()
{
  if [ "$CUR_PROJECT_ROOT" = "" ] ; then
    echo "pls input your chipcode path,eg /home/xxx/qmss19"
    echo -n ":"
    local cc_path
    read cc_path
    if [ -d "$cc_path" ] ; then
      CUR_PROJECT_ROOT=$cc_path
    else
      CUR_PROJECT_ROOT="$cc_path don't exist!"
    fi
  fi

  ANDROID_ROOT="$CUR_PROJECT_ROOT/LINUX/android"

  if [ ! -d "$ANDROID_ROOT" ] ; then
    ANDROID_ROOT="$CUR_PROJECT_ROOT"
  fi

  android_xml_cur=`ls -l $ANDROID_ROOT/.repo/manifest.xml \
    | awk '{print $11}'`

  if [ $android_xml_cur ] ; then
    dump
    write_local_to_user
  else
    echo "$cc_path is not seam tobe a chipcode or android path!"
    echo "choose again..."
    uninit_local
  fi
}

function write_local_to_user()
{
  echo "#user defined" > $USER_FILE
  echo "CUR_PROJECT_ROOT=$CUR_PROJECT_ROOT" >> $USER_FILE
}

function dump()
{
  echo CUR_PROJECT_ROOT=$CUR_PROJECT_ROOT
  echo ANDROID_ROOT=$ANDROID_ROOT
  echo android_xml_cur=$android_xml_cur
}

init_local
