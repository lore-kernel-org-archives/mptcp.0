Content-Type: multipart/mixed; boundary="===============3679509276261319015=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] tcp: clean ext on tx recycle
Date: Wed, 15 May 2019 12:22:30 +0200
Message-ID: <3eba3c63b8dcecb873c7a6b4695a1283c63be164.1557915674.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 1173

--===============3679509276261319015==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Otherwise we will find stray/unexpected/old extensions
value on next iteration.

On tcp_write_xmit() we can end-up splitting an already queued
skb in two parts, via tso_fragment(). The newly created skb
can be allocated via the tx cache and the mptcp stack will not
be aware of it, so nobody set properly the MPTCP ext.

End result, we transmit the skb using an hold MPTCP DSS map
and that confuses the rx side/corrupt the stream. It requires
some concurrent conditions, so it's not deterministic.

Resetting the ext on recycle fixes all the current mptcp self tests
issues.

Apparently only MPTCP has issues with this kind of stray ext,
so an alternative would be add an additional mptcp hook in
tso_fragment() or in sk_stream_alloc_skb() to always init
the ext.

Note that setting/allocating the MPTCP ext in sk_stream_alloc_skb
for MPTCP socket, we also resolve the fixme in mptcp_sendmsg_frag().

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
--
Note: intentionally not adding fixes tags here. Even if small,
I think it should not be squashed in other commits, other opinion
welcome!
---
 include/linux/skbuff.h | 8 ++++++++
 include/net/sock.h     | 1 +
 2 files changed, 9 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 0f6719d9a6bd..c6256eadf59a 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4027,6 +4027,14 @@ static inline void skb_ext_put(struct sk_buff *skb)
 		__skb_ext_put(skb->extensions);
 }
 =

+static inline void skb_ext_clear(struct sk_buff *skb)
+{
+	if (skb->active_extensions) {
+		__skb_ext_put(skb->extensions);
+		skb->active_extensions =3D 0;
+	}
+}
+
 static inline void __skb_ext_copy(struct sk_buff *dst,
 				  const struct sk_buff *src)
 {
diff --git a/include/net/sock.h b/include/net/sock.h
index 4d208c0f9c14..fd982f976925 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1474,6 +1474,7 @@ static inline void sk_wmem_free_skb(struct sock *sk, =
struct sk_buff *skb)
 	sk->sk_wmem_queued -=3D skb->truesize;
 	sk_mem_uncharge(sk, skb->truesize);
 	if (!sk->sk_tx_skb_cache) {
+		skb_ext_clear(skb);
 		skb_zcopy_clear(skb, true);
 		sk->sk_tx_skb_cache =3D skb;
 		return;
-- =

2.20.1


--===============3679509276261319015==--
