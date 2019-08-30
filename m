Content-Type: multipart/mixed; boundary="===============4353378077059246466=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/7] mptcp: move before/after64 into the header file
Date: Fri, 30 Aug 2019 17:03:56 +0200
Message-ID: <506ed101cd1236c0f587b6f1d4cfae3a534e9859.1567177394.git.pabeni@redhat.com>
In-Reply-To: cover.1567177393.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1772

--===============4353378077059246466==
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
index c082a2731a66..15bd54f43d4b 100644
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
index 991ad288b892..8c36a379f67d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -279,4 +279,11 @@ static inline struct mptcp_ext *mptcp_get_ext(struct s=
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


--===============4353378077059246466==--
