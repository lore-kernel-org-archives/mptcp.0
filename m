Content-Type: multipart/mixed; boundary="===============5465261791350880988=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 7/7] net: allow __skb_ext_alloc to sleep
Date: Mon, 11 May 2020 13:55:38 +0200
Message-ID: <20200511115538.6015-8-fw@strlen.de>
In-Reply-To: 20200511115538.6015-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4366

--===============5465261791350880988==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

mptcp calls this from the transmit side, from process context.
Allow a sleeping allocation instead of unconditional GFP_ATOMIC.

Acked-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 include/linux/skbuff.h | 2 +-
 net/core/skbuff.c      | 8 +++++---
 net/mptcp/protocol.c   | 4 +++-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 3000c526f552..531843952809 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4165,7 +4165,7 @@ struct skb_ext {
 	char data[] __aligned(8);
 };
 =

-struct skb_ext *__skb_ext_alloc(void);
+struct skb_ext *__skb_ext_alloc(gfp_t flags);
 void *__skb_ext_set(struct sk_buff *skb, enum skb_ext_id id,
 		    struct skb_ext *ext);
 void *skb_ext_add(struct sk_buff *skb, enum skb_ext_id id);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 1bf0c3d278e7..35a133c6d13b 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6087,13 +6087,15 @@ static void *skb_ext_get_ptr(struct skb_ext *ext, e=
num skb_ext_id id)
 /**
  * __skb_ext_alloc - allocate a new skb extensions storage
  *
+ * @flags: See kmalloc().
+ *
  * Returns the newly allocated pointer. The pointer can later attached to a
  * skb via __skb_ext_set().
  * Note: caller must handle the skb_ext as an opaque data.
  */
-struct skb_ext *__skb_ext_alloc(void)
+struct skb_ext *__skb_ext_alloc(gfp_t flags)
 {
-	struct skb_ext *new =3D kmem_cache_alloc(skbuff_ext_cache, GFP_ATOMIC);
+	struct skb_ext *new =3D kmem_cache_alloc(skbuff_ext_cache, flags);
 =

 	if (new) {
 		memset(new->offset, 0, sizeof(new->offset));
@@ -6188,7 +6190,7 @@ void *skb_ext_add(struct sk_buff *skb, enum skb_ext_i=
d id)
 	} else {
 		newoff =3D SKB_EXT_CHUNKSIZEOF(*new);
 =

-		new =3D __skb_ext_alloc();
+		new =3D __skb_ext_alloc(GFP_ATOMIC);
 		if (!new)
 			return NULL;
 	}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index da5f2a1c465d..6c8ff8a504ea 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -367,8 +367,10 @@ static void mptcp_stop_timer(struct sock *sk)
 =

 static bool mptcp_ext_cache_refill(struct mptcp_sock *msk)
 {
+	const struct sock *sk =3D (const struct sock *)msk;
+
 	if (!msk->cached_ext)
-		msk->cached_ext =3D __skb_ext_alloc();
+		msk->cached_ext =3D __skb_ext_alloc(sk->sk_allocation);
 =

 	return !!msk->cached_ext;
 }
-- =

2.26.2

--===============5465261791350880988==--
