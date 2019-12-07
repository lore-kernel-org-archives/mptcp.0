Content-Type: multipart/mixed; boundary="===============7788599357605291075=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: Fix dd command line option
Date: Fri, 06 Dec 2019 16:10:22 -0800
Message-ID: <20191207001022.20098-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 2839

--===============7788599357605291075==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

"conv=3D" is a valid command line parameter, but "conf=3D" is not. The error
message is redirected to /dev/null so it is not obvious when running
tests. The tests seem to pass either way, so it's not clear that even
the "conv=3D" is really needed.

squashto: mptcp: add basic kselftest for mptcp
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index e4c76f5766e4..d573a0feb98d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -445,7 +445,7 @@ make_file()
 	SIZE=3D$((RANDOM % 1024))
 	SIZE=3D$((SIZE + 128))
 	TSIZE=3D$((TSIZE + SIZE))
-	dd if=3D/dev/urandom conf=3Dnotrunc of=3D"$name" bs=3D1 count=3D$SIZE 2> =
/dev/null
+	dd if=3D/dev/urandom conv=3Dnotrunc of=3D"$name" bs=3D1 count=3D$SIZE 2> =
/dev/null
 	echo -e "\nMPTCP_TEST_FILE_END_MARKER" >> "$name"
 =

 	echo "Created $name (size $TSIZE) containing data sent by $who"
-- =

2.24.0

--===============7788599357605291075==--
