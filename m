Content-Type: multipart/mixed; boundary="===============5857894198663026406=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v4 7/9] selftests: mptcp: track duration of each test
Date: Fri, 25 Oct 2019 14:16:49 +0200
Message-ID: <20191025121651.25946-8-fw@strlen.de>
In-Reply-To: 20191025121651.25946-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2317

--===============5857894198663026406==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This allows to detect discrepancies, e.g.
MPTCP -> TCP   1s
TCP   -> MPTCP 0s
MPTCP -> MPTCP 41s

The expecation of course is that test duration is pretty similar
for tests between the same network namespaces, regardless of wheter
MPTCP or TCP fallback is used.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index 384b128696ec..880cefe40c72 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -256,6 +256,7 @@ do_transfer()
 =

 	sleep 1
 =

+	start=3D$(date +%s)
 	ip netns exec ${connector_ns} ./mptcp_connect -t $timeout -p $port -s ${c=
l_proto} $connect_addr < "$cin" > "$cout" &
 	cpid=3D$!
 =

@@ -264,13 +265,17 @@ do_transfer()
 	wait $spid
 	rets=3D$?
 =

+	stop=3D$(date +%s)
+
 	if [ $capture -eq 1 ]; then
 	    sleep 1
 	    kill $cappid
 	fi
 =

+	duration=3D$((stop-start))
+	duration=3D$(printf "(duration %03ss)" $duration)
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
-		echo "[ FAIL ] client exit code $retc, server $rets" 1>&2
+		echo "$duration [ FAIL ] client exit code $retc, server $rets" 1>&2
 		echo "\nnetns ${listener_ns} socket stat for $port:" 1>&2
 		ip netns exec ${listener_ns} ss -nita 1>&2 -o "sport =3D :$port"
 		echo "\nnetns ${connector_ns} socket stat for $port:" 1>&2
@@ -286,7 +291,7 @@ do_transfer()
 	rets=3D$?
 =

 	if [ $retc -eq 0 ] && [ $rets -eq 0 ];then
-		echo "[ OK ]"
+		echo "$duration [ OK ]"
 		cat "$capout"
 		return 0
 	fi
-- =

2.23.0

--===============5857894198663026406==--
