Content-Type: multipart/mixed; boundary="===============0913489362607868033=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v7 10/11] tcp: clean ext on tx recycle
Date: Thu, 09 Jan 2020 07:59:23 -0800
Message-ID: <20200109155924.30122-11-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20200109155924.30122-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3324

--===============0913489362607868033==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>

Otherwise we will find stray/unexpected/old extensions value on next
iteration.

On tcp_write_xmit() we can end-up splitting an already queued skb in two
parts, via tso_fragment(). The newly created skb can be allocated via
the tx cache and an upper layer will not be aware of it, so that upper
layer cannot set the ext properly.

Resetting the ext on recycle ensures that stale data is not propagated
in to packet headers or elsewhere.

An alternative would be add an additional hook in tso_fragment() or in
sk_stream_alloc_skb() to init the ext for upper layers that need it.

Co-developed-by: Florian Westphal <fw(a)strlen.de>
Signed-off-by: Florian Westphal <fw(a)strlen.de>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
Reviewed-by: Eric Dumazet <edumazet(a)google.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 include/net/sock.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index 8766f9bc3e70..432ff73d20f3 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1464,6 +1464,7 @@ static inline void sk_wmem_free_skb(struct sock *sk, =
struct sk_buff *skb)
 	sk_mem_uncharge(sk, skb->truesize);
 	if (static_branch_unlikely(&tcp_tx_skb_cache_key) &&
 	    !sk->sk_tx_skb_cache && !skb_cloned(skb)) {
+		skb_ext_reset(skb);
 		skb_zcopy_clear(skb, true);
 		sk->sk_tx_skb_cache =3D skb;
 		return;
-- =

2.24.1

--===============0913489362607868033==--
