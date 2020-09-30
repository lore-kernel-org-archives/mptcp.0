Content-Type: multipart/mixed; boundary="===============7284498380205270766=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v4 mptcp-next 2/2] selftests: mptcp: add
 ADD_ADDR timeout test case
Date: Wed, 30 Sep 2020 16:50:44 +0800
Message-ID: <3b965516e6d9c89b6b7e785142f61164673327a6.1601455568.git.geliangtang@gmail.com>
In-Reply-To: b45ed71e0659b4d9c368c4f3cc24cac83d1723c2.1601455568.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6109

--===============7284498380205270766==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added the test case for retransmitting ADD_ADDR when timeout
occurs. It set NS1's add_addr_timeout to 1 second, and drop NS2's ADD_ADDR
echo packets.

And we need to slow down the transfer process of all data to let the
ADD_ADDR suboptions can be retransmitted three times.

Suggested-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 tools/testing/selftests/net/mptcp/config      |  6 +++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 43 +++++++++++++++++--
 2 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selft=
ests/net/mptcp/config
index 8df5cb8f71ff..af8c0ca79b98 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -4,3 +4,9 @@ CONFIG_INET_DIAG=3Dm
 CONFIG_INET_MPTCP_DIAG=3Dm
 CONFIG_VETH=3Dy
 CONFIG_NET_SCH_NETEM=3Dm
+CONFIG_NETFILTER=3Dy
+CONFIG_NETFILTER_ADVANCED=3Dy
+CONFIG_NETFILTER_XTABLES=3Dm
+CONFIG_NETFILTER_XT_MATCH_BPF=3Dm
+CONFIG_IP_NF_IPTABLES=3Dm
+CONFIG_IP_NF_FILTER=3Dm
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 08f53d86dedc..ed03ed503655 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -82,6 +82,18 @@ reset_with_cookies()
 	done
 }
 =

+reset_with_add_addr_timeout()
+{
+	reset
+
+	ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=3D1
+	ip netns exec $ns2 iptables -A OUTPUT -p tcp \
+		-m tcp --tcp-option 30 \
+		-m bpf --bytecode \
+		"$(nfbpf_compile '(tcp[34] & 0xf0) =3D=3D 0x30')" \
+		-j DROP
+}
+
 for arg in "$@"; do
 	if [ "$arg" =3D "-c" ]; then
 		capture=3D1
@@ -135,6 +147,7 @@ do_transfer()
 	connect_addr=3D"$5"
 	rm_nr_ns1=3D"$6"
 	rm_nr_ns2=3D"$7"
+	slow=3D"$8"
 =

 	port=3D$((10000+$TEST_COUNT))
 	TEST_COUNT=3D$((TEST_COUNT+1))
@@ -159,7 +172,7 @@ do_transfer()
 		sleep 1
 	fi
 =

-	if [[ $rm_nr_ns1 -eq 0 && $rm_nr_ns2 -eq 0 ]]; then
+	if [ $slow -eq 0 ]; then
 		mptcp_connect=3D"./mptcp_connect -j"
 	else
 		mptcp_connect=3D"./mptcp_connect -r"
@@ -252,7 +265,22 @@ run_tests()
 	connect_addr=3D"$3"
 	lret=3D0
 =

-	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} 0 0
+	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} 0 =
0 0
+	lret=3D$?
+	if [ $lret -ne 0 ]; then
+		ret=3D$lret
+		return
+	fi
+}
+
+run_tests_slow()
+{
+	listener_ns=3D"$1"
+	connector_ns=3D"$2"
+	connect_addr=3D"$3"
+	lret=3D0
+
+	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} 0 =
0 1
 	lret=3D$?
 	if [ $lret -ne 0 ]; then
 		ret=3D$lret
@@ -269,7 +297,7 @@ run_remove_tests()
 	rm_nr_ns2=3D"$5"
 	lret=3D0
 =

-	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} ${=
rm_nr_ns1} ${rm_nr_ns2}
+	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} ${=
rm_nr_ns1} ${rm_nr_ns2} 1
 	lret=3D$?
 	if [ $lret -ne 0 ]; then
 		ret=3D$lret
@@ -491,6 +519,15 @@ run_tests $ns1 $ns2 10.0.1.1
 chk_join_nr "multiple subflows and signal" 3 3 3
 chk_add_nr 1 1
 =

+# add_addr timeout
+reset_with_add_addr_timeout
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+run_tests_slow $ns1 $ns2 10.0.1.1
+chk_join_nr "signal address, ADD_ADDR timeout" 1 1 1
+chk_add_nr 4 0
+
 # single subflow, remove
 reset
 ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-- =

2.26.2

--===============7284498380205270766==--
