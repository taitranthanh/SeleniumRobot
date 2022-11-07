===Installation====
1. Install python
2. Install pip
3. Install library
	pip install robotframework
	pip install robotframework-seleniumlibrary


==Start automation====
This is supporting on both normal mode and headless mode

* Run with headless mode
	robot -v BROWSER:HeadlessChrome --loglevel TRACE:INFO -b debug.txt --outputdir reports/ tests/

*Run with normal mode
	robot --loglevel TRACE:INFO -b debug.txt --outputdir reports/ tests/
