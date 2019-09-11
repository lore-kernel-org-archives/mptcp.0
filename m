Content-Type: multipart/mixed; boundary="===============8487310839146303586=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 1/7] mptcp: move before/after64 into the header file
Date: Wed, 11 Sep 2019 14:55:35 +0200
Message-ID: <d5dd0329a97e4f4815f049b993c01f5ec1383b02.1568206133.git.pabeni@redhat.com>
In-Reply-To: cover.1568206133.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1819

--===============8487310839146303586==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

So that we can reuse in multiple files

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
--
Squash to "mptcp: Implement MPTCP receive path"
---
 net/mptcp/protocol.c | 7 -------
 net/mptcp/protocol.h | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d5b0c801e78f..8b0573f1e027 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -17,13 +17,6 @@
 #include <net/mptcp.h>
 #include "protocol.h"
 =

-static inline bool before64(__u64 seq1, __u64 seq2)
-{
-	return (__s64)(seq1 - seq2) < 0;
-}
-
-#define after64(seq2, seq1)	before64(seq1, seq2)
-
 static struct socket *__mptcp_fallback_get_ref(const struct mptcp_sock *ms=
k)
 {
 	sock_owned_by_me((const struct sock *)msk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 40f0efaef55e..c0196e4a300e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -271,4 +271,11 @@ static inline struct mptcp_ext *mptcp_get_ext(struct s=
k_buff *skb)
 	return (struct mptcp_ext *)skb_ext_find(skb, SKB_EXT_MPTCP);
 }
 =

+static inline bool before64(__u64 seq1, __u64 seq2)
+{
+	return (__s64)(seq1 - seq2) < 0;
+}
+
+#define after64(seq2, seq1)	before64(seq1, seq2)
+
 #endif /* __MPTCP_PROTOCOL_H */
-- =

2.21.0


--===============8487310839146303586==--
