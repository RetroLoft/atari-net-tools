# Network tools for the Atari ST

Small TOS programs for the [STinG](https://github.com/th-otto/STinG) TCP/IP stack. They
run on a plain ST with 1 MB and TOS 1.02 or later: no GEM, no C library, a few KB each.

Any network connection that STinG supports works, for example
[ACSI2TNFS](https://github.com/RetroLoft/ACSI2TNFS) (Wi-Fi through the ACSI port), an
Ethernet adapter or a serial PPP/SLIP link.

## URLVIEW.TTP

Shows the source of a web page, a screen at a time, the way the desktop shows a text
file. Nothing is written to disk.

```text
URLVIEW info.cern.ch
URLVIEW http://192.168.1.10:8000/notes.txt
URLVIEW -h example.com          also show the HTTP headers
```

- Start it from the desktop as a `.TTP` and type the address, or leave the parameter
  empty and it asks for one.
- `http://` is optional; upper and lower case do not matter for it or the host name. The
  path is sent as typed (some servers care about upper and lower case there).
- `-Meer-` at the bottom of the screen: any key shows the next screen. **Control-C** quits
  at once, also while the page is loading; the connection is closed properly.
- The screen size comes from the system, so it works in every resolution.
- **http only, not https:** encryption (TLS) is not feasible on a 68000. Many sites
  redirect to https; URLVIEW then shows the status line and the new address.
- Characters outside ASCII (UTF-8: é, ü, …) show as `?`.

Good pages to try: `info.cern.ch` (the first website), or any web server on your own
network (`python -m http.server` on a PC serves a folder on port 8000).

## Requirements

- STinG 1.26 with a working connection (`PING.PRG` to your router works).
- A name server in STinG's `DEFAULT.CFG` (`NAMESERVER = ...`) for host names.

## Building

With the [m68k-atari-mint](https://tho-otto.de/crossmint.php) cross compiler:

```text
make
```

The programs are compiled with `-mshort` (STinG's functions take 16-bit ints) and
without the C library: `src/start.S` sets up a stack and gives the rest of the memory
back; screen and keyboard go through the BIOS, so GEMDOS cannot end a program with
Control-C while a connection is still open.

| Path | |
|---|---|
| `src/urlview.c` | URLVIEW |
| `src/start.S` | start-up code for programs without the C library |
| `include/transprt.h` | STinG client API, from the STinG developer kit (Peter Rottengatter, Ronald Andersson) |
