Content-Type: multipart/mixed; boundary="===============5103142697490106147=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [GIT] Sync with net-next on 20190710: 1 conflict
Date: Thu, 08 Aug 2019 17:57:45 +0200
Message-ID: <7f4a20ee-d279-5710-544a-44dcfbbdd7c0@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1611

--===============5103142697490106147==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Just to inform you that we got a conflict when integrating last changes
from net-next:


diff --cc include/net/tcp.h

index 2f774f8d2cb7,7385ff0a7484..000000000000

--- a/include/net/tcp.h

+++ b/include/net/tcp.h

@@@ -2112,10 -2112,11 +2112,13 @@@ struct tcp_ulp_ops



        /* initialize ulp */

        int (*init)(struct sock *sk);

 +      /* update ulp */

 +      void (*update)(struct sock *sk, struct proto *p);
        /* cleanup ulp */
        void (*release)(struct sock *sk);
+       /* clone ulp */
+       void (*clone)(const struct request_sock *req, struct sock
*newsk,
+                     const gfp_t priority);

        char            name[TCP_ULP_NAME_MAX];
        struct module   *owner;
@@@ -2125,7 -2126,8 +2128,12 @@@ void tcp_unregister_ulp(struct tcp_ulp_

  int tcp_set_ulp(struct sock *sk, const char *name);
  void tcp_get_available_ulp(char *buf, size_t len);
  void tcp_cleanup_ulp(struct sock *sk);
++<<<<<<< t/tcp-ulp-Add-clone-operation-to-tcp_ulp_ops base content

 +void tcp_update_ulp(struct sock *sk, struct proto *p);
++=3D=3D=3D=3D=3D=3D=3D
+ void tcp_clone_ulp(const struct request_sock *req,
+                  struct sock *newsk, const gfp_t priority);
++>>>>>>> remotes/origin/t/tcp-ulp-Add-clone-operation-to-tcp_ulp_ops


  #define MODULE_ALIAS_TCP_ULP(name)                            \

        __MODULE_INFO(alias, alias_userspace, name);            \


Very easy to fix, it is due to 95fa145479fb (bpf: sockmap/tls, close can
race with map free).

Our new "tcp_clone_ulp()" signature is now after tcp_update_ulp(), see
0bdd68fb6fa8 / 25f5f5399b6c for more details.

Tests are still OK!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============5103142697490106147==--
