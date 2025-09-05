file=$1
echo "Running script: $file"
if [ -f "$file".ipynb ]; then
    echo " File $file does exist. :-)"
    # python convert_notebook.py $file.ipynb
    jupyter nbconvert --to markdown --TagRemovePreprocessor.remove_input_tags="['remove_input','remove_output']" "$file".ipynb --output "$file".md
    sed -i '' -E 's/\x1B\[[0-9;]*[mK]//g' "$file".md
    cp "$file".md  ~/GitHub/ojitha.github.io/_drafts
    if [ $? -eq 0 ]; then
        echo "Post creation successful."
    else
        echo "Error: Post creation failed."
    fi
else
    echo "Error: File $file does not exist."
    exit 1
fi
echo "Script execution completed."
exit 0