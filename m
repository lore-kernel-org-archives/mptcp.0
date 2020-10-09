Content-Type: multipart/mixed; boundary="===============4052664064255181500=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next v2] selftests: mptcp: add link failure test
 case
Date: Fri, 09 Oct 2020 17:11:17 +0200
Message-ID: <20201009151117.6672-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 6271

--===============4052664064255181500==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a test case where a link fails with multiple subflows.
The expectation is that MPTCP will transmit any data that
could not be delivered via the failed link on another subflow.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 v2: rebase and add 'link loss' to test-case comment.
     make sure we exit with 1 if file was corrupt or server/client
     exited nonzero.

 .../testing/selftests/net/mptcp/mptcp_join.sh | 135 +++++++++++++-----
 1 file changed, 97 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 3767acb9bb12..b3fe9b4b0a16 100755
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
@@ -79,7 +80,7 @@ cleanup_partial()
 cleanup()
 {
 	rm -f "$cin" "$cout"
-	rm -f "$sin" "$sout"
+	rm -f "$cin" "$cout" "$cinsent"
 	cleanup_partial
 }
 =

@@ -122,6 +123,12 @@ if [ $? -ne 0 ];then
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
@@ -134,6 +141,7 @@ check_transfer()
 		echo "[ FAIL ] $what does not match (in, out):"
 		print_file_err "$in"
 		print_file_err "$out"
+		ret=3D1
 =

 		return 1
 	fi
@@ -154,6 +162,17 @@ do_ping()
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
@@ -161,9 +180,10 @@ do_transfer()
 	cl_proto=3D"$3"
 	srv_proto=3D"$4"
 	connect_addr=3D"$5"
-	rm_nr_ns1=3D"$6"
-	rm_nr_ns2=3D"$7"
-	speed=3D"$8"
+	test_link_fail=3D"$6"
+	rm_nr_ns1=3D"$7"
+	rm_nr_ns2=3D"$8"
+	speed=3D"$9"
 =

 	port=3D$((10000+$TEST_COUNT))
 	TEST_COUNT=3D$((TEST_COUNT+1))
@@ -199,7 +219,12 @@ do_transfer()
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
@@ -244,12 +269,17 @@ do_transfer()
 		ip netns exec ${connector_ns} ss -nita 1>&2 -o "dport =3D :$port"
 =

 		cat "$capout"
+		ret=3D1
 		return 1
 	fi
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
@@ -265,13 +295,12 @@ make_file()
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
@@ -279,14 +308,32 @@ run_tests()
 	listener_ns=3D"$1"
 	connector_ns=3D"$2"
 	connect_addr=3D"$3"
-	rm_nr_ns1=3D"${4:-0}"
-	rm_nr_ns2=3D"${5:-0}"
-	speed=3D"${6:-fast}"
+	test_linkfail=3D"$4"
+	rm_nr_ns1=3D"${5:-0}"
+	rm_nr_ns2=3D"${6:-0}"
+	speed=3D"${7:-fast}"
 	lret=3D0
+	oldin=3D""
+
+	if [ "$test_linkfail" -eq 1 ];then
+		size=3D$((RANDOM%1024))
+		size=3D$((size+1))
+		size=3D$((size*128))
+
+		oldin=3D$(mktemp)
+		cp "$cin" "$oldin"
+		make_file "$cin" "client" $size
+	fi
 =

 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} \
-		${rm_nr_ns1} ${rm_nr_ns2} ${speed}
+		${test_linkfail} ${rm_nr_ns1} ${rm_nr_ns2} ${speed}
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
@@ -419,26 +466,27 @@ chk_rm_nr()
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
@@ -446,7 +494,7 @@ reset
 ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 ip netns exec $ns2 ./pm_nl_ctl limits 0 1
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
 chk_join_nr "single subflow" 1 1 1
 =

 # multiple subflows
@@ -455,7 +503,7 @@ ip netns exec $ns1 ./pm_nl_ctl limits 0 2
 ip netns exec $ns2 ./pm_nl_ctl limits 0 2
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
 chk_join_nr "multiple subflows" 2 2 2
 =

 # multiple subflows limited by serverf
@@ -464,13 +512,13 @@ ip netns exec $ns1 ./pm_nl_ctl limits 0 1
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

@@ -479,7 +527,7 @@ reset
 ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 ip netns exec $ns2 ./pm_nl_ctl limits 1 1
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
 chk_join_nr "signal address" 1 1 1
 chk_add_nr 1 1
 =

