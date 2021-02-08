Content-Type: multipart/mixed; boundary="===============0218936673286497002=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 3/3] selftests: mptcp: fail if not enough
 SYN/3rd ACK
Date: Mon, 08 Feb 2021 18:45:48 +0100
Message-ID: <20210208174548.493800-4-matthieu.baerts@tessares.net>
In-Reply-To: 20210208174548.493800-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 7686

--===============0218936673286497002==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If we receive less MPCapable SYN or 3rd ACK than expected, we now mark
the test as failed.

On the other hand, if we receive more, we keep the warning but we add a
hint that it is probably due to retransmissions and that's why we don't
mark the test as failed.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/148
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 .../selftests/net/mptcp/mptcp_connect.sh      | 28 +++++++++++++------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index 0294ada751cf..e4e9b2bf058c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -473,10 +473,6 @@ do_transfer()
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
@@ -492,6 +488,22 @@ do_transfer()
 		expect_synrx=3D$((stat_synrx_last_l+1))
 		expect_ackrx=3D$((stat_ackrx_last_l+1))
 	fi
+
+	if [ ${expect_synrx} -lt ${stat_synrx_now_l} ]; then
+		printf "[ FAIL ] lower MPC SYN rx than expected: %d -> %d\n" \
+			"${expect_synrx}" "${stat_synrx_now_l}" 1>&2
+		retc=3D1
+	fi
+	if [ ${expect_ackrx} -lt ${stat_ackrx_now_l} ]; then
+		printf "[ FAIL ] lower MPC ACK rx than expected: %d -> %d\n" \
+			"${expect_ackrx}" "${stat_ackrx_now_l}" 1>&2
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
@@ -508,12 +520,12 @@ do_transfer()
 		fi
 	fi
 =

-	if [ $expect_synrx -ne $stat_synrx_now_l ] ;then
-		printf " WARN: SYNRX: expect %d, got %d" \
+	if [ $expect_synrx -gt $stat_synrx_now_l ]; then
+		printf " WARN: SYNRX: expect %d, got %d (probably retransmissions)" \
 			"${expect_synrx}" "${stat_synrx_now_l}"
 	fi
-	if [ $expect_ackrx -ne $stat_ackrx_now_l ] ;then
-		printf " WARN: ACKRX: expect %d, got %d" \
+	if [ $expect_ackrx -gt $stat_ackrx_now_l ]; then
+		printf " WARN: ACKRX: expect %d, got %d (probably retransmissions)" \
 			"${expect_ackrx}" "${stat_ackrx_now_l}"
 	fi
 =

-- =

2.29.2

--===============0218936673286497002==--
