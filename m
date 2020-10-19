Content-Type: multipart/mixed; boundary="===============9025897985943475329=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 1/1] Squash to "selftests: mptcp:
 add ADD_ADDR timeout test case" with IPv6 and skip
Date: Mon, 19 Oct 2020 19:26:50 +0800
Message-ID: <40ba492a91f321d1c68c28a6431727bfc9674045.1603106718.git.geliangtang@gmail.com>
In-Reply-To: cover.1603106718.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6349

--===============9025897985943475329==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Added ADD_ADDR IPv6 and skip support for reset_with_add_addr_timeout.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 57 +++++++++++++------
 1 file changed, 41 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 3767acb9bb12..583523d85028 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -13,17 +13,18 @@ capture=3D0
 =

 TEST_COUNT=3D0
 =

-# generated using "nfbpf_compile '(tcp[34] & 0xf0) =3D=3D 0x30'"
-CBPF_MPTCP_SUBOPTION_ADD_ADDR=3D"13,
+# generated using "nfbpf_compile '(ip[54] & 0xf0) =3D=3D 0x30 || (ip6[74] =
& 0xf0) =3D=3D 0x30'"
+CBPF_MPTCP_SUBOPTION_ADD_ADDR=3D"14,
 			       48 0 0 0,
 			       84 0 0 240,
-			       21 0 9 64,
-			       48 0 0 9,
-			       21 0 7 6,
-			       40 0 0 6,
-			       69 5 0 8191,
-			       177 0 0 0,
-			       80 0 0 34,
+			       21 0 3 64,
+			       48 0 0 54,
+			       84 0 0 240,
+			       21 6 7 48,
+			       48 0 0 0,
+			       84 0 0 240,
+			       21 0 4 96,
+			       48 0 0 74,
 			       84 0 0 240,
 			       21 0 1 48,
 			       6 0 0 65535,
@@ -100,14 +101,34 @@ reset_with_cookies()
 =

 reset_with_add_addr_timeout()
 {
+	ip=3D"${1:-4}"
+	local tables
+
+	if [ $ip -eq 4 ]; then
+		iptables -V > /dev/null 2>&1
+		if [ $? -ne 0 ]; then
+			return 1
+		fi
+		tables=3D"iptables"
+	fi
+	if [ $ip -eq 6 ]; then
+		ip6tables -V > /dev/null 2>&1
+		if [ $? -ne 0 ]; then
+			return 1
+		fi
+		tables=3D"ip6tables"
+	fi
+
 	reset
 =

 	ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=3D1
-	ip netns exec $ns2 iptables -A OUTPUT -p tcp \
+	ip netns exec $ns2 $tables -A OUTPUT -p tcp \
 		-m tcp --tcp-option 30 \
 		-m bpf --bytecode \
 		"$CBPF_MPTCP_SUBOPTION_ADD_ADDR" \
 		-j DROP
+
+	return 0
 }
 =

 for arg in "$@"; do
@@ -509,12 +530,16 @@ chk_add_nr 1 1
 =

 # add_addr timeout
 reset_with_add_addr_timeout
-ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-ip netns exec $ns2 ./pm_nl_ctl limits 1 1
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-run_tests $ns1 $ns2 10.0.1.1 0 0 slow
-chk_join_nr "signal address, ADD_ADDR timeout" 1 1 1
-chk_add_nr 4 0
+if [ $? -eq 0 ]; then
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	run_tests $ns1 $ns2 10.0.1.1 0 0 slow
+	chk_join_nr "signal address, ADD_ADDR timeout" 1 1 1
+	chk_add_nr 4 0
+else
+	echo "signal address, ADD_ADDR timeout SKIP: without iptables tool"
+fi
 =

 # single subflow, remove
 reset
-- =

2.26.2

--===============9025897985943475329==--
