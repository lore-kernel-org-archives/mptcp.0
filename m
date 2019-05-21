Content-Type: multipart/mixed; boundary="===============2342820172789772217=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [GIT] Sync with net-next: conflict
Date: Tue, 21 May 2019 14:26:00 +0200
Message-ID: <e0fff648-e14c-f815-9a02-4bb37687a6e1@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1204

--===============2342820172789772217==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

With the last sync with net-next, a conflict was found:


diff --cc include/net/sock.h
index fd982f976925,0680fa988497..000000000000
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@@ -1473,8 -1473,7 +1473,12 @@@ static inline void sk_wmem_free_skb(str
        sock_set_flag(sk, SOCK_QUEUE_SHRUNK);
        sk->sk_wmem_queued -=3D skb->truesize;
        sk_mem_uncharge(sk, skb->truesize);
++<<<<<<< t/tcp-clean-ext-on-tx-recycle
 +      if (!sk->sk_tx_skb_cache) {
 +              skb_ext_clear(skb);
++=3D=3D=3D=3D=3D=3D=3D
+       if (!sk->sk_tx_skb_cache && !skb_cloned(skb)) {
++>>>>>>> top-bases/t/tcp-clean-ext-on-tx-recycle
                skb_zcopy_clear(skb, true);
                sk->sk_tx_skb_cache =3D skb;
                return;


The commit 8b2e02e94442 (tcp: clean ext on tx recycle) from Paolo was
conflicting with a new one from upstream: 858f50174467 (tcp: do not
recycle cloned skbs) from Eric Dumazet.

I simply added the new condition (&& !skb_cloned(skb)). I hope it is
alright: a73376082e4c6e3c9a48fd887f759ab1e4118477

The new sync has just been pushed.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============2342820172789772217==--
