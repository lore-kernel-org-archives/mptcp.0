Content-Type: multipart/mixed; boundary="===============1093244564311477135=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next] selftests: mptcp: support capture with
 other options
Date: Mon, 08 Mar 2021 14:51:31 +0100
Message-ID: <20210308135131.2517940-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 8075

--===============1093244564311477135==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A capture was not started when multiple short options were combined,
e.g.

  ./mptcp_join.sh -fc

A regex is now used to handle this case.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    If we want to reduce the number of commits, we might want to squash this
    one in "selftests: mptcp: Restore packet capture option in join tests"
    commit we have in our tree.
    Either is fine for me.

 tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index ca5bf22ca204..abeb24b7f8ec 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1410,9 +1410,13 @@ make_file "$sin" "server" 1
 trap cleanup EXIT
 =

 for arg in "$@"; do
-	if [ "$arg" =3D "-c" ]; then
+	# check for "capture" arg before launching tests
+	if [[ "${arg}" =3D~ ^"-"[0-9a-zA-Z]*"c"[0-9a-zA-Z]*$ ]]; then
 		capture=3D1
-	else
+	fi
+
+	# exception for the capture option, the rest means: a part of the tests
+	if [ "${arg}" !=3D "-c" ]; then
 		do_all_tests=3D0
 	fi
 done
-- =

2.30.1

--===============1093244564311477135==--
