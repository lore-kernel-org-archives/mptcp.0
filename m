Content-Type: multipart/mixed; boundary="===============3235341206232086445=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: selftests: Add capture option
Date: Fri, 03 May 2019 16:16:40 -0700
Message-ID: <20190503231640.26954-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 1114

--===============3235341206232086445==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Added a "-c" command line option for mptcp_connect.sh to make it easier
to capture packets from each test. The script will use tcpdump to create
one .pcap file per test case, named according to the namespaces,
protocols, and connect address in use. For example, the first test case
writes the capture to ns1-ns1-MPTCP-MPTCP-10.0.1.1.pcap

The stderr output from tcpdump is printed after the test completes to
show tcpdump's "packets dropped by kernel" information.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 .../selftests/net/mptcp/mptcp_connect.sh      | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index 0f283cd37225..ee478e94d8a2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -6,6 +6,7 @@ sout=3D""
 cin=3D""
 cout=3D""
 ksft_skip=3D4
+capture=3D0
 =

 TEST_COUNT=3D0
 =

@@ -13,12 +14,19 @@ cleanup()
 {
 	rm -f "$cin" "$cout"
 	rm -f "$sin" "$sout"
+	rm -f "$capout"
 =

 	for i in 1 2 3 4; do
 		ip netns del ns$i
 	done
 }
 =

+for arg in "$@"; do
+    if [ "$arg" =3D "-c" ]; then
+	capture=3D1
+    fi
+done
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
@@ -29,6 +37,7 @@ sin=3D$(mktemp)
 sout=3D$(mktemp)
 cin=3D$(mktemp)
 cout=3D$(mktemp)
+capout=3D$(mktemp)
 trap cleanup EXIT
 =

 for i in 1 2 3 4;do
@@ -105,6 +114,7 @@ do_transfer()
 =

 	:> "$cout"
 	:> "$sout"
+	:> "$capout"
 	ip netns exec ${connector_ns} ping -q -c 1 $connect_addr >/dev/null
 	if [ $? -ne 0 ] ; then
 		echo "$listener_ns -> $connect_addr connectivity [ FAIL ]" 1>&2
@@ -113,6 +123,21 @@ do_transfer()
 =

 	printf "%-4s %-5s -> %-4s (%s:%d) %-5s\t" ${connector_ns} ${cl_proto} ${l=
istener_ns} ${connect_addr} ${port} ${srv_proto}
 =

+	if [ $capture -eq 1 ]; then
+	    if [ -z $SUDO_USER ] ; then
+		capuser=3D""
+	    else
+		capuser=3D"-Z $SUDO_USER"
+	    fi
+
+	    capfile=3D"${listener_ns}-${connector_ns}-${cl_proto}-${srv_proto}-${=
connect_addr}.pcap"
+
+	    ip netns exec ${listener_ns} tcpdump -i any -s 65535 -B 32768 $capuse=
r -w $capfile > "$capout" 2>&1 &
+	    cappid=3D$!
+
+	    sleep 1
+	fi
+
 	ip netns exec ${listener_ns} ./mptcp_connect -t 10 -l -p $port -s ${srv_p=
roto} 0.0.0.0 < "$sin" > "$sout" &
 	spid=3D$!
 =

@@ -126,6 +151,11 @@ do_transfer()
 	wait $spid
 	rets=3D$?
 =

+	if [ $capture -eq 1 ]; then
+	    sleep 1
+	    kill $cappid
+	fi
+
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		echo "[ FAIL ] client exit code $retc, server $rets" 1>&2
 		echo "\nnetns ${listener_ns} socket stat for $port:" 1>&2
@@ -133,6 +163,7 @@ do_transfer()
 		echo "\nnetns ${connector_ns} socket stat for $port:" 1>&2
 		ip netns exec ${connector_ns} ss -nita 1>&2 -o "dport =3D :$port"
 =

+		cat "$capout"
 		ret=3D$rets
 		return 1
 	fi
@@ -144,9 +175,11 @@ do_transfer()
 =

 	if [ $retc -eq 0 ] && [ $rets -eq 0 ];then
 		echo "[ OK ]"
+		cat "$capout"
 		return 0
 	fi
 =

+	cat "$capout"
 	return 1
 }
 =

-- =

2.21.0


--===============3235341206232086445==--
