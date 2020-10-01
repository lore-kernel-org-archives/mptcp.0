Content-Type: multipart/mixed; boundary="===============6365950277276471977=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next] selftests: mptcp: add link failure test
 case
Date: Thu, 01 Oct 2020 23:56:00 +0200
Message-ID: <20201001215600.17614-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 6146

--===============6365950277276471977==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a test case where a link fails with multiple subflows.
The expectation is that MPTCP will transmit any data that
could not be delivered via the failed link on another subflow.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 NB: One could make the 'down link' deterministic:
 this will down one of the 4 links randonly.

 The test case is new, its a copy of
 "multiple subflows and signal", just with added link-fail.

 Alternative would be to just extend the existing one.

 .../testing/selftests/net/mptcp/mptcp_join.sh | 111 +++++++++++++-----
 1 file changed, 84 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 08f53d86dedc..a8be79b226df 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -5,6 +5,7 @@ ret=3D0
 sin=3D""
 sout=3D""
 cin=3D""
+cinsent=3D""
 cout=3D""
 ksft_skip=3D4
 timeout=3D30
@@ -63,7 +64,7 @@ cleanup_partial()
 cleanup()
 {
 	rm -f "$cin" "$cout"
-	rm -f "$sin" "$sout"
+	rm -f "$cin" "$cout" "$cinsent"
 	cleanup_partial
 }
 =

@@ -94,6 +95,12 @@ if [ $? -ne 0 ];then
 	exit $ksft_skip
 fi
 =

+print_file_err()
+{
+	ls -l "$1" 1>&2
+	echo "Trailing bytes are: "
+	tail -c 27 "$1"
+}
 =

 check_transfer()
 {
@@ -126,6 +133,17 @@ do_ping()
 	fi
 }
 =

+link_failure()
+{
+	ns=3D"$1"
+
+	l=3D$((RANDOM%4))
+	l=3D$((l+1))
+
+	veth=3D"ns1eth$l"
+	ip -net "$ns" link set "$veth" down
+}
+
 do_transfer()
 {
 	listener_ns=3D"$1"
@@ -135,6 +153,7 @@ do_transfer()
 	connect_addr=3D"$5"
 	rm_nr_ns1=3D"$6"
 	rm_nr_ns2=3D"$7"
+	test_link_fail=3D"$8"
 =

 	port=3D$((10000+$TEST_COUNT))
 	TEST_COUNT=3D$((TEST_COUNT+1))
@@ -170,7 +189,12 @@ do_transfer()
 =

 	sleep 1
 =

-	ip netns exec ${connector_ns} $mptcp_connect -t $timeout -p $port -s ${cl=
_proto} $connect_addr < "$cin" > "$cout" &
+	if [ "$test_link_fail" -eq 0 ];then
+		ip netns exec ${connector_ns} $mptcp_connect -t $timeout -p $port -s ${c=
l_proto} $connect_addr < "$cin" > "$cout" &
+	else
+		( cat "$cin" ; sleep 2; link_failure $listener_ns ; cat "$cin" ) | tee "=
$cinsent" | \
+		ip netns exec ${connector_ns} $mptcp_connect -t $timeout -p $port -s ${c=
l_proto} $connect_addr > "$cout" &
+	fi
 	cpid=3D$!
 =

 	if [ $rm_nr_ns1 -gt 0 ]; then
@@ -220,7 +244,11 @@ do_transfer()
 =

 	check_transfer $sin $cout "file received by client"
 	retc=3D$?
-	check_transfer $cin $sout "file received by server"
+	if [ "$test_link_fail" -eq 0 ];then
+		check_transfer $cin $sout "file received by server"
+	else
+		check_transfer $cinsent $sout "file received by server"
+	fi
 	rets=3D$?
 =

 	if [ $retc -eq 0 ] && [ $rets -eq 0 ];then
@@ -236,13 +264,12 @@ make_file()
 {
 	name=3D$1
 	who=3D$2
+	size=3D$3
 =

-	SIZE=3D1
-
-	dd if=3D/dev/urandom of=3D"$name" bs=3D1024 count=3D$SIZE 2> /dev/null
+	dd if=3D/dev/urandom of=3D"$name" bs=3D1024 count=3D$size 2> /dev/null
 	echo -e "\nMPTCP_TEST_FILE_END_MARKER" >> "$name"
 =

-	echo "Created $name (size $SIZE KB) containing data sent by $who"
+	echo "Created $name (size $size KB) containing data sent by $who"
 }
 =

 run_tests()
@@ -250,10 +277,28 @@ run_tests()
 	listener_ns=3D"$1"
 	connector_ns=3D"$2"
 	connect_addr=3D"$3"
+	test_linkfail=3D"$4"
 	lret=3D0
+	oldin=3D""
+
+	if [ "$test_linkfail" -eq 1 ];then
+		size=3D$((RANDOM%1024))
+		size=3D$((size+1))
+		size=3D$((size*128))
 =

-	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} 0 0
+		oldin=3D$(mktemp)
+		cp "$cin" "$oldin"
+		make_file "$cin" "client" $size
+	fi
+
+	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} 0 =
0 "$test_linkfail"
 	lret=3D$?
