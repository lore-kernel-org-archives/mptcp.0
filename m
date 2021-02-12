Content-Type: multipart/mixed; boundary="===============7887881646251899147=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 2/4] selftests: mptcp: fix ACKRX debug message
Date: Fri, 12 Feb 2021 15:20:28 -0800
Message-ID: <20210212232030.377261-3-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20210212232030.377261-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7780

--===============7887881646251899147==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Info from received MPCapable SYN were printed instead of the ones from
received MPCapable 3rd ACK.

Fixes: fed61c4b584c ("selftests: mptcp: make 2nd net namespace use tcp syn =
cookies unconditionally")
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index 0c6b9d3c03c0..9ab35ae41628 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -502,7 +502,7 @@ do_transfer()
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

2.30.1

--===============7887881646251899147==--
