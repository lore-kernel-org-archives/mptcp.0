Content-Type: multipart/mixed; boundary="===============7315031871576521175=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH v2 1/8] mptcp: move before/after64 into the header
 file
Date: Thu, 22 Aug 2019 15:47:38 +0200
Message-ID: <3e5d99820b25d968e1cd83275a8bf9e53274b523.1566481012.git.pabeni@redhat.com>
In-Reply-To: cover.1566481012.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1667

--===============7315031871576521175==
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
index aaa71b161c1a..5b7ddbe64e4b 100644
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
index 68877e952780..9f261ee31917 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -275,4 +275,11 @@ static inline struct mptcp_ext *mptcp_get_ext(struct s=
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


--===============7315031871576521175==--
