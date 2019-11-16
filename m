Content-Type: multipart/mixed; boundary="===============0685390040847021641=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 07/10] selftests:mptcp: avoid global var clash
Date: Sat, 16 Nov 2019 13:59:33 +0100
Message-ID: <20191116125936.3563275-8-matthieu.baerts@tessares.net>
In-Reply-To: 20191116125936.3563275-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2568

--===============0685390040847021641==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With bash, variables are global by default.

Some functions were declaring local variables, some not. Unified this to
avoid anoying problems in the future.

Also fix indentation around the capture feature.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    to be squashed in "mptcp: add basic kselftest for mptcp"

 .../selftests/net/mptcp/mptcp_connect.sh      | 90 ++++++++++---------
 1 file changed, 50 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index 8f5844c2f4cd..a8c55005cc0c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -90,6 +90,7 @@ cleanup()
 	rm -f "$sin" "$sout"
 	rm -f "$capout"
 =

+	local netns
 	for netns in "$ns1" "$ns2" "$ns3" "$ns4";do
 		ip netns del $netns
 	done
@@ -178,9 +179,9 @@ set_random_ethtool_flags() {
 	local flags=3D""
 	local r=3D$RANDOM
 =

-	pick1=3D$((r & 1))
-	pick2=3D$((r & 2))
-	pick3=3D$((r & 4))
+	local pick1=3D$((r & 1))
+	local pick2=3D$((r & 2))
+	local pick3=3D$((r & 4))
 =

 	[ $pick1 -ne 0 ] && flags=3D"tso off"
 	[ $pick2 -ne 0 ] && flags=3D"$flags gso off"
@@ -208,9 +209,9 @@ print_file_err()
 =

 check_transfer()
 {
-	in=3D$1
-	out=3D$2
-	what=3D$3
+	local in=3D$1
+	local out=3D$2
+	local what=3D$3
 =

 	cmp "$in" "$out" > /dev/null 2>&1
 	if [ $? -ne 0 ] ;then
@@ -226,6 +227,7 @@ check_transfer()
 =

 check_mptcp_disabled()
 {
+	local disabled_ns
 	disabled_ns=3D"ns_disabled-$sech-$(mktemp -u XXXXXX)"
 	ip netns add ${disabled_ns} || exit $ksft_skip
 =

@@ -254,7 +256,8 @@ check_mptcp_disabled()
 =

 check_mptcp_ulp_setsockopt()
 {
-	local t=3D"ns_ulp-$sech-$(mktemp -u XXXXXX)" retval=3D
+	local t retval
+	t=3D"ns_ulp-$sech-$(mktemp -u XXXXXX)"
 =

 	ip netns add ${t} || exit $ksft_skip
 	if ! ip netns exec ${t} ./mptcp_connect -u -p 10000 -s TCP 127.0.0.1 2>&1=
; then
@@ -271,9 +274,9 @@ check_mptcp_ulp_setsockopt()
 =

 do_ping()
 {
-	listener_ns=3D"$1"
-	connector_ns=3D"$2"
-	connect_addr=3D"$3"
+	local listener_ns=3D"$1"
+	local connector_ns=3D"$2"
+	local connect_addr=3D"$3"
 =

 	ip netns exec ${connector_ns} ping -q -c 1 $connect_addr >/dev/null
 	if [ $? -ne 0 ] ; then
@@ -305,13 +308,14 @@ wait_local_port_listen()
 =

 do_transfer()
 {
-	listener_ns=3D"$1"
-	connector_ns=3D"$2"
-	cl_proto=3D"$3"
-	srv_proto=3D"$4"
-	connect_addr=3D"$5"
-	local_addr=3D"$6"
-
+	local listener_ns=3D"$1"
+	local connector_ns=3D"$2"
+	local cl_proto=3D"$3"
+	local srv_proto=3D"$4"
+	local connect_addr=3D"$5"
+	local local_addr=3D"$6"
+
+	local port
 	port=3D$((10000+$TEST_COUNT))
 	TEST_COUNT=3D$((TEST_COUNT+1))
 =

@@ -319,45 +323,50 @@ do_transfer()
 	:> "$sout"
 	:> "$capout"
 =

+	local addr_port
 	addr_port=3D$(printf "%s:%d" ${connect_addr} ${port})
 	printf "%.3s %-5s -> %.3s (%-20s) %-5s\t" ${connector_ns} ${cl_proto} ${l=
istener_ns} ${addr_port} ${srv_proto}
 =

 	if $capture; then
-	    if [ -z $SUDO_USER ] ; then
-		capuser=3D""
-	    else
-		capuser=3D"-Z $SUDO_USER"
-	    fi
+		local capuser
+		if [ -z $SUDO_USER ] ; then
+			capuser=3D""
+		else
+			capuser=3D"-Z $SUDO_USER"
+		fi
 =

-	    capfile=3D"${listener_ns}-${connector_ns}-${cl_proto}-${srv_proto}-${=
connect_addr}.pcap"
+		local capfile=3D"${listener_ns}-${connector_ns}-${cl_proto}-${srv_proto}=
-${connect_addr}.pcap"
 =

-	    ip netns exec ${listener_ns} tcpdump -i any -s 65535 -B 32768 $capuse=
r -w $capfile > "$capout" 2>&1 &
-	    cappid=3D$!
+		ip netns exec ${listener_ns} tcpdump -i any -s 65535 -B 32768 $capuser -=
w $capfile > "$capout" 2>&1 &
+		local cappid=3D$!
 =

-	    sleep 1
+		sleep 1
 	fi
 =

 	ip netns exec ${listener_ns} ./mptcp_connect -t $timeout -l -p $port -s $=
{srv_proto} $local_addr < "$sin" > "$sout" &
-	spid=3D$!
+	local spid=3D$!
 =

 	wait_local_port_listen "${listener_ns}" "${port}"
 =

+	local start
 	start=3D$(date +%s%3N)
 	ip netns exec ${connector_ns} ./mptcp_connect -t $timeout -p $port -s ${c=
l_proto} $connect_addr < "$cin" > "$cout" &
-	cpid=3D$!
+	local cpid=3D$!
 =

 	wait $cpid
-	retc=3D$?
+	local retc=3D$?
 	wait $spid
-	rets=3D$?
+	local rets=3D$?
 =

+	local stop
 	stop=3D$(date +%s%3N)
 =

 	if $capture; then
-	    sleep 1
-	    kill $cappid
+		sleep 1
+		kill $cappid
 	fi
 =

+	local duration
 	duration=3D$((stop-start))
 	duration=3D$(printf "(duration %05sms)" $duration)
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
@@ -388,9 +397,10 @@ do_transfer()
 =

 make_file()
 {
-	name=3D$1
-	who=3D$2
+	local name=3D$1
+	local who=3D$2
 =

+	local SIZE TSIZE
 	SIZE=3D$((RANDOM % (1024 * 8)))
 	TSIZE=3D$((SIZE * 1024))
 =

@@ -407,12 +417,12 @@ make_file()
 =

 run_tests_lo()
 {
-	listener_ns=3D"$1"
-	connector_ns=3D"$2"
-	connect_addr=3D"$3"
-	local_addr=3D"$4"
-	loopback=3D"$5"
-	lret=3D0
+	local listener_ns=3D"$1"
+	local connector_ns=3D"$2"
+	local connect_addr=3D"$3"
+	local local_addr=3D"$4"
+	local loopback=3D"$5"
+	local lret=3D0
 =

 	# skip if test programs are running inside same netns for subsequent runs.
 	if [ $loopback -eq 0 ] && [ ${listener_ns} =3D ${connector_ns} ]; then
-- =

2.24.0

--===============0685390040847021641==--
