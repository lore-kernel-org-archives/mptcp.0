Content-Type: multipart/mixed; boundary="===============6003842246433255103=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v2 7/7] selftests: mptcp: add ADD_ADDR
 timeout test case
Date: Tue, 03 Nov 2020 11:05:09 -0800
Message-ID: <20201103190509.27416-8-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20201103190509.27416-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 6533

--===============6003842246433255103==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geliang Tang <geliangtang(a)gmail.com>

This patch added the test case for retransmitting ADD_ADDR when timeout
occurs. It set NS1's add_addr_timeout to 1 second, and drop NS2's ADD_ADDR
echo packets.

Here we need to slow down the transfer process of all data to let the
ADD_ADDR suboptions can be retransmitted three times. So we added a new
parameter "speed" for do_transfer, it can be set with fast or slow.

We also added three new optional parameters for run_tests, and dropped
run_remove_tests function.

Since we added the netfilter rules in this test case, we need to update
the "config" file.

Suggested-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
Acked-by: Paolo Abeni <pabeni(a)redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 tools/testing/selftests/net/mptcp/config      | 10 ++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 94 ++++++++++++++-----
 2 files changed, 80 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selft=
ests/net/mptcp/config
index 741a1c4f4ae8..0faaccd21447 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -5,3 +5,13 @@ CONFIG_INET_DIAG=3Dm
 CONFIG_INET_MPTCP_DIAG=3Dm
 CONFIG_VETH=3Dy
 CONFIG_NET_SCH_NETEM=3Dm
+CONFIG_NETFILTER=3Dy
+CONFIG_NETFILTER_ADVANCED=3Dy
+CONFIG_NETFILTER_NETLINK=3Dm
+CONFIG_NF_TABLES=3Dm
+CONFIG_NFT_COUNTER=3Dm
+CONFIG_NFT_COMPAT=3Dm
+CONFIG_NETFILTER_XTABLES=3Dm
+CONFIG_NETFILTER_XT_MATCH_BPF=3Dm
+CONFIG_NF_TABLES_IPV4=3Dy
+CONFIG_NF_TABLES_IPV6=3Dy
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 08f53d86dedc..0d93b243695f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -13,6 +13,24 @@ capture=3D0
 =

 TEST_COUNT=3D0
 =

+# generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) =3D=3D 0x30) ||
+#				  (ip6 && (ip6[74] & 0xf0) =3D=3D 0x30)'"
+CBPF_MPTCP_SUBOPTION_ADD_ADDR=3D"14,
+			       48 0 0 0,
+			       84 0 0 240,
+			       21 0 3 64,
+			       48 0 0 54,
+			       84 0 0 240,
+			       21 6 7 48,
+			       48 0 0 0,
+			       84 0 0 240,
+			       21 0 4 96,
+			       48 0 0 74,
+			       84 0 0 240,
+			       21 0 1 48,
+			       6 0 0 65535,
+			       6 0 0 0"
+
 init()
 {
 	capout=3D$(mktemp)
@@ -82,6 +100,26 @@ reset_with_cookies()
 	done
 }
 =

+reset_with_add_addr_timeout()
+{
+	local ip=3D"${1:-4}"
+	local tables
+
+	tables=3D"iptables"
+	if [ $ip -eq 6 ]; then
+		tables=3D"ip6tables"
+	fi
+
+	reset
+
+	ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=3D1
+	ip netns exec $ns2 $tables -A OUTPUT -p tcp \
+		-m tcp --tcp-option 30 \
+		-m bpf --bytecode \
+		"$CBPF_MPTCP_SUBOPTION_ADD_ADDR" \
+		-j DROP
+}
+
 for arg in "$@"; do
 	if [ "$arg" =3D "-c" ]; then
 		capture=3D1
@@ -94,6 +132,17 @@ if [ $? -ne 0 ];then
 	exit $ksft_skip
 fi
 =

