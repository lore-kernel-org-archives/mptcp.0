Content-Type: multipart/mixed; boundary="===============5778054105878431497=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/2] selftests: mptcp: fix alignment 2 first tests
Date: Sat, 26 Oct 2019 09:47:44 +0200
Message-ID: <20191026074744.24352-3-matthieu.baerts@tessares.net>
In-Reply-To: 20191026074744.24352-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2335

--===============5778054105878431497==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Instead of:

 New MPTCP socket can be blocked via sysctl    [ OK ]
 setsockopt(..., TCP_ULP, "mptcp", ...) blocked        [ OK ]

We now have:

 New MPTCP socket can be blocked via sysctl            [ OK ]
 setsockopt(..., TCP_ULP, "mptcp", ...) blocked        [ OK ]

Yes, a detail but it is more visible that there are two tests at the
beginning.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    To squash in "mptcp: add basic kselftest for mptcp"

 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index 71073408e63b..b5367fe2c6ea 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -231,7 +231,7 @@ check_mptcp_disabled()
 =

 	# net.mptcp.enabled should be enabled by default
 	if [ "$(ip netns exec ${disabled_ns} sysctl net.mptcp.enabled | awk '{ pr=
int $3 }')" -ne 1 ]; then
-		echo -e "net.mptcp.enabled sysctl is not 1 by default\t[ FAIL ]"
+		echo -e "net.mptcp.enabled sysctl is not 1 by default\t\t[ FAIL ]"
 		ret=3D1
 		return 1
 	fi
@@ -243,12 +243,12 @@ check_mptcp_disabled()
 	ip netns delete ${disabled_ns}
 =

 	if [ ${err} -eq 0 ]; then
-		echo -e "New MPTCP socket cannot be blocked via sysctl\t[ FAIL ]"
+		echo -e "New MPTCP socket cannot be blocked via sysctl\t\t[ FAIL ]"
 		ret=3D1
 		return 1
 	fi
 =

-	echo -e "New MPTCP socket can be blocked via sysctl\t[ OK ]"
+	echo -e "New MPTCP socket can be blocked via sysctl\t\t[ OK ]"
 	return 0
 }
 =

-- =

2.20.1

--===============5778054105878431497==--
