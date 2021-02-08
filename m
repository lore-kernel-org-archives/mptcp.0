Content-Type: multipart/mixed; boundary="===============6921800501573043834=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 1/3] selftests: mptcp: fix ACKRX debug
 message
Date: Mon, 08 Feb 2021 18:45:46 +0100
Message-ID: <20210208174548.493800-2-matthieu.baerts@tessares.net>
In-Reply-To: 20210208174548.493800-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 7684

--===============6921800501573043834==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Info from received MPCapable SYN were printed instead of the ones from
received MPCapable 3rd ACK.

Fixes: fed61c4b584c ("selftests: mptcp: make 2nd net namespace use tcp syn =
cookies unconditionally")
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index 2cfd87d94db8..e927df83efb9 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -493,7 +493,7 @@ do_transfer()
 		echo "${listener_ns} SYNRX: ${cl_proto} -> ${srv_proto}: expect ${expect=
_synrx}, got ${stat_synrx_now_l}"
 	fi
 	if [ $expect_ackrx -ne $stat_ackrx_now_l ] ;then
-		echo "${listener_ns} ACKRX: ${cl_proto} -> ${srv_proto}: expect ${expect=
_synrx}, got ${stat_synrx_now_l}"
+		echo "${listener_ns} ACKRX: ${cl_proto} -> ${srv_proto}: expect ${expect=
_ackrx}, got ${stat_ackrx_now_l} "
 	fi
 =

 	if [ $retc -eq 0 ] && [ $rets -eq 0 ];then
-- =

2.29.2

--===============6921800501573043834==--
