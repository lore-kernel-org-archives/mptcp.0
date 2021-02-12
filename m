Content-Type: multipart/mixed; boundary="===============8840811711921493816=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 4/4] selftests: mptcp: fail if not enough
 SYN/3rd ACK
Date: Fri, 12 Feb 2021 15:20:30 -0800
Message-ID: <20210212232030.377261-5-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20210212232030.377261-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7782

--===============8840811711921493816==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Matthieu Baerts <matthieu.baerts(a)tessares.net>

If we receive less MPCapable SYN or 3rd ACK than expected, we now mark
the test as failed.

On the other hand, if we receive more, we keep the warning but we add a
hint that it is probably due to retransmissions and that's why we don't
mark the test as failed.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/148
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 .../selftests/net/mptcp/mptcp_connect.sh      | 28 +++++++++++++------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index 362e891f89cf..10a030b53b23 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -483,10 +483,6 @@ do_transfer()
 	check_transfer $cin $sout "file received by server"
 	rets=3D$?
 =

-	if [ $retc -eq 0 ] && [ $rets -eq 0 ]; then
-		printf "[ OK ]"
-	fi
-
 	local stat_synrx_now_l=3D$(get_mib_counter "${listener_ns}" "MPTcpExtMPCa=
pableSYNRX")
 	local stat_ackrx_now_l=3D$(get_mib_counter "${listener_ns}" "MPTcpExtMPCa=
pableACKRX")
 	local stat_cookietx_now=3D$(get_mib_counter "${listener_ns}" "TcpExtSynco=
okiesSent")
@@ -502,6 +498,22 @@ do_transfer()
 		expect_synrx=3D$((stat_synrx_last_l+1))
 		expect_ackrx=3D$((stat_ackrx_last_l+1))
 	fi
+
+	if [ ${stat_synrx_now_l} -lt ${expect_synrx} ]; then
+		printf "[ FAIL ] lower MPC SYN rx (%d) than expected (%d)\n" \
+			"${stat_synrx_now_l}" "${expect_synrx}" 1>&2
+		retc=3D1
+	fi
+	if [ ${stat_ackrx_now_l} -lt ${expect_ackrx} ]; then
+		printf "[ FAIL ] lower MPC ACK rx (%d) than expected (%d)\n" \
+			"${stat_ackrx_now_l}" "${expect_ackrx}" 1>&2
+		rets=3D1
+	fi
+
+	if [ $retc -eq 0 ] && [ $rets -eq 0 ]; then
+		printf "[ OK ]"
+	fi
+
 	if [ $cookies -eq 2 ];then
 		if [ $stat_cookietx_last -ge $stat_cookietx_now ] ;then
 			printf " WARN: CookieSent: did not advance"
@@ -518,12 +530,12 @@ do_transfer()
 		fi
 	fi
 =

-	if [ $expect_synrx -ne $stat_synrx_now_l ] ;then
-		printf " WARN: SYNRX: expect %d, got %d" \
+	if [ ${stat_synrx_now_l} -gt ${expect_synrx} ]; then
+		printf " WARN: SYNRX: expect %d, got %d (probably retransmissions)" \
 			"${expect_synrx}" "${stat_synrx_now_l}"
 	fi
-	if [ $expect_ackrx -ne $stat_ackrx_now_l ] ;then
-		printf " WARN: ACKRX: expect %d, got %d" \
+	if [ ${stat_ackrx_now_l} -gt ${expect_ackrx} ]; then
+		printf " WARN: ACKRX: expect %d, got %d (probably retransmissions)" \
 			"${expect_ackrx}" "${stat_ackrx_now_l}"
 	fi
 =

-- =

2.30.1

--===============8840811711921493816==--
