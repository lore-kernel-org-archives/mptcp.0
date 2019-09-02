Content-Type: multipart/mixed; boundary="===============1897056430533358755=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [GIT] Sync with net-next on 20190902: 1 conflict
Date: Mon, 02 Sep 2019 16:39:46 +0200
Message-ID: <3bdda923-f868-92c3-e1fa-086f22ba17b1@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1784

--===============1897056430533358755==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Just to inform you that we got a conflict when integrating last changes
from net-next:



diff --cc include/net/tcp.h
index 509b5539d3d1,8124b44cf28b..000000000000
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@@ -2126,9 -2126,9 +2126,15 @@@ struct tcp_ulp_ops
        void (*update)(struct sock *sk, struct proto *p);
        /* cleanup ulp */
        void (*release)(struct sock *sk);
++<<<<<<< t/tcp-ulp-Add-clone-operation-to-tcp_ulp_ops base content
 +      /* diagnostic */
 +      int (*get_info)(const struct sock *sk, struct sk_buff *skb);
 +      size_t (*get_info_size)(const struct sock *sk);
++=3D=3D=3D=3D=3D=3D=3D
+       /* clone ulp */
+       void (*clone)(const struct request_sock *req, struct sock *newsk,
+                     const gfp_t priority);
++>>>>>>> remotes/origin/t/tcp-ulp-Add-clone-operation-to-tcp_ulp_ops

        char            name[TCP_ULP_NAME_MAX];
        struct module   *owner;



Very easy to fix, it is due to 61723b393292 (tcp: ulp: add functions to
dump ulp-specific information) by Davide.

Our new "clone" callback is now after get_info_size one, see
263a17f30fe7 for more details.

That's nice these patches are upstream! I guess Davide will then provide
one extra patch to silence new Sparse issue :)

Tests are still OK!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============1897056430533358755==--
