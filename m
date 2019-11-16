Content-Type: multipart/mixed; boundary="===============4411789076505942741=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 06/10] selftests:mptcp: only display the NS id
Date: Sat, 16 Nov 2019 13:59:32 +0100
Message-ID: <20191116125936.3563275-7-matthieu.baerts@tessares.net>
In-Reply-To: 20191116125936.3563275-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2567

--===============4411789076505942741==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

instead of displaying:

  ns4-5dcfada6-91cmhp MPTCP -> ns3-5dcfada6-91cmhp (...)

we only keep:

  ns4 MPTCP -> ns3 (...)

Note that the full name is displayed before in the INFO messages.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    to be squashed in "mptcp: add basic kselftest for mptcp"

 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index f413a7f3379c..8f5844c2f4cd 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -320,7 +320,7 @@ do_transfer()
 	:> "$capout"
 =

 	addr_port=3D$(printf "%s:%d" ${connect_addr} ${port})
-	printf "%-4s %-5s -> %-4s (%-20s) %-5s\t" ${connector_ns} ${cl_proto} ${l=
istener_ns} ${addr_port} ${srv_proto}
+	printf "%.3s %-5s -> %.3s (%-20s) %-5s\t" ${connector_ns} ${cl_proto} ${l=
istener_ns} ${addr_port} ${srv_proto}
 =

 	if $capture; then
 	    if [ -z $SUDO_USER ] ; then
-- =

2.24.0

--===============4411789076505942741==--
