Content-Type: multipart/mixed; boundary="===============0631632395472211930=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/3] skb: add helpers to allocate ext independently
 from sk_buff
Date: Mon, 02 Dec 2019 11:24:21 +0100
Message-ID: <1b7884633059302ca77fddfaab9155ec8e75cf0c.1575281285.git.pabeni@redhat.com>
In-Reply-To: cover.1575281285.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2729

--===============0631632395472211930==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently we can allocate the extension only after the skb,
this change allow the user to do the opposite, will simplify
allocation failure handling from MPTCP.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 include/linux/skbuff.h |  3 +++
 net/core/skbuff.c      | 16 +++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index f641fc76f47e..1bbb77640045 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4111,6 +4111,9 @@ struct skb_ext {
 	char data[0] __aligned(8);
 };
 =

+struct skb_ext *skb_ext_alloc(void);
+void *__skb_ext_add(struct sk_buff *skb, enum skb_ext_id id,
+		    struct skb_ext *ext);
 void *skb_ext_add(struct sk_buff *skb, enum skb_ext_id id);
 void __skb_ext_del(struct sk_buff *skb, enum skb_ext_id id);
 void __skb_ext_put(struct skb_ext *ext);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 0aba2cd69881..e8ed6d28fba8 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5981,7 +5981,7 @@ static void *skb_ext_get_ptr(struct skb_ext *ext, enu=
m skb_ext_id id)
 	return (void *)ext + (ext->offset[id] * SKB_EXT_ALIGN_VALUE);
 }
 =

-static struct skb_ext *skb_ext_alloc(void)
+struct skb_ext *skb_ext_alloc(void)
 {
 	struct skb_ext *new =3D kmem_cache_alloc(skbuff_ext_cache, GFP_ATOMIC);
 =

@@ -6021,6 +6021,20 @@ static struct skb_ext *skb_ext_maybe_cow(struct skb_=
ext *old,
 	return new;
 }
 =

+void *__skb_ext_add(struct sk_buff *skb, enum skb_ext_id id,
+		    struct skb_ext *ext)
+{
+	unsigned int newlen, newoff =3D SKB_EXT_CHUNKSIZEOF(*ext);
+
+	skb_ext_put(skb);
+	newlen =3D newoff + skb_ext_type_len[id];
+	ext->chunks =3D newlen;
+	ext->offset[id] =3D newoff;
+	skb->extensions =3D ext;
+	skb->active_extensions |=3D 1 << id;
+	return skb_ext_get_ptr(ext, id);
+}
+
 /**
  * skb_ext_add - allocate space for given extension, COW if needed
  * @skb: buffer
-- =

2.21.0

--===============0631632395472211930==--
