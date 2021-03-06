if [ ! -z "$1" -a "$1" != " " ]
then
    EXTRACT_APP_PATH=$1
    # echo $EXTRACT_APP_PATH
    if [ -d "$EXTRACT_APP_PATH" ]
    then
        EXTRACT_APP_NAME="$(ls $1/ | grep .app)"
        # echo $EXTRACT_APP_NAME
        if [ ! -z "$EXTRACT_APP_NAME" -a "$EXTRACT_APP_NAME" != " " ]
        then
            echo "Found application bundle : $EXTRACT_APP_NAME"
            EXTRACT_DIR=${EXTRACT_APP_NAME::-4}
            # echo $EXTRACT_DIR
            if [ -d "$EXTRACT_DIR" ]; then
                rm -rf $EXTRACT_DIR
            fi
            echo "- Create a working directory"
            mkdir $EXTRACT_DIR
            mkdir $EXTRACT_DIR/Payload
            echo "- Copy application bundle to a working directory"
            cp -R $EXTRACT_APP_PATH/$EXTRACT_APP_NAME $EXTRACT_DIR/Payload
            cd $EXTRACT_DIR
            echo "- Build an IPA file"
            zip -rq $EXTRACT_APP_NAME.ipa Payload
            cd ..
            mv $EXTRACT_DIR/$EXTRACT_APP_NAME.ipa .
            echo "- Remove the working directory"
            rm -rf $EXTRACT_DIR
            echo "Done."
            echo ""
            echo "IPA: $EXTRACT_APP_NAME.ipa"
            echo ""
        else
            echo "Error: application .app directory DOES NOT exists."
        fi
    else
        echo "Error: application bundle directory DOES NOT exists."
    fi
else
    echo "Usage: ./extract-ipa.sh /path/of/bundle"
fi
