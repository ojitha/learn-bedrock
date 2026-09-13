# Detect OS for sed in-place flag
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
  SED_INPLACE := sed -i ''
else
  SED_INPLACE := sed -i
endif

blogsSources := 2025-08-29-BedrockLangGraph \
	2026-09-13-BedrocClaude_1
source += $(blogsSources)

files := $(foreach wrd,$(source),$(wrd).md)
all: $(files)

# Function to create ipynb --> md
define make-markdown
$1.md : $1.ipynb
	@echo "-------------------------"
	@echo "Converting $$< -> $$@"
	@echo "-------------------------"
	cd .. && jupyter nbconvert --HTMLExporter.sanitize_html=true blogs/$$< --to markdown \
		--template-file=blogs/custom_markdown.tpl \
		--TagRemovePreprocessor.remove_input_tags="['remove_input','remove_output']" \
		--NbConvertApp.output_files_dir=./blogs/assets/images/$1 \
		--ExtractOutputPreprocessor.output_filename_template='fig_{index}{extension}'

	$(SED_INPLACE) -E 's#(!\[[^]]*\]\().*/blog/assets/images#\1https://raw.githubusercontent.com/ojitha/blog/master/assets/images#g' $$@
	$(SED_INPLACE) -E 's/\x1B\[[0-9;]*[mK]//g' $$@
	$(SED_INPLACE) -E 's/\(\.\/assets/\(\/assets/g' $$@
	@echo "Processing mermaid diagrams..."
	awk '/^{% raw %}$$$$/ {in_raw=1} in_raw==1 {gsub(/</, "\\&lt;"); gsub(/>/, "\\&gt;")} /^{% endraw %}$$$$/ {in_raw=0} {print}' $$@ > $$@.tmp && mv $$@.tmp $$@
endef

# Generate the rules for each source file
$(foreach element,$(blogsSources),$(eval $(call make-markdown,$(element))))

cleanmarkdown = $(shell rm $1.md)	

# Clean target
clean:
	@echo "cleaning ..."
	$(foreach element,$(blogsSources),$(eval $(call cleanmarkdown,$(element))))
