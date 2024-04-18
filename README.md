# Debian: Woman Edition
## As seen on the internet!

This is what I used to make my seminal [Women Will Literally Install Debian](https://www.youtube.com/watch?v=Dyz6vOn8qn8) video. 

I'll hopefully have time to make this beter later, but the end result is that you wind up a with a customized Debian ISO that boots, automatically installs to a RAM disk, and restarts to start the whole process over again. It's the logical endpoint of a joke I started about "women will literally install Debian" starting from the time I, a woman, installed Debian. (I [sell stickers](https://princess.software/order/), by the way.) The point here is to get philosophical. If women will literally install Debian, if the computer installs Debian automatically, does that make it a woman? Makes you think.

### If you just want my premade ISO to play with:

Feel free to download the [torrent](https://github.com/Kansattica/DebianWomanEdition/raw/princess/debian-12.5.0-amd64-women.iso.torrent) in this repository or use [the equivalent magnet link](https://github.com/Kansattica/DebianWomanEdition/blob/princess/magnet.url). Sorry about the indirection- Github doesn't like making clickable magnet links. I would upload it somewhere if I could, but, alas. Bandwidth. Get in touch if you want to be an official Debian: Woman Edition mirror.



### How I did it and how you can make your own:

This is not a super elegant way to do what I did, but the basic idea is:

1. Make a [preseed file](https://www.debian.org/releases/stable/amd64/apbs02.en.html) that answers all the questions, skips stuff you don't need like network setup, and sets up a ram disk to put stuff in. The ramdisk stuff involves copying the appropriate kernel module somewhere the installer kernel can see it. Probably a better way to do it (for one thing, it's already on the install media somewhere!), but it does work. Probably going to break if you use install media with a different kernel! I just copied the module from my existing Debian system.
2. Add the preseed file to the ISO. (You can [add it to the initramfs](https://wiki.debian.org/DebianInstaller/Preseed/EditIso), but you might be able to get away with just putting it on the root of the drive.)
3. Tell the kernel to look there on startup (this involves editing the GRUB config to put Automated Install first, by the way. Lost a lot of time on that one.)
4. That should about do it! Enjoy Debian!

The unpack and repack scripts should do the heavy lifting- they're adapted from the excellent writing on the subject [provided by the Debian project](https://wiki.debian.org/RepackBootableISO). I only tested these for amd64 UEFI, so you're on your own for everything else. The idea is that you should be able to:

1. Unpack your install media (only tested with [debian-12.5.0-amd64-DVD-1.iso](https://cdimage.debian.org/debian-cd/current/amd64/iso-dvd/)) with `unpack.sh`.
2. Use something like `patch -s -p0 < woman.diff` to update the stuff you just unpacked. Haven't tested this myself, but it should work. If it doesn't, the links in the last numbered list have some good guidance on making changes. You can also do whatever you want here, this is the only step that's specific to doing the specific weird thing I want to do. The other two should be generally helpful.
3. Repack it with `repack.sh`. Note that `repack.sh` looks for a directory called `isofiles` and that `isohdpfx.bin` file in the current directory.
4. If you have qemu installed, `start-vm` helps a lot to test things before you write it to a flash drive.
5. `dd if=debian-12.5.0-amd64-women.iso of=/dev/sdX bs=4096 status=progress` to write it your flash drive.

