Content-Type: multipart/mixed; boundary="===============2320760146843869470=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [GIT] Sync with net-next: 1 conflict
Date: Wed, 19 Jun 2019 11:40:24 +0200
Message-ID: <fc0952b3-e28a-4604-1945-a5757288934a@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1426

--===============2320760146843869470==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Just to inform you that we got a conflict when integrating last changes
from net-next:


--- a/include/net/sock.h
+++ b/include/net/sock.h
@@@ -1469,8 -1468,8 +1469,13 @@@ static inline void sk_wmem_free_skb(str
        sock_set_flag(sk, SOCK_QUEUE_SHRUNK);
        sk->sk_wmem_queued -=3D skb->truesize;
        sk_mem_uncharge(sk, skb->truesize);
++<<<<<<< t/tcp-clean-ext-on-tx-recycle base content
 +      if (static_branch_unlikely(&tcp_tx_skb_cache_key) &&
 +          !sk->sk_tx_skb_cache && !skb_cloned(skb)) {
++=3D=3D=3D=3D=3D=3D=3D
+       if (!sk->sk_tx_skb_cache && !skb_cloned(skb)) {
+               skb_ext_clear(skb);
++>>>>>>> remotes/origin/t/tcp-clean-ext-on-tx-recycle
                skb_zcopy_clear(skb, true);
                sk->sk_tx_skb_cache =3D skb;
                return;


It is very similar to the previous conflict we had. That's because of
this new commit 0b7d7f6b2208 (tcp: add tcp_tx_skb_cache sysctl) from
Eric Dumazet: the "if" condition has changed (again).

On our side, Paolo added one line after the "if" condition in
8b2e02e94442 (tcp: clean ext on tx recycle).

So it was a conflict easy to fix, see 4851d01562e5 and 66d6d7ec3e2b

Note that having only one conflict over so many other changes is good:

    4126 files changed, 10672 insertions(+), 35289 deletions(-)

Tests are still OK!

Cheers,
Matt

-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============2320760146843869470==--
