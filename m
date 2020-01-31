Content-Type: multipart/mixed; boundary="===============6343112608928695246=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [GIT] Sync with net-next on 20190131: a few conflicts
Date: Fri, 31 Jan 2020 18:42:49 +0100
Message-ID: <ff82f12d-c1e3-e64f-95ba-fff450928c78@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 3568

--===============6343112608928695246==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

It seems that recently, 'net-next' has been synced with 'net' which =

contains some modifications in MPTCP code. We then had a few conflicts =

due to Florian's patch-set, see: 55c6ab4b368 (Merge branch =

'mptcp-fix-sockopt-crash-and-lockdep-splats')

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=
=3Dd55c6ab4b368633f39f8fe059f3b877f978cfb4c

The first conflict is with: ae2dd7164943 (mptcp: handle tcp fallback =

when using syn cookies)


diff --cc net/mptcp/subflow.c
index 65122edf60aa,8b5945266890..000000000000
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@@ -772,7 -863,7 +868,11 @@@ static void subflow_ulp_clone(const str
         struct mptcp_subflow_context *old_ctx =3D mptcp_subflow_ctx(newsk);
         struct mptcp_subflow_context *new_ctx;

++<<<<<<< t/mptcp-Add-handling-of-incoming-MP_JOIN-requests base content
  +      if (!tcp_rsk(req)->is_mptcp || !subflow_req->mp_capable) {
++=3D=3D=3D=3D=3D=3D=3D
+       if (!subflow_req->mp_capable && !subflow_req->mp_join) {
++>>>>>>> remotes/origin/t/mptcp-Add-handling-of-incoming-MP_JOIN-requests
                 subflow_ulp_fallback(newsk, old_ctx);
                 return;
         }


The resolution:


diff --cc net/mptcp/subflow.c
index 8b5945266890,65122edf60aa..000000000000
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@@ -863,7 -772,7 +868,8 @@@ static void subflow_ulp_clone(const str
         struct mptcp_subflow_context *old_ctx =3D mptcp_subflow_ctx(newsk);
         struct mptcp_subflow_context *new_ctx;

-       if (!subflow_req->mp_capable && !subflow_req->mp_join) {
  -      if (!tcp_rsk(req)->is_mptcp || !subflow_req->mp_capable) {
++      if (!tcp_rsk(req)->is_mptcp ||
++          (!subflow_req->mp_capable && !subflow_req->mp_join)) {
                 subflow_ulp_fallback(newsk, old_ctx);
                 return;
         }


=E2=86=92 05f97b84e5d6: conflict in =

t/mptcp-Add-handling-of-incoming-MP_JOIN-requests


Another one caused by another patch from Florian: b2c5b614ca6e (mptcp: =

avoid a lockdep splat when mcast group was joined):


diff --cc net/mptcp/protocol.c
index 95bc6f9c6745,766a4b15c586..000000000000
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@@ -691,6 -794,11 +799,14 @@@ static void __mptcp_close(struct sock *
                 __mptcp_close_ssk(sk, ssk, subflow, timeout);
         }

++<<<<<<< t/mptcp-queue-data-for-mptcp-level-retransmission base content
++=3D=3D=3D=3D=3D=3D=3D
+       if (msk->cached_ext)
+               __skb_ext_put(msk->cached_ext);
+       __mptcp_clear_xmit(sk);
+       release_sock(sk);
+
++>>>>>>> remotes/origin/t/mptcp-queue-data-for-mptcp-level-retransmission
         sk_common_release(sk);
   }



The resolution:


diff --cc net/mptcp/protocol.c
index 766a4b15c586,95bc6f9c6745..000000000000
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@@ -788,7 -681,11 +789,13 @@@ static void __mptcp_close(struct sock *
         mptcp_token_destroy(msk->token);
         inet_sk_state_store(sk, TCP_CLOSE);

-       list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
+       list_splice_init(&msk->conn_list, &conn_list);
+
++      __mptcp_clear_xmit(sk);
++
+       release_sock(sk);
+
+       list_for_each_entry_safe(subflow, tmp, &conn_list, node) {
                 struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);

                 __mptcp_close_ssk(sk, ssk, subflow, timeout);


=E2=86=92 b62d04c9cdd9: conflict in =

t/mptcp-queue-data-for-mptcp-level-retransmission


Another conflict due to yet another patch from the series: c9fd9c5f4b93 =

(mptcp: defer freeing of cached ext until last moment)


diff --cc net/mptcp/protocol.c
index 65141c3d1574,60aca199fea2..000000000000
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@@ -1034,7 -1012,10 +1038,14 @@@ static struct sock *mptcp_accept(struc

   static void mptcp_destroy(struct sock *sk)
   {
++<<<<<<< t/mptcp-implement-memory-accounting-for-mptcp-rtx-queue
  +      sk_sockets_allocated_dec(sk);
++=3D=3D=3D=3D=3D=3D=3D
+       struct mptcp_sock *msk =3D mptcp_sk(sk);
+
+       if (msk->cached_ext)
+               __skb_ext_put(msk->cached_ext);
++>>>>>>> top-bases/t/mptcp-implement-memory-accounting-for-mptcp-rtx-queue
   }

   static int mptcp_setsockopt(struct sock *sk, int level, int optname,


The resolution:


diff --cc net/mptcp/protocol.c
index 65141c3d1574,60aca199fea2..000000000000
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@@ -1034,7 -1012,10 +1038,12 @@@ static struct sock *mptcp_accept(struc

   static void mptcp_destroy(struct sock *sk)
   {
+       struct mptcp_sock *msk =3D mptcp_sk(sk);
+
+       if (msk->cached_ext)
+               __skb_ext_put(msk->cached_ext);
++
  +      sk_sockets_allocated_dec(sk);
   }

   static int mptcp_setsockopt(struct sock *sk, int level, int optname,


=E2=86=92 ccc5451794ad: conflict in =

t/mptcp-implement-memory-accounting-for-mptcp-rtx-queue



Two last conflicts this time due to b2c5b614ca6e (mptcp: avoid a lockdep =

splat when mcast group was joined) again:


diff --cc net/mptcp/protocol.c
index fd6f434455df,e9ae42a8c49d..000000000000
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@@ -1052,13 -947,6 +1059,16 @@@ static void __mptcp_close(struct sock *
                 __mptcp_close_ssk(sk, ssk, subflow, timeout);
         }

++<<<<<<< t/mptcp-implement-and-use-MPTCP-level-retransmission
  +      if (msk->cached_ext)
  +              __skb_ext_put(msk->cached_ext);
  +      __mptcp_clear_xmit(sk);
  +      release_sock(sk);
  +
  +      mptcp_cancel_work(sk);
  +
++=3D=3D=3D=3D=3D=3D=3D
++>>>>>>> top-bases/t/mptcp-implement-and-use-MPTCP-level-retransmission
         sk_common_release(sk);
   }


and the resolution:


diff --cc net/mptcp/protocol.c
index fd6f434455df,e9ae42a8c49d..000000000000
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@@ -1052,13 -947,6 +1059,8 @@@ static void __mptcp_close(struct sock *
                 __mptcp_close_ssk(sk, ssk, subflow, timeout);
         }

-       if (msk->cached_ext)
-               __skb_ext_put(msk->cached_ext);
-       __mptcp_clear_xmit(sk);
-       release_sock(sk);
-
  +      mptcp_cancel_work(sk);
  +
         sk_common_release(sk);
   }



=E2=86=92 c4534101b55b: conflict in =

t/mptcp-implement-and-use-MPTCP-level-retransmission


And again due to the same patch:


diff --cc net/mptcp/protocol.c
index 0b5bf17419ac,76b11e9e6642..000000000000
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@@ -1111,9 -1096,13 +1112,19 @@@ static void __mptcp_close(struct sock *
         mptcp_token_destroy(msk->token);
         inet_sk_state_store(sk, TCP_CLOSE);

++<<<<<<< t/subflow-place-further-subflows-on-new-join_list
  +      __mptcp_flush_join_list(msk);
  +
  +      list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
++=3D=3D=3D=3D=3D=3D=3D
+       list_splice_init(&msk->conn_list, &conn_list);
+
+       __mptcp_clear_xmit(sk);
+
+       release_sock(sk);
+
+       list_for_each_entry_safe(subflow, tmp, &conn_list, node) {
++>>>>>>> top-bases/t/subflow-place-further-subflows-on-new-join_list
                 struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);

                 __mptcp_close_ssk(sk, ssk, subflow, timeout);


and the resolution:


diff --cc net/mptcp/protocol.c
index 0b5bf17419ac,76b11e9e6642..000000000000
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@@ -1111,9 -1096,13 +1112,15 @@@ static void __mptcp_close(struct sock *
         mptcp_token_destroy(msk->token);
         inet_sk_state_store(sk, TCP_CLOSE);

  +      __mptcp_flush_join_list(msk);
  +
-       list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
+       list_splice_init(&msk->conn_list, &conn_list);
+
+       __mptcp_clear_xmit(sk);
+
+       release_sock(sk);
+
+       list_for_each_entry_safe(subflow, tmp, &conn_list, node) {
                 struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);

                 __mptcp_close_ssk(sk, ssk, subflow, timeout);


=E2=86=92 fc30e7873372: conflict in =

t/subflow-place-further-subflows-on-new-join_list

I hope it is what you had in mind!

Tests + export are running!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============6343112608928695246==--
