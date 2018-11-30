Content-Type: multipart/mixed; boundary="===============7536152104789827743=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH v4 12/17] skbuff: Add private data pointer
Date: Fri, 30 Nov 2018 12:11:07 -0800
Message-ID: <20181130201112.21806-13-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20181130201112.21806-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 865

--===============7536152104789827743==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Allow struct sk_buff to be optionally extended when the control buffer
space is insufficient. New pointers for the extended data and associated
destructor are placed at the end of the data structure and left
uninitialized so cache behavior of struct sk_buff is unchanged when the
new pointers are not accessed.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 include/linux/skbuff.h | 13 ++++++++++++-
 net/core/skbuff.c      |  5 +++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 73902acf2b71..0cf47059c4bf 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -633,6 +633,7 @@ typedef unsigned char *sk_buff_data_t;
  *	@queue_mapping: Queue mapping for multiqueue devices
  *	@xmit_more: More SKBs are pending for this queue
  *	@pfmemalloc: skbuff was allocated from PFMEMALLOC reserves
+ *	@priv_used: priv and priv_destructor contain valid data
  *	@ndisc_nodetype: router type (from link layer)
  *	@ooo_okay: allow the mapping of a socket to a queue to be changed
  *	@l4_hash: indicate hash is a canonical 4-tuple hash over transport
@@ -662,6 +663,8 @@ typedef unsigned char *sk_buff_data_t;
  *	@data: Data head pointer
  *	@truesize: Buffer size
  *	@users: User count - see {datagram,tcp}.c
+ *	@priv: Optional pointer to skb private data
+ *	@priv_destructor: Private data destruct function
  */
 =

 struct sk_buff {
@@ -743,7 +746,8 @@ struct sk_buff {
 				peeked:1,
 				head_frag:1,
 				xmit_more:1,
-				pfmemalloc:1;
+				pfmemalloc:1,
+				priv_used:1;
 =

 	/* fields enclosed in headers_start/headers_end are copied
 	 * using a single memcpy() in __copy_skb_header()
@@ -866,6 +870,13 @@ struct sk_buff {
 				*data;
 	unsigned int		truesize;
 	refcount_t		users;
+
+	/* Uninitialized private pointers. At the very end so they do not
+	 * affect cache behavior of the rest of struct sk_buff when left
+	 * unused. All three must be initialized when priv_used is set.
+	 */
+	void			*priv;
+	void			(*priv_destructor)(struct sk_buff *skb);
 };
 =

 #ifdef __KERNEL__
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 3c814565ed7c..ccdb50708d72 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -611,6 +611,10 @@ void skb_release_head_state(struct sk_buff *skb)
 		WARN_ON(in_irq());
 		skb->destructor(skb);
 	}
+	if (skb->priv_used && skb->priv_destructor) {
+		WARN_ON(in_irq());
+		skb->priv_destructor(skb);
+	}
 #if IS_ENABLED(CONFIG_NF_CONNTRACK)
 	nf_conntrack_put(skb_nfct(skb));
 #endif
@@ -859,6 +863,7 @@ static struct sk_buff *__skb_clone(struct sk_buff *n, s=
truct sk_buff *skb)
 	n->nohdr =3D 0;
 	n->peeked =3D 0;
 	C(pfmemalloc);
+	n->priv_used =3D 0;
 	n->destructor =3D NULL;
 	C(tail);
 	C(end);
-- =

2.19.1


--===============7536152104789827743==--
