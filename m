Content-Type: multipart/mixed; boundary="===============4416081400068361691=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 5/5] selftests: mptcp: add
 add_addr_urgent testcases
Date: Thu, 14 Jan 2021 13:40:23 +0800
Message-ID: <19d22eb598a5a8929cb483607e8ead9dc6ac63ff.1610602400.git.geliangtang@gmail.com>
In-Reply-To: 5c2538ff873c136749b80d2f2999ea13e71fe229.1610602400.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7373

--===============4416081400068361691==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added the multiple addresses testcases for add_addr_urgent in
signal_address_tests and add_tests.

It also set add_addr_urgent sysctl in add_addr_timeout testcase to fix
the ADD_ADDR timeout issue like this:

 12 signal address, ADD_ADDR timeout syn[ ok ] - synack[ ok ] - ack[ ok ]
                                     add[fail] got 2 ADD_ADDR[s] expected 4
  - echo  [ ok ]
 Server ns stats
 MPTcpExtMPCapableSYNRX          1              0.0
 MPTcpExtMPCapableACKRX          1              0.0
 MPTcpExtMPJoinSynRx             1              0.0
 MPTcpExtMPJoinAckRx             1              0.0
 Client ns stats
 MPTcpExtMPJoinSynAckRx          1              0.0
 MPTcpExtAddAddr                 2              0.0
 13 remove single subflow            syn[ ok ] - synack[ ok ] - ack[ ok ]
                                     rm [ ok ] - sf    [ ok ]

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 964db9ed544f..622541164110 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -114,6 +114,7 @@ reset_with_add_addr_timeout()
 	reset
 =

 	ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=3D1
+	ip netns exec $ns1 sysctl -q net.mptcp.add_addr_urgent=3D1
 	ip netns exec $ns2 $tables -A OUTPUT -p tcp \
 		-m tcp --tcp-option 30 \
 		-m bpf --bytecode \
@@ -121,6 +122,14 @@ reset_with_add_addr_timeout()
 		-j DROP
 }
 =

+reset_with_add_addr_urgent()
+{
+	reset
+
+	ip netns exec $ns1 sysctl -q net.mptcp.add_addr_urgent=3D1
+	ip netns exec $ns2 sysctl -q net.mptcp.add_addr_urgent=3D1
+}
+
 for arg in "$@"; do
 	if [ "$arg" =3D "-c" ]; then
 		capture=3D1
@@ -767,6 +776,17 @@ signal_address_tests()
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "multiple subflows and signal" 3 3 3
 	chk_add_nr 1 1
+
+	# signal multiple addresses, urgent
+	reset_with_add_addr_urgent
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 3
+	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.4.1 flags signal
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_join_nr "signal multiple addresses, urgent" 3 3 3
+	chk_add_nr 3 3
 }
 =

 link_failure_tests()
@@ -895,6 +915,14 @@ add_tests()
 	run_tests $ns1 $ns2 10.0.1.1 0 0 2 slow
 	chk_join_nr "add multiple subflows" 2 2 2
 =

+	# add multiple addresses
+	reset_with_add_addr_urgent
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
+	run_tests $ns1 $ns2 10.0.1.1 0 2 0 slow
+	chk_join_nr "add multiple addresses" 2 2 2
+	chk_add_nr 2 2
+
 	# add multiple subflows IPv6
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-- =

2.29.2

--===============4416081400068361691==--
