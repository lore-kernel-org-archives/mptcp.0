Content-Type: multipart/mixed; boundary="===============6797055703423438728=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] selftests: remove pcap captures with 'make clean'
Date: Sun, 01 Dec 2019 00:21:53 +0100
Message-ID: <f1d3c918c854ade4978b423865d253899297f372.1575155865.git.dcaratti@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 2723

--===============6797055703423438728==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

use EXTRA_CLEAN variable to ensure that pcap captures are removed with
'make clean'

Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
---

Notes:
    squash-to: "mptcp: add basic kselftest for mptcp"

 tools/testing/selftests/net/mptcp/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/sel=
ftests/net/mptcp/Makefile
index 0fc5d45055ee..93de52016dde 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -8,4 +8,6 @@ TEST_PROGS :=3D mptcp_connect.sh
 =

 TEST_GEN_FILES =3D mptcp_connect
 =

+EXTRA_CLEAN :=3D *.pcap
+
 include ../../lib.mk
-- =

2.23.0

--===============6797055703423438728==--