@@ -492,7 +540,7 @@ ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 ip netns exec $ns1 ./pm_nl_ctl limits 0 2
 ip netns exec $ns2 ./pm_nl_ctl limits 1 2
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
 chk_join_nr "subflow and signal" 2 2 2
 chk_add_nr 1 1
 =

@@ -503,16 +551,27 @@ ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags sig=
nal
 ip netns exec $ns2 ./pm_nl_ctl limits 1 3
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
 chk_join_nr "multiple subflows and signal" 3 3 3
 chk_add_nr 1 1
 =

+# accept and use add_addr with additional subflows and link loss
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
 # add_addr timeout
 reset_with_add_addr_timeout
 ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 ip netns exec $ns2 ./pm_nl_ctl limits 1 1
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-run_tests $ns1 $ns2 10.0.1.1 0 0 slow
+run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 chk_join_nr "signal address, ADD_ADDR timeout" 1 1 1
 chk_add_nr 4 0
 =

@@ -521,7 +580,7 @@ reset
 ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 ip netns exec $ns2 ./pm_nl_ctl limits 0 1
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1 0 1 slow
+run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow
 chk_join_nr "remove single subflow" 1 1 1
 chk_rm_nr 1 1
 =

@@ -531,7 +590,7 @@ ip netns exec $ns1 ./pm_nl_ctl limits 0 2
 ip netns exec $ns2 ./pm_nl_ctl limits 0 2
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1 0 2 slow
+run_tests $ns1 $ns2 10.0.1.1 0 0 2 slow
 chk_join_nr "remove multiple subflows" 2 2 2
 chk_rm_nr 2 2
 =

@@ -540,7 +599,7 @@ reset
 ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 ip netns exec $ns2 ./pm_nl_ctl limits 1 1
-run_tests $ns1 $ns2 10.0.1.1 1 0 slow
+run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
 chk_join_nr "remove single address" 1 1 1
 chk_add_nr 1 1
 chk_rm_nr 0 0
@@ -551,7 +610,7 @@ ip netns exec $ns1 ./pm_nl_ctl limits 0 2
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 ip netns exec $ns2 ./pm_nl_ctl limits 1 2
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1 1 1 slow
+run_tests $ns1 $ns2 10.0.1.1 0 1 1 slow
 chk_join_nr "remove subflow and signal" 2 2 2
 chk_add_nr 1 1
 chk_rm_nr 1 1
@@ -563,7 +622,7 @@ ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 ip netns exec $ns2 ./pm_nl_ctl limits 1 3
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1 1 2 slow
+run_tests $ns1 $ns2 10.0.1.1 0 1 2 slow
 chk_join_nr "remove subflows and signal" 3 3 3
 chk_add_nr 1 1
 chk_rm_nr 2 2
@@ -573,7 +632,7 @@ reset_with_cookies
 ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 ip netns exec $ns2 ./pm_nl_ctl limits 0 1
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
 chk_join_nr "single subflow with syn cookies" 1 1 1
 =

 # multiple subflows with syn cookies
@@ -582,7 +641,7 @@ ip netns exec $ns1 ./pm_nl_ctl limits 0 2
 ip netns exec $ns2 ./pm_nl_ctl limits 0 2
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
 chk_join_nr "multiple subflows with syn cookies" 2 2 2
 =

 # multiple subflows limited by server
@@ -591,7 +650,7 @@ ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 ip netns exec $ns2 ./pm_nl_ctl limits 0 2
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
 chk_join_nr "subflows limited by server w cookies" 2 2 1
 =

 # test signal address with cookies
@@ -599,7 +658,7 @@ reset_with_cookies
 ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 ip netns exec $ns2 ./pm_nl_ctl limits 1 1
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
 chk_join_nr "signal address with syn cookies" 1 1 1
 chk_add_nr 1 1
 =

@@ -609,7 +668,7 @@ ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 ip netns exec $ns1 ./pm_nl_ctl limits 0 2
 ip netns exec $ns2 ./pm_nl_ctl limits 1 2
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-run_tests $ns1 $ns2 10.0.1.1
+run_tests $ns1 $ns2 10.0.1.1 0
 chk_join_nr "subflow and signal w cookies" 2 2 2
 chk_add_nr 1 1
 =

@@ -620,7 +679,7 @@ ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
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

--===============4052664064255181500==--
