Content-Type: multipart/mixed; boundary="===============3858579822531931332=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/2] selftests: mptcp: track duration in ms
Date: Sat, 26 Oct 2019 09:47:43 +0200
Message-ID: <20191026074744.24352-2-matthieu.baerts@tessares.net>
In-Reply-To: 20191026074744.24352-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2334

--===============3858579822531931332==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I was mostly seeing 0/1s. Now it is in ms, 5 digits (up to 99 seconds).

 (10.0.1.1:10000) MPTCP       (duration   201ms) [ OK ]
 (10.0.1.1:10001) TCP         (duration   161ms) [ OK ]
 (10.0.1.1:10002) MPTCP       (duration   174ms) [ OK ]
 (10.0.1.2:10003) MPTCP       (duration   178ms) [ OK ]
 (10.0.2.1:10004) MPTCP       (duration   162ms) [ OK ]
 (10.0.2.2:10005) MPTCP       (duration   174ms) [ OK ]
 (10.0.3.2:10006) MPTCP       (duration   172ms) [ OK ]
 (10.0.3.1:10007) MPTCP       (duration   201ms) [ OK ]
 (10.0.1.1:10008) MPTCP       (duration   170ms) [ OK ]
 (10.0.2.2:10009) MPTCP       (duration   170ms) [ OK ]
 (10.0.3.2:10010) MPTCP       (duration   371ms) [ OK ]
 (10.0.3.1:10011) MPTCP       (duration   178ms) [ OK ]
 (10.0.1.1:10012) MPTCP       (duration   170ms) [ OK ]
 (10.0.1.2:10013) MPTCP       (duration  1201ms) [ OK ]
 (10.0.2.1:10014) MPTCP       (duration   168ms) [ OK ]
 (10.0.3.1:10015) MPTCP       (duration   166ms) [ OK ]
 (10.0.1.1:10016) MPTCP       (duration   177ms) [ OK ]
 (10.0.1.2:10017) MPTCP       (duration   180ms) [ OK ]
 (10.0.2.1:10018) MPTCP       (duration   169ms) [ OK ]
 (10.0.2.2:10019) MPTCP       (duration   166ms) [ OK ]
 (10.0.3.2:10020) MPTCP       (duration   166ms) [ OK ]

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    To squash in "mptcp: add basic kselftest for mptcp"

 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index fbebb4cbd3fa..71073408e63b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -324,7 +324,7 @@ do_transfer()
 =

 	sleep 1
 =

-	start=3D$(date +%s)
+	start=3D$(date +%s%3N)
 	ip netns exec ${connector_ns} ./mptcp_connect -t $timeout -p $port -s ${c=
l_proto} $connect_addr < "$cin" > "$cout" &
 	cpid=3D$!
 =

@@ -333,7 +333,7 @@ do_transfer()
 	wait $spid
 	rets=3D$?
 =

-	stop=3D$(date +%s)
+	stop=3D$(date +%s%3N)
 =

 	if $capture; then
 	    sleep 1
@@ -341,7 +341,7 @@ do_transfer()
 	fi
 =

 	duration=3D$((stop-start))
-	duration=3D$(printf "(duration %03ss)" $duration)
+	duration=3D$(printf "(duration %05sms)" $duration)
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		echo "$duration [ FAIL ] client exit code $retc, server $rets" 1>&2
 		echo "\nnetns ${listener_ns} socket stat for $port:" 1>&2
-- =

2.20.1

--===============3858579822531931332==--
