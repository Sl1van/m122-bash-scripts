for char1 in {a..z} {0..9} ; do
    for char2 in {a..z} {0..9} ; do
        for char3 in {a..z} {0..9} ; do
            unzip -oq -P "$char1$char2$char3" vollsicher.zip
            if [ $? -eq 0 ]; then
                echo "pw found"
                echo "$char1$char2$char3"
                exit 0
            fi
            for char4 in {a..z} {0..9} ; do
                unzip -oq -P "$char1$char2$char3$char4" vollsicher.zip
                if [ $? -eq 0 ]; then
                    echo "pw found"
                    echo "$char1$char2$char3$char4"
                    exit 0
                fi
                for char5 in {a..z} {0..9} ; do
                    unzip -oq -P "$char1$char2$char3$char4$char5" vollsicher.zip
                    if [ $? -eq 0 ]; then
                        echo "pw found"
                        echo "$char1$char2$char3$char4$char5"
                        exit 0
                    fi
                done
            done
        done        
    done
done