+
+	if [ "$test_linkfail" -eq 1 ];then
+		cp "$oldin" "$cin"
+		rm -f "$oldin"
+	fi
+
 	if [ $lret -ne 0 ]; then
 		ret=3D$lret
 		return
@@ -269,7 +314,7 @@ run_remove_tests()
 	rm_nr_ns2=3D"$5"
 	lret=3D0
 =

-	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} ${=
rm_nr_ns1} ${rm_nr_ns2}
+	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} ${=
rm_nr_ns1} ${rm_nr_ns2} 0
 	lret=3D$?
 	if [ $lret -ne 0 ]; then
 		ret=3D$lret
@@ -403,26 +448,27 @@ chk_rm_nr()
 sin=3D$(mktemp)
 sout=3D$(mktemp)
 cin=3D$(mktemp)
+cinsent=3D$(mktemp)
 cout=3D$(mktemp)
 init
-make_file "$cin" "client"
-make_file "$sin" "server"
+make_file "$cin" "client" 1
+make_file "$sin" "server" 1
 trap cleanup EXIT
 =

-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
 chk_join_nr "no JOIN" "0" "0" "0"
 =

 # subflow limted by client
 reset
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
 chk_join_nr "single subflow, limited by client" 0 0 0
 =

 # subflow limted by server
 reset
 ip netns exec $ns2 ./pm_nl_ctl limits 0 1
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
 chk_join_nr "single subflow, limited by server" 1 1 0
 =

 # subflow
@@ -430,7 +476,7 @@ reset
 ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 ip netns exec $ns2 ./pm_nl_ctl limits 0 1
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
 chk_join_nr "single subflow" 1 1 1
 =

 # multiple subflows
@@ -439,7 +485,7 @@ ip netns exec $ns1 ./pm_nl_ctl limits 0 2
 ip netns exec $ns2 ./pm_nl_ctl limits 0 2
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
 chk_join_nr "multiple subflows" 2 2 2
 =

 # multiple subflows limited by serverf
@@ -448,13 +494,13 @@ ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 ip netns exec $ns2 ./pm_nl_ctl limits 0 2
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
 chk_join_nr "multiple subflows, limited by server" 2 2 1
 =

 # add_address, unused
 reset
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
 chk_join_nr "unused signal address" 0 0 0
 chk_add_nr 1 1
 =

@@ -463,7 +509,7 @@ reset
 ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 ip netns exec $ns2 ./pm_nl_ctl limits 1 1
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
 chk_join_nr "signal address" 1 1 1
 chk_add_nr 1 1
 =

@@ -476,7 +522,7 @@ ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 ip netns exec $ns1 ./pm_nl_ctl limits 0 2
 ip netns exec $ns2 ./pm_nl_ctl limits 1 2
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
 chk_join_nr "subflow and signal" 2 2 2
 chk_add_nr 1 1
 =

@@ -487,10 +533,21 @@ ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags sig=
nal
 ip netns exec $ns2 ./pm_nl_ctl limits 1 3
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
 chk_join_nr "multiple subflows and signal" 3 3 3
 chk_add_nr 1 1
 =

+# accept and use add_addr with additional subflows
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 3
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+ip netns exec $ns2 ./pm_nl_ctl limits 1 3
+ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
+run_tests $ns1 $ns2 10.0.1.1 1
+chk_join_nr "multiple flows, signal, link failure" 3 3 3
+chk_add_nr 1 1
+
 # single subflow, remove
 reset
 ip netns exec $ns1 ./pm_nl_ctl limits 0 1
@@ -548,7 +605,7 @@ reset_with_cookies
 ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 ip netns exec $ns2 ./pm_nl_ctl limits 0 1
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
 chk_join_nr "single subflow with syn cookies" 1 1 1
 =

 # multiple subflows with syn cookies
@@ -557,7 +614,7 @@ ip netns exec $ns1 ./pm_nl_ctl limits 0 2
 ip netns exec $ns2 ./pm_nl_ctl limits 0 2
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
 chk_join_nr "multiple subflows with syn cookies" 2 2 2
 =

 # multiple subflows limited by server
@@ -566,7 +623,7 @@ ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 ip netns exec $ns2 ./pm_nl_ctl limits 0 2
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
 chk_join_nr "subflows limited by server w cookies" 2 2 1
 =

 # test signal address with cookies
@@ -574,7 +631,7 @@ reset_with_cookies
 ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 ip netns exec $ns2 ./pm_nl_ctl limits 1 1
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
 chk_join_nr "signal address with syn cookies" 1 1 1
 chk_add_nr 1 1
 =

@@ -584,7 +641,7 @@ ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 ip netns exec $ns1 ./pm_nl_ctl limits 0 2
 ip netns exec $ns2 ./pm_nl_ctl limits 1 2
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
 chk_join_nr "subflow and signal w cookies" 2 2 2
 chk_add_nr 1 1
 =

@@ -595,7 +652,7 @@ ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 ip netns exec $ns2 ./pm_nl_ctl limits 1 3
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
 chk_join_nr "subflows and signal w. cookies" 3 3 3
 chk_add_nr 1 1
 =

-- =

2.26.2

--===============6365950277276471977==--
