Content-Type: multipart/mixed; boundary="===============5255780867317683675=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 3/3] selftests: mptcp: dump more info on
 mpjoin errors
Date: Wed, 24 Feb 2021 17:49:28 +0100
Message-ID: <20210224164928.2409821-4-matthieu.baerts@tessares.net>
In-Reply-To: 20210224164928.2409821-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 7944

--===============5255780867317683675==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Very occasionally, MPTCP selftests fail. Yeah, I saw that at least once!

Here we provide more details in case of errors with mptcp_join.sh script
like it was done with mptcp_connect.sh, see
commit 767389c8dd55 ("selftests: mptcp: dump more info on errors")

Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 6268fbf652cc..57cfceb77c5d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -77,6 +77,7 @@ cleanup_partial()
 =

 	for netns in "$ns1" "$ns2"; do
 		ip netns del $netns
+		rm -f /tmp/$netns.{nstat,out}
 	done
 }
 =

@@ -238,6 +239,11 @@ do_transfer()
 		sleep 1
 	fi
 =

+	NSTAT_HISTORY=3D/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
+		nstat -n
+	NSTAT_HISTORY=3D/tmp/${connector_ns}.nstat ip netns exec ${connector_ns} \
+		nstat -n
+
 	if [ $speed =3D "fast" ]; then
 		mptcp_connect=3D"./mptcp_connect -j"
 	else
@@ -374,12 +380,19 @@ do_transfer()
 	    kill $cappid
 	fi
 =

+	NSTAT_HISTORY=3D/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
+		nstat | grep Tcp > /tmp/${listener_ns}.out
+	NSTAT_HISTORY=3D/tmp/${connector_ns}.nstat ip netns exec ${connector_ns} \
+		nstat | grep Tcp > /tmp/${connector_ns}.out
+
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		echo " client exit code $retc, server $rets" 1>&2
 		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
-		ip netns exec ${listener_ns} ss -nita 1>&2 -o "sport =3D :$port"
+		ip netns exec ${listener_ns} ss -Menita 1>&2 -o "sport =3D :$port"
+		cat /tmp/${listener_ns}.out
 		echo -e "\nnetns ${connector_ns} socket stat for ${port}:" 1>&2
-		ip netns exec ${connector_ns} ss -nita 1>&2 -o "dport =3D :$port"
+		ip netns exec ${connector_ns} ss -Menita 1>&2 -o "dport =3D :$port"
+		cat /tmp/${connector_ns}.out
 =

 		cat "$capout"
 		ret=3D1
-- =

2.30.0

--===============5255780867317683675==--
