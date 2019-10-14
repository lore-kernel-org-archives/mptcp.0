Content-Type: multipart/mixed; boundary="===============2850965586860847999=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] selftests: allow compilation on older systems
Date: Mon, 14 Oct 2019 23:17:34 +0200
Message-ID: <20191014211734.29681-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 2114

--===============2850965586860847999==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

squashto: mptcp: add basic kselftest for mptcp

An older VM image i was using lacks TCP_ULP define, add a workaround.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/test=
ing/selftests/net/mptcp/mptcp_connect.c
index a472e056fae6..987a8411756e 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -26,6 +26,9 @@ extern int optind;
 #ifndef IPPROTO_MPTCP
 #define IPPROTO_MPTCP 262
 #endif
+#ifndef TCP_ULP
+#define TCP_ULP 31
+#endif
 =

 static bool listen_mode;
 static int  poll_timeout;
-- =

2.21.0

--===============2850965586860847999==--
