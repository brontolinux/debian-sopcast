SPAUTH_TGZ := sp-auth.tgz
SPAUTH_URL :=  http://download.sopcast.com/download/$(SPAUTH_TGZ)
PLAYER_TGZ := sopcast-player-0.8.5.tar.gz
PLAYER_URL := https://sopcast-player.googlecode.com/files/$(PLAYER_TGZ)

all: add_arch_i386 /usr/lib/i386-linux-gnu/libstdc++.so.5 /usr/lib/libgettextlib-0.19.3.so /usr/lib/x86_64-linux-gnu/gtk-2.0/modules/libcanberra-gtk-module.so /usr/lib/python2.7/dist-packages/gtk-2.0/gtk/glade.so /usr/local/bin/sp-sc-auth /usr/local/bin/sopcast-player

PHONY: add_arch_i386 clean realclean distclean all

add_arch_i386:
	-sudo /usr/bin/dpkg --add-architecture i386
	sudo apt-get update

/usr/local/bin/sp-sc-auth: sp-auth/sp-sc-auth /usr/bin/sudo
	sudo cp sp-auth/sp-sc-auth /usr/local/bin

sp-auth/sp-sc-auth: $(SPAUTH_TGZ)
	/bin/tar xvzmf sp-auth.tgz

sp-auth.tgz: /usr/bin/wget
	/usr/bin/wget --no-use-server-timestamps $(SPAUTH_URL)

/usr/local/bin/sopcast-player: /usr/lib/i386-linux-gnu/libstdc++.so.5 /usr/lib/libgettextlib-0.19.3.so $(PLAYER_TGZ) /usr/bin/sudo
	/bin/tar xvzmf $(PLAYER_TGZ)
	( cd sopcast-player && make PREFIX=/usr/local && sudo make install PREFIX=/usr/local )
	sudo gtk-update-icon-cache -f -t /usr/local/share/icons/hicolor

sopcast-player-0.8.5.tar.gz: /usr/bin/wget
	/usr/bin/wget --no-use-server-timestamps $(PLAYER_URL)

/usr/bin/wget:
	sudo apt-get -y install wget

/bin/tar:
	sudo apt-get -y install tar

/usr/lib/i386-linux-gnu/libstdc++.so.5:
	sudo apt-get -y install libstdc++5:i386

/usr/lib/libgettextlib-0.19.3.so:
	sudo apt-get -y install gettext

/usr/lib/x86_64-linux-gnu/gtk-2.0/modules/libcanberra-gtk-module.so:
	sudo apt-get -y install libcanberra-gtk-module

/usr/lib/python2.7/dist-packages/gtk-2.0/gtk/glade.so:
	sudo apt-get -y install python-glade2

/usr/bin/sudo:
	sudo apt-get -y install sudo

clean:
	-rm -rf sopcast-player sp-auth

realclean: clean
	-rm -f $(SPAUTH_TGZ)* $(PLAYER_TGZ)*

distclean: realclean /usr/bin/sudo
	-/usr/bin/sudo rm /usr/local/bin/sp-sc-auth /usr/local/bin/sopcast-player
