Content-Type: multipart/mixed; boundary="===============0562678392960241639=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/2] squash-to: add basic kselftest program
Date: Wed, 12 Jun 2019 10:16:43 -0700
Message-ID: <20190612171643.21861-3-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20190612171643.21861-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1349

--===============0562678392960241639==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/test=
ing/selftests/net/mptcp/mptcp_connect.c
index 360b698e5ddd..fb60a5615093 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -23,7 +23,7 @@
 extern int optind;
 =

 #ifndef IPPROTO_MPTCP
-#define IPPROTO_MPTCP 99
+#define IPPROTO_MPTCP 262
 #endif
 =

 static bool listen_mode;
-- =

2.22.0


--===============0562678392960241639==--
