Content-Type: multipart/mixed; boundary="===============4363525317658757457=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-net-next 06/14] mptcp: Make
 mptcp_set_new_pathindex lockless
Date: Thu, 03 May 2018 14:04:50 -0700
Message-ID: <20180503210458.21524-7-cpaasch@apple.com>
In-Reply-To: 20180503210458.21524-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 606

--===============4363525317658757457==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is quite a complex logic just for setting the next path-index. It
also prevents us from making the operation lockless.

Let's simplify this and make it lockless through a simple
test_and_set_bit.

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
(cherry picked from commit e426daa6e7bf3797aee5993258cecc5bc8a89c31)
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 include/net/mptcp.h    | 34 +---------------------------------
 net/mptcp/mptcp_ctrl.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 33 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index f6ca550d9e6c..43f7f2ae1bad 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -326,9 +326,7 @@ struct mptcp_cb {
 	u8 mptcp_pm[MPTCP_PM_SIZE] __aligned(8);
 	struct mptcp_pm_ops *pm_ops;
 =

-	u32 path_index_bits;
-	/* Next pi to pick up in case a new path becomes available */
-	u8 next_path_index;
+	unsigned long path_index_bits;
 =

 	__u8	mptcp_ver;
 =

@@ -1247,36 +1245,6 @@ static inline bool mptcp_fallback_infinite(struct so=
ck *sk, int flag)
 	return false;
 }
 =

-/* Find the first index whose bit in the bit-field =3D=3D 0 */
-static inline u8 mptcp_set_new_pathindex(struct mptcp_cb *mpcb)
-{
-	u8 base =3D mpcb->next_path_index;
-	int i;
-
-	/* Start at 1, because 0 is reserved for the meta-sk */
-	mptcp_for_each_bit_unset(mpcb->path_index_bits >> base, i) {
-		if (i + base < 1)
-			continue;
-		if (i + base >=3D sizeof(mpcb->path_index_bits) * 8)
-			break;
-		i +=3D base;
-		mpcb->path_index_bits |=3D (1 << i);
-		mpcb->next_path_index =3D i + 1;
-		return i;
-	}
-	mptcp_for_each_bit_unset(mpcb->path_index_bits, i) {
-		if (i >=3D sizeof(mpcb->path_index_bits) * 8)
-			break;
-		if (i < 1)
-			continue;
-		mpcb->path_index_bits |=3D (1 << i);
-		mpcb->next_path_index =3D i + 1;
-		return i;
-	}
-
-	return 0;
-}
-
 static inline bool mptcp_v6_is_v4_mapped(const struct sock *sk)
 {
 	return sk->sk_family =3D=3D AF_INET6 &&
diff --git a/net/mptcp/mptcp_ctrl.c b/net/mptcp/mptcp_ctrl.c
index 1e67d5d6c87d..c2aae9020d91 100644
--- a/net/mptcp/mptcp_ctrl.c
+++ b/net/mptcp/mptcp_ctrl.c
@@ -1316,6 +1316,22 @@ void mptcp_fallback_meta_sk(struct sock *meta_sk)
 	kmem_cache_free(mptcp_cb_cache, tcp_sk(meta_sk)->mpcb);
 }
 =

+/*  Called without holding lock on mpcb */
+static u8 mptcp_set_new_pathindex(struct mptcp_cb *mpcb)
+{
+	int i;
+
+	/* Start at 1, because 0 is reserved for the meta-sk */
+	for (i =3D 1; i < sizeof(mpcb->path_index_bits) * 8; i++) {
+		if (!test_and_set_bit(i, &mpcb->path_index_bits))
+			break;
+	}
+
+	if (i =3D=3D sizeof(mpcb->path_index_bits) * 8)
+		return 0;
+	return i;
+}
+
 int mptcp_add_sock(struct sock *meta_sk, struct sock *sk, u8 loc_id, u8 re=
m_id,
 		   gfp_t flags)
 {
-- =

2.16.2


--===============4363525317658757457==--
