Content-Type: multipart/mixed; boundary="===============7060398528981451104=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next] selftests: mptcp: interpret \n as a new line
Date: Wed, 16 Sep 2020 15:13:51 +0200
Message-ID: <20200916131352.3072764-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 5899

--===============7060398528981451104==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In case of errors, this message was printed:

  (...)
  # read: Resource temporarily unavailable
  #  client exit code 0, server 3
  # \nnetns ns1-0-BJlt5D socket stat for 10003:
  (...)

Obviously, the idea was to add a new line before the socket stat and not
print "\nnetns".

Fixes: b08fbf241064 ("selftests: add test-cases for MPTCP MP_JOIN")
Fixes: 048d19d444be ("mptcp: add basic kselftest for mptcp")
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    This commit improves the output in selftests in case of errors, mostly
    seen when modifying MPTCP code. The selftests behaviour is not changed.
    That's why this patch is proposed only for net-next.

 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 4 ++--
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index e4df9ba64824..2cfd87d94db8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -443,9 +443,9 @@ do_transfer()
 	duration=3D$(printf "(duration %05sms)" $duration)
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		echo "$duration [ FAIL ] client exit code $retc, server $rets" 1>&2
-		echo "\nnetns ${listener_ns} socket stat for $port:" 1>&2
+		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
 		ip netns exec ${listener_ns} ss -nita 1>&2 -o "sport =3D :$port"
-		echo "\nnetns ${connector_ns} socket stat for $port:" 1>&2
+		echo -e "\nnetns ${connector_ns} socket stat for ${port}:" 1>&2
 		ip netns exec ${connector_ns} ss -nita 1>&2 -o "dport =3D :$port"
 =

 		cat "$capout"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index f39c1129ce5f..c2943e4dfcfe 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -176,9 +176,9 @@ do_transfer()
 =

 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		echo " client exit code $retc, server $rets" 1>&2
-		echo "\nnetns ${listener_ns} socket stat for $port:" 1>&2
+		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
 		ip netns exec ${listener_ns} ss -nita 1>&2 -o "sport =3D :$port"
-		echo "\nnetns ${connector_ns} socket stat for $port:" 1>&2
+		echo -e "\nnetns ${connector_ns} socket stat for ${port}:" 1>&2
 		ip netns exec ${connector_ns} ss -nita 1>&2 -o "dport =3D :$port"
 =

 		cat "$capout"
-- =

2.27.0

--===============7060398528981451104==--
