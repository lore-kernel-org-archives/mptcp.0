Content-Type: multipart/mixed; boundary="===============8893599565799729807=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v6 11/11] skb: add helpers to allocate ext
 independently from sk_buff
Date: Tue, 07 Jan 2020 17:19:21 -0800
Message-ID: <20200108011921.28942-12-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20200108011921.28942-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3282

--===============8893599565799729807==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>

Currently we can allocate the extension only after the skb,
this change allows the user to do the opposite, will simplify
allocation failure handling from MPTCP.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 include/linux/skbuff.h |  3 +++
 net/core/skbuff.c      | 35 +++++++++++++++++++++++++++++++++--
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 1a261c3ee074..af9b6cf79a65 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4115,6 +4115,9 @@ struct skb_ext {
 	char data[0] __aligned(8);
 };
 =

+struct skb_ext *__skb_ext_alloc(void);
+void *__skb_ext_set(struct sk_buff *skb, enum skb_ext_id id,
+		    struct skb_ext *ext);
 void *skb_ext_add(struct sk_buff *skb, enum skb_ext_id id);
 void __skb_ext_del(struct sk_buff *skb, enum skb_ext_id id);
 void __skb_ext_put(struct skb_ext *ext);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a4106da23c34..48a7029529c9 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5987,7 +5987,14 @@ static void *skb_ext_get_ptr(struct skb_ext *ext, en=
um skb_ext_id id)
 	return (void *)ext + (ext->offset[id] * SKB_EXT_ALIGN_VALUE);
 }
 =

-static struct skb_ext *skb_ext_alloc(void)
+/**
+ * __skb_ext_alloc - allocate a new skb extensions storage
+ *
+ * Returns the newly allocated pointer. The pointer can later attached to a
+ * skb via __skb_ext_set().
+ * Note: caller must handle the skb_ext as an opaque data.
+ */
+struct skb_ext *__skb_ext_alloc(void)
 {
 	struct skb_ext *new =3D kmem_cache_alloc(skbuff_ext_cache, GFP_ATOMIC);
 =

@@ -6027,6 +6034,30 @@ static struct skb_ext *skb_ext_maybe_cow(struct skb_=
ext *old,
 	return new;
 }
 =

+/**
+ * __skb_ext_set - attach the specified extension storage to this skb
+ * @skb: buffer
+ * @id: extension id
+ * @ext: extension storage previously allocated via __skb_ext_alloc()
+ *
+ * Existing extensions, if any, are cleared.
+ *
+ * Returns the pointer to the extension.
+ */
+void *__skb_ext_set(struct sk_buff *skb, enum skb_ext_id id,
+		    struct skb_ext *ext)
+{
+	unsigned int newlen, newoff =3D SKB_EXT_CHUNKSIZEOF(*ext);
+
+	skb_ext_put(skb);
+	newlen =3D newoff + skb_ext_type_len[id];
+	ext->chunks =3D newlen;
+	ext->offset[id] =3D newoff;
+	skb->extensions =3D ext;
+	skb->active_extensions =3D 1 << id;
+	return skb_ext_get_ptr(ext, id);
+}
+
 /**
  * skb_ext_add - allocate space for given extension, COW if needed
  * @skb: buffer
@@ -6060,7 +6091,7 @@ void *skb_ext_add(struct sk_buff *skb, enum skb_ext_i=
d id)
 	} else {
 		newoff =3D SKB_EXT_CHUNKSIZEOF(*new);
 =

-		new =3D skb_ext_alloc();
+		new =3D __skb_ext_alloc();
 		if (!new)
 			return NULL;
 	}
-- =

2.24.1

--===============8893599565799729807==--
