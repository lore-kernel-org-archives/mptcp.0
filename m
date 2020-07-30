Content-Type: multipart/mixed; boundary="===============2779153424907750378=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH RFC v3 10/10] selftests: mptcp: add test cases for
 mptcp join tests with syn cookies
Date: Thu, 30 Jul 2020 02:12:41 +0200
Message-ID: <20200730001241.3037-11-fw@strlen.de>
In-Reply-To: 20200730001241.3037-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 5382

--===============2779153424907750378==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Also add test cases with MP_JOIN when tcp_syncookies sysctl is 2 (i.e.,
syncookies are always-on).

While at it, also print the test number and add the test number
to the pcap files that can be generated optionally.

This makes it easier to match the pcap to the test case.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 66 ++++++++++++++++++-
 1 file changed, 64 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index dd42c2f692d0..f39c1129ce5f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -72,6 +72,15 @@ reset()
 	init
 }
 =

+reset_with_cookies()
+{
+	reset
+
+	for netns in "$ns1" "$ns2";do
+		ip netns exec $netns sysctl -q net.ipv4.tcp_syncookies=3D2
+	done
+}
+
 for arg in "$@"; do
 	if [ "$arg" =3D "-c" ]; then
 		capture=3D1
@@ -138,7 +147,7 @@ do_transfer()
 			capuser=3D"-Z $SUDO_USER"
 		fi
 =

-		capfile=3D"mp_join-${listener_ns}.pcap"
+		capfile=3D$(printf "mp_join-%02u-%s.pcap" "$TEST_COUNT" "${listener_ns}")
 =

 		echo "Capturing traffic for test $TEST_COUNT into $capfile"
 		ip netns exec ${listener_ns} tcpdump -i any -s 65535 -B 32768 $capuser -=
w $capfile > "$capout" 2>&1 &
@@ -227,7 +236,7 @@ chk_join_nr()
 	local count
 	local dump_stats
 =

-	printf "%-36s %s" "$msg" "syn"
+	printf "%02u %-36s %s" "$TEST_COUNT" "$msg" "syn"
 	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinSynRx | awk '{=
print $2}'`
 	[ -z "$count" ] && count=3D0
 	if [ "$count" !=3D "$syn_nr" ]; then
@@ -354,4 +363,57 @@ ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subf=
low
 run_tests $ns1 $ns2 10.0.1.1
 chk_join_nr "multiple subflows and signal" 3 3 3
 =

+# single subflow, syncookies
+reset_with_cookies
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+run_tests $ns1 $ns2 10.0.1.1
+chk_join_nr "single subflow with syn cookies" 1 1 1
+
+# multiple subflows with syn cookies
+reset_with_cookies
+ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+run_tests $ns1 $ns2 10.0.1.1
+chk_join_nr "multiple subflows with syn cookies" 2 2 2
+
+# multiple subflows limited by server
+reset_with_cookies
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+run_tests $ns1 $ns2 10.0.1.1
+chk_join_nr "subflows limited by server w cookies" 2 2 1
+
+# test signal address with cookies
+reset_with_cookies
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+run_tests $ns1 $ns2 10.0.1.1
+chk_join_nr "signal address with syn cookies" 1 1 1
+
+# test cookie with subflow and signal
+reset_with_cookies
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+ip netns exec $ns2 ./pm_nl_ctl limits 1 2
+ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+run_tests $ns1 $ns2 10.0.1.1
+chk_join_nr "subflow and signal w cookies" 2 2 2
+
+# accept and use add_addr with additional subflows
+reset_with_cookies
+ip netns exec $ns1 ./pm_nl_ctl limits 0 3
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+ip netns exec $ns2 ./pm_nl_ctl limits 1 3
+ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
+run_tests $ns1 $ns2 10.0.1.1
+chk_join_nr "subflows and signal w. cookies" 3 3 3
+
 exit $ret
-- =

2.26.2

--===============2779153424907750378==--
