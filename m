Content-Type: multipart/mixed; boundary="===============6405481732561200058=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 08/10] selftests:mptcp: do not reset "ret" when
 skipping
Date: Sat, 16 Nov 2019 13:59:34 +0100
Message-ID: <20191116125936.3563275-9-matthieu.baerts@tessares.net>
In-Reply-To: 20191116125936.3563275-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2569

--===============6405481732561200058==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In the loop, we will have the two ns having the same name, that's
normal. No need to return and error and reset ret to 0 (lret not
modified, init to 0).

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    to be squashed in "mptcp: add basic kselftest for mptcp"

 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index a8c55005cc0c..1e2a24946e36 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -426,8 +426,7 @@ run_tests_lo()
 =

 	# skip if test programs are running inside same netns for subsequent runs.
 	if [ $loopback -eq 0 ] && [ ${listener_ns} =3D ${connector_ns} ]; then
-		ret=3D$lret
-		return 1
+		return 0
 	fi
 =

 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} ${=
local_addr}
-- =

2.24.0

--===============6405481732561200058==--
