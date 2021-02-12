Content-Type: multipart/mixed; boundary="===============2120355145692996171=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next] Squash to "selftests: mptcp: fail if not
 enough SYN/3rd ACK"
Date: Fri, 12 Feb 2021 09:35:28 +0100
Message-ID: <20210212083528.84431-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 7771

--===============2120355145692996171==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We should check the opposite: 'now' lower than 'expected' and not the
opposite ('expected' lower than 'now') to consider the test as failed.

I also modified the failed message to make it clearer but also because
my TAP parser is rendering the '>' with '&gt;'... XML is still alive!

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    to be squashed in "selftests: mptcp: fail if not enough SYN/3rd ACK"

 .../testing/selftests/net/mptcp/mptcp_connect.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index 48c3db252c78..10a030b53b23 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -499,14 +499,14 @@ do_transfer()
 		expect_ackrx=3D$((stat_ackrx_last_l+1))
 	fi
 =

-	if [ ${expect_synrx} -lt ${stat_synrx_now_l} ]; then
-		printf "[ FAIL ] lower MPC SYN rx than expected: %d -> %d\n" \
-			"${expect_synrx}" "${stat_synrx_now_l}" 1>&2
+	if [ ${stat_synrx_now_l} -lt ${expect_synrx} ]; then
+		printf "[ FAIL ] lower MPC SYN rx (%d) than expected (%d)\n" \
+			"${stat_synrx_now_l}" "${expect_synrx}" 1>&2
 		retc=3D1
 	fi
-	if [ ${expect_ackrx} -lt ${stat_ackrx_now_l} ]; then
-		printf "[ FAIL ] lower MPC ACK rx than expected: %d -> %d\n" \
-			"${expect_ackrx}" "${stat_ackrx_now_l}" 1>&2
+	if [ ${stat_ackrx_now_l} -lt ${expect_ackrx} ]; then
+		printf "[ FAIL ] lower MPC ACK rx (%d) than expected (%d)\n" \
+			"${stat_ackrx_now_l}" "${expect_ackrx}" 1>&2
 		rets=3D1
 	fi
 =

@@ -530,11 +530,11 @@ do_transfer()
 		fi
 	fi
 =

-	if [ $expect_synrx -gt $stat_synrx_now_l ]; then
+	if [ ${stat_synrx_now_l} -gt ${expect_synrx} ]; then
 		printf " WARN: SYNRX: expect %d, got %d (probably retransmissions)" \
 			"${expect_synrx}" "${stat_synrx_now_l}"
 	fi
-	if [ $expect_ackrx -gt $stat_ackrx_now_l ]; then
+	if [ ${stat_ackrx_now_l} -gt ${expect_ackrx} ]; then
 		printf " WARN: ACKRX: expect %d, got %d (probably retransmissions)" \
 			"${expect_ackrx}" "${stat_ackrx_now_l}"
 	fi
-- =

2.30.0

--===============2120355145692996171==--
