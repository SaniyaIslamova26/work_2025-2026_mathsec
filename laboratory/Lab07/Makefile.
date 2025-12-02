SRC = presentation.md
PDF_FILE = presentation.pdf
HTML_FILE = presentation.html
DOCX_FILE = presentation.docx

# Для Windows используем pandoc с wkhtmltopdf
PDF_ENGINE = --pdf-engine=wkhtmltopdf
BEAMER_OPTIONS = -t beamer --slide-level=2
THEME_OPTIONS = -V theme:default -V mainfont="Arial"

# Основные цели
all: pdf html docx

pdf: $(PDF_FILE)
html: $(HTML_FILE)
docx: $(DOCX_FILE)

# Правила сборки
$(PDF_FILE): $(SRC)
	pandoc "$<" $(PDF_ENGINE) $(BEAMER_OPTIONS) $(THEME_OPTIONS) -o "$@"

$(HTML_FILE): $(SRC)
	pandoc "$<" -t revealjs -V theme=white --self-contained -o "$@"

$(DOCX_FILE): $(SRC)
	pandoc "$<" -o "$@"

# Просмотр
view-pdf:
	start $(PDF_FILE)

view-html:
	start $(HTML_FILE)

view-docx:
	start $(DOCX_FILE)

# Очистка
clean:
	del $(PDF_FILE) $(HTML_FILE) $(DOCX_FILE)

# Помощь
help:
	@echo "Доступные команды:"
	@echo "  make all     - создать PDF, HTML и DOCX"
	@echo "  make pdf     - создать только PDF"
	@echo "  make html    - создать только HTML"
	@echo "  make docx    - создать только DOCX"
	@echo "  make view-*  - открыть файл"
	@echo "  make clean   - удалить созданные файлы"
	@echo "  make help    - показать эту справку"