+iptables -V > /dev/null 2>&1
+if [ $? -ne 0 ];then
+	echo "SKIP: Could not run all tests without iptables tool"
+	exit $ksft_skip
+fi
+
+ip6tables -V > /dev/null 2>&1
+if [ $? -ne 0 ];then
+	echo "SKIP: Could not run all tests without ip6tables tool"
+	exit $ksft_skip
+fi
 =

 check_transfer()
 {
@@ -135,6 +184,7 @@ do_transfer()
 	connect_addr=3D"$5"
 	rm_nr_ns1=3D"$6"
 	rm_nr_ns2=3D"$7"
+	speed=3D"$8"
 =

 	port=3D$((10000+$TEST_COUNT))
 	TEST_COUNT=3D$((TEST_COUNT+1))
@@ -159,7 +209,7 @@ do_transfer()
 		sleep 1
 	fi
 =

-	if [[ $rm_nr_ns1 -eq 0 && $rm_nr_ns2 -eq 0 ]]; then
+	if [ $speed =3D "fast" ]; then
 		mptcp_connect=3D"./mptcp_connect -j"
 	else
 		mptcp_connect=3D"./mptcp_connect -r"
@@ -250,26 +300,13 @@ run_tests()
 	listener_ns=3D"$1"
 	connector_ns=3D"$2"
 	connect_addr=3D"$3"
+	rm_nr_ns1=3D"${4:-0}"
+	rm_nr_ns2=3D"${5:-0}"
+	speed=3D"${6:-fast}"
 	lret=3D0
 =

-	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} 0 0
-	lret=3D$?
-	if [ $lret -ne 0 ]; then
-		ret=3D$lret
-		return
-	fi
-}
-
-run_remove_tests()
-{
-	listener_ns=3D"$1"
-	connector_ns=3D"$2"
-	connect_addr=3D"$3"
-	rm_nr_ns1=3D"$4"
-	rm_nr_ns2=3D"$5"
-	lret=3D0
-
-	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} ${=
rm_nr_ns1} ${rm_nr_ns2}
+	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} \
+		${rm_nr_ns1} ${rm_nr_ns2} ${speed}
 	lret=3D$?
 	if [ $lret -ne 0 ]; then
 		ret=3D$lret
@@ -491,12 +528,21 @@ run_tests $ns1 $ns2 10.0.1.1
 chk_join_nr "multiple subflows and signal" 3 3 3
 chk_add_nr 1 1
 =

+# add_addr timeout
+reset_with_add_addr_timeout
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+run_tests $ns1 $ns2 10.0.1.1 0 0 slow
+chk_join_nr "signal address, ADD_ADDR timeout" 1 1 1
+chk_add_nr 4 0
+
 # single subflow, remove
 reset
 ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 ip netns exec $ns2 ./pm_nl_ctl limits 0 1
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-run_remove_tests $ns1 $ns2 10.0.1.1 0 1
+run_tests $ns1 $ns2 10.0.1.1 0 1 slow
 chk_join_nr "remove single subflow" 1 1 1
 chk_rm_nr 1 1
 =

@@ -506,7 +552,7 @@ ip netns exec $ns1 ./pm_nl_ctl limits 0 2
 ip netns exec $ns2 ./pm_nl_ctl limits 0 2
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-run_remove_tests $ns1 $ns2 10.0.1.1 0 2
+run_tests $ns1 $ns2 10.0.1.1 0 2 slow
 chk_join_nr "remove multiple subflows" 2 2 2
 chk_rm_nr 2 2
 =

@@ -515,7 +561,7 @@ reset
 ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 ip netns exec $ns2 ./pm_nl_ctl limits 1 1
-run_remove_tests $ns1 $ns2 10.0.1.1 1 0
+run_tests $ns1 $ns2 10.0.1.1 1 0 slow
 chk_join_nr "remove single address" 1 1 1
 chk_add_nr 1 1
 chk_rm_nr 0 0
@@ -526,7 +572,7 @@ ip netns exec $ns1 ./pm_nl_ctl limits 0 2
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 ip netns exec $ns2 ./pm_nl_ctl limits 1 2
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-run_remove_tests $ns1 $ns2 10.0.1.1 1 1
+run_tests $ns1 $ns2 10.0.1.1 1 1 slow
 chk_join_nr "remove subflow and signal" 2 2 2
 chk_add_nr 1 1
 chk_rm_nr 1 1
@@ -538,7 +584,7 @@ ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 ip netns exec $ns2 ./pm_nl_ctl limits 1 3
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
-run_remove_tests $ns1 $ns2 10.0.1.1 1 2
+run_tests $ns1 $ns2 10.0.1.1 1 2 slow
 chk_join_nr "remove subflows and signal" 3 3 3
 chk_add_nr 1 1
 chk_rm_nr 2 2
-- =

2.29.2

--===============6003842246433255103==--
