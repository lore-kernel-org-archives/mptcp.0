Content-Type: multipart/mixed; boundary="===============5722464688175961673=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 1/2] selftests: mptcp: add option to specify
 size of file to transfer
Date: Tue, 30 Jun 2020 21:24:44 +0200
Message-ID: <20200630192445.18333-2-fw@strlen.de>
In-Reply-To: 20200630192445.18333-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4874

--===============5722464688175961673==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The script generates two random files that are then sent via tcp and
mptcp connections.

In order to compare throughput over consecutive runs add an option
to provide the file size on the command line: "-f 128000".

Also add an option, -t, to enable tcp tests. This is useful to
compare throughput of mptcp connections and tcp connections.

Example: run tests with a 4mb file size, 300ms delay 0.01% loss,
default gso/tso/gro settings and with large write/blocking io:

mptcp_connect.sh -t -f $((4 * 1024 * 1024)) -d 300 -l 0.01%  -r 0 -e "" -m =
mmap

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 .../selftests/net/mptcp/mptcp_connect.sh      | 52 ++++++++++++++-----
 1 file changed, 39 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index acf02e156d20..8f7145c413b9 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -3,7 +3,7 @@
 =

 time_start=3D$(date +%s)
 =

-optstring=3D"S:R:d:e:l:r:h4cm:"
+optstring=3D"S:R:d:e:l:r:h4cm:f:t"
 ret=3D0
 sin=3D""
 sout=3D""
@@ -21,6 +21,8 @@ testmode=3D""
 sndbuf=3D0
 rcvbuf=3D0
 options_log=3Dtrue
+do_tcp=3D0
+filesize=3D0
 =

 if [ $tc_loss -eq 100 ];then
 	tc_loss=3D1%
@@ -40,9 +42,11 @@ usage() {
 	echo -e "\t-e: ethtool features to disable, e.g.: \"-e tso -e gso\" (defa=
ult: randomly disable any of tso/gso/gro)"
 	echo -e "\t-4: IPv4 only: disable IPv6 tests (default: test both IPv4 and=
 IPv6)"
 	echo -e "\t-c: capture packets for each test using tcpdump (default: no c=
apture)"
+	echo -e "\t-f: size of file to transfer in bytes (default random)"
 	echo -e "\t-S: set sndbuf value (default: use kernel default)"
 	echo -e "\t-R: set rcvbuf value (default: use kernel default)"
 	echo -e "\t-m: test mode (poll, sendfile; default: poll)"
+	echo -e "\t-t: also run tests with TCP (use twice to non-fallback tcp)"
 }
 =

 while getopts "$optstring" option;do
@@ -94,6 +98,12 @@ while getopts "$optstring" option;do
 	"m")
 		testmode=3D"$OPTARG"
 		;;
+	"f")
+		filesize=3D"$OPTARG"
+		;;
+	"t")
+		do_tcp=3D$((do_tcp+1))
+		;;
 	"?")
 		usage $0
 		exit 1
@@ -449,20 +459,25 @@ make_file()
 {
 	local name=3D$1
 	local who=3D$2
+	local SIZE=3D$filesize
+	local ksize
+	local rem
 =

-	local SIZE TSIZE
-	SIZE=3D$((RANDOM % (1024 * 8)))
-	TSIZE=3D$((SIZE * 1024))
+	if [ $SIZE -eq 0 ]; then
+		local MAXSIZE=3D$((1024 * 1024 * 8))
+		local MINSIZE=3D$((1024 * 256))
 =

-	dd if=3D/dev/urandom of=3D"$name" bs=3D1024 count=3D$SIZE 2> /dev/null
+		SIZE=3D$(((RANDOM * RANDOM + MINSIZE) % MAXSIZE))
+	fi
 =

-	SIZE=3D$((RANDOM % 1024))
-	SIZE=3D$((SIZE + 128))
-	TSIZE=3D$((TSIZE + SIZE))
-	dd if=3D/dev/urandom conv=3Dnotrunc of=3D"$name" bs=3D1 count=3D$SIZE 2> =
/dev/null
+	ksize=3D$((SIZE / 1024))
+	rem=3D$((SIZE - (ksize * 1024)))
+
+	dd if=3D/dev/urandom of=3D"$name" bs=3D1024 count=3D$ksize 2> /dev/null
+	dd if=3D/dev/urandom conv=3Dnotrunc of=3D"$name" bs=3D1 count=3D$rem 2> /=
dev/null
 	echo -e "\nMPTCP_TEST_FILE_END_MARKER" >> "$name"
 =

-	echo "Created $name (size $TSIZE) containing data sent by $who"
+	echo "Created $name (size $(du -b "$name")) containing data sent by $who"
 }
 =

 run_tests_lo()
@@ -497,9 +512,11 @@ run_tests_lo()
 		return 1
 	fi
 =

-	# don't bother testing fallback tcp except for loopback case.
-	if [ ${listener_ns} !=3D ${connector_ns} ]; then
-		return 0
+	if [ $do_tcp -eq 0 ]; then
+		# don't bother testing fallback tcp except for loopback case.
+		if [ ${listener_ns} !=3D ${connector_ns} ]; then
+			return 0
+		fi
 	fi
 =

 	do_transfer ${listener_ns} ${connector_ns} MPTCP TCP ${connect_addr} ${lo=
cal_addr}
@@ -516,6 +533,15 @@ run_tests_lo()
 		return 1
 	fi
 =

+	if [ $do_tcp -gt 1 ] ;then
+		do_transfer ${listener_ns} ${connector_ns} TCP TCP ${connect_addr} ${loc=
al_addr}
+		lret=3D$?
+		if [ $lret -ne 0 ]; then
+			ret=3D$lret
+			return 1
+		fi
+	fi
+
 	return 0
 }
 =

-- =

2.26.2

--===============5722464688175961673==--
