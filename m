Content-Type: multipart/mixed; boundary="===============6371324972060307162=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 5/7] mptcp: implement memory accounting for mptcp rtx
 queue
Date: Fri, 30 Aug 2019 17:04:00 +0200
Message-ID: <42c041ff8a9a0f40f1627d17481bc658d2b10fcf.1567177394.git.pabeni@redhat.com>
In-Reply-To: cover.1567177393.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1776

--===============6371324972060307162==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Charge the data on the rtx queue to the master MPTCP socket, too.
Such memory in uncharged when the data is acked/dequeued.

Also account mptcp sockets inuse via a protocol specific pcpu
counter.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
rfc v2 -> v1:
 - plug completely with tcp memory accounting including
   memory pressure.
 - use mptcp-specific socket in use counter

rfc v1 -> rfc v2:
 - initialize memory_allocated/sysctl_mem fields in struct proto,
   required to have mem accounting primitives do their work
 - deal with mem scheduling failure, bailing out the xmit
---
 net/mptcp/protocol.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2e294e043c0b..fe5f28f74422 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -17,6 +17,8 @@
 #include <net/mptcp.h>
 #include "protocol.h"
 =

+static struct percpu_counter mptcp_sockets_allocated;
+
 static void mptcp_set_timeout(const struct sock *sk, const struct sock *ss=
k)
 {
 	unsigned long tout =3D ssk && inet_csk(ssk)->icsk_pending ?
@@ -110,9 +112,10 @@ static inline bool mptcp_frag_can_collapse_to(const st=
ruct mptcp_sock *msk,
 		df->data_seq + df->data_len =3D=3D msk->write_seq;
 }
 =

-static void dfrag_clear(struct mptcp_data_frag *dfrag)
+static void dfrag_clear(struct sock *sk, struct mptcp_data_frag *dfrag)
 {
 	list_del(&dfrag->list);
+	sk_mem_uncharge(sk, dfrag->data_len + dfrag->overhead);
 	put_page(dfrag->page);
 }
 =

@@ -126,8 +129,9 @@ static void mptcp_clean_una(struct sock *sk)
 		if (after64(dfrag->data_seq + dfrag->data_len, snd_una))
 			break;
 =

-		dfrag_clear(dfrag);
+		dfrag_clear(sk, dfrag);
 	}
+	sk_mem_reclaim_partial(sk);
 }
 =

 /* ensure we get enough memory for the frag hdr, beyond some minimal amoun=
t of
@@ -236,6 +240,9 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct s=
ock *ssk,
 	if (!psize)
 		return -EINVAL;
 =

+	if (!sk_wmem_schedule(sk, psize + dfrag->overhead))
+		return -ENOMEM;
+
 	/* tell the TCP stack to delay the push so that we can safely
 	 * access the skb after the sendpages call
 	 */
@@ -257,6 +264,11 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct =
sock *ssk,
 		list_add_tail(&dfrag->list, &msk->rtx_queue);
 	}
 =

+	/* charge data on mptcp rtx queue to the master socket
+	 * Note: we charge such data both to sk and ssk
+	 */
+	sk->sk_forward_alloc -=3D frag_truesize;
+
 	collapsed =3D skb =3D=3D tcp_write_queue_tail(ssk);
 	BUG_ON(collapsed && !can_collapse);
 	if (collapsed) {
@@ -782,6 +794,8 @@ static int mptcp_init_sock(struct sock *sk)
 	if (ret)
 		return ret;
 =

+	sk_sockets_allocated_inc(sk);
+
 	if (!mptcp_is_enabled(sock_net(sk)))
 		return -ENOPROTOOPT;
 =

@@ -796,7 +810,7 @@ static void __mptcp_clear_xmit(struct sock *sk)
 	sk_stop_timer(sk, &msk->sk.icsk_retransmit_timer);
 =

 	list_for_each_entry_safe(dfrag, dtmp, &msk->rtx_queue, list)
-		dfrag_clear(dfrag);
+		dfrag_clear(sk, dfrag);
 }
 =

 static void mptcp_close(struct sock *sk, long timeout)
@@ -914,6 +928,8 @@ static void mptcp_destroy(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

+	sk_sockets_allocated_dec(sk);
+
 	pr_debug("msk=3D%p, subflow=3D%p", sk, msk->subflow->sk);
 =

 	token_destroy(msk->token);
@@ -1101,6 +1117,11 @@ static struct proto mptcp_prot =3D {
 	.hash		=3D inet_hash,
 	.unhash		=3D inet_unhash,
 	.get_port	=3D mptcp_get_port,
+	.sockets_allocated	=3D &mptcp_sockets_allocated,
+	.memory_allocated	=3D &tcp_memory_allocated,
+	.memory_pressure	=3D &tcp_memory_pressure,
+	.sysctl_wmem_offset	=3D offsetof(struct net, ipv4.sysctl_tcp_wmem),
+	.sysctl_mem	=3D sysctl_tcp_mem,
 	.obj_size	=3D sizeof(struct mptcp_sock),
 	.no_autobind	=3D 1,
 };
@@ -1343,6 +1364,9 @@ void mptcp_proto_init(void)
 	mptcp_stream_ops.listen =3D mptcp_listen;
 	mptcp_stream_ops.shutdown =3D mptcp_shutdown;
 =

+	if (percpu_counter_init(&mptcp_sockets_allocated, 0, GFP_KERNEL))
+		panic("Failed to allocate MPTCP pcpu counter\n");
+
 	token_init();
 	subflow_init();
 	pm_init();
-- =

2.21.0


--===============6371324972060307162==--
