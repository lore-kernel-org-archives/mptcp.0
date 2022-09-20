Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535521C2C
	for <mptcp@lists.linux.dev>; Tue, 20 Sep 2022 12:52:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663678372; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=K14jNiPf9oz69zqrsupFNNQdd0Ui4FOKVkyZV/XD4CJlzgN5BRzu5uckUuoeG5LU/GvPEa5P5ZM3NJ8zRt4L00a42++Kwk7g3AfxcP1mBrWqlAvbgOqRh0XZiKHyPfebxEBJggMCrrw59rQZ4PUaDiRr1IQ8EqHL+7blsgg0m18=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663678372; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=2XZ7xI9ZUYlysUXOthx8OFRz0Ou/hN+oPvfOGP7eC78=; 
	b=NF5Bt37I675PhS8VRuEG7aROnlbdiheetxxGlMxghfO8p4mrgD5EQejvMEtcYzpFreSL/MGGELTTtv7CH8BMKr8gKDHAElie/Fy/zenYS18AP4KYVjc58PgXEnQ9i/r9sVZ+b4b1GE/Uim2buhSXUFIFmzVO7OBo+zCLKfop3U8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663678372;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=2XZ7xI9ZUYlysUXOthx8OFRz0Ou/hN+oPvfOGP7eC78=;
	b=RyjoWOQAoMYDEwh67qzz+nAKaXF4jBP5SIJGa63TrBeH4hyEFCJn7UbwPhhaz147
	x6eIrou0hLLnQezjI8KFX2vVfVEP0AkFBA5zaqiiHV4kVqTb8Ms82aec4+vmO6wKaBo
	2VL7EeKloEguy69Czgvt+9ADbPzJJTDTQm23c9b4=
Received: from doris.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663678369719293.1301311611096; Tue, 20 Sep 2022 14:52:49 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220920125243.2880-7-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v8 6/7] add skb to mskq in tcp_fastopen_add_skb()
Date: Tue, 20 Sep 2022 14:52:42 +0200
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920125243.2880-1-dmytro@shytyi.net>
References: <20220920125243.2880-1-dmytro@shytyi.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8

In the following patches we add skb to msk->receive_queue in the MPTCP
fastopen context.

Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
---
 include/net/tcp.h       |  2 +-
 net/ipv4/tcp_fastopen.c | 55 +++++++++++++++++++++++++++++++++++------
 net/ipv4/tcp_input.c    | 11 +++++++--
 net/mptcp/protocol.c    |  4 +--
 net/mptcp/protocol.h    |  2 ++
 5 files changed, 62 insertions(+), 12 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index a7d49e42470a..6456f90ed9ed 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1749,7 +1749,7 @@ int tcp_fastopen_reset_cipher(struct net *net, struct=
 sock *sk,
 =09=09=09      void *primary_key, void *backup_key);
 int tcp_fastopen_get_cipher(struct net *net, struct inet_connection_sock *=
icsk,
 =09=09=09    u64 *key);
-void tcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb);
+void tcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb, struct req=
uest_sock *req);
 struct sock *tcp_try_fastopen(struct sock *sk, struct sk_buff *skb,
 =09=09=09      struct request_sock *req,
 =09=09=09      struct tcp_fastopen_cookie *foc,
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 45cc7f1ca296..566706172828 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -3,6 +3,7 @@
 #include <linux/tcp.h>
 #include <linux/rcupdate.h>
 #include <net/tcp.h>
+#include "../mptcp/protocol.h"
=20
 void tcp_fastopen_init_key_once(struct net *net)
 {
@@ -166,8 +167,12 @@ static void tcp_fastopen_cookie_gen(struct sock *sk,
 /* If an incoming SYN or SYNACK frame contains a payload and/or FIN,
  * queue this additional data / FIN.
  */
-void tcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb)
+void tcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb, struct req=
uest_sock *req)
 {
+=09struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+=09struct tcp_request_sock *tcp_r_sock =3D tcp_rsk(req);
+=09struct sock *socket =3D mptcp_subflow_ctx(sk)->conn;
+=09struct mptcp_sock *msk =3D mptcp_sk(socket);
 =09struct tcp_sock *tp =3D tcp_sk(sk);
=20
 =09if (TCP_SKB_CB(skb)->end_seq =3D=3D tp->rcv_nxt)
@@ -194,7 +199,34 @@ void tcp_fastopen_add_skb(struct sock *sk, struct sk_b=
uff *skb)
 =09TCP_SKB_CB(skb)->tcp_flags &=3D ~TCPHDR_SYN;
=20
 =09tp->rcv_nxt =3D TCP_SKB_CB(skb)->end_seq;
+
+=09if (req && tp->syn_fastopen && sk_is_mptcp(sk))
+=09=09tcp_r_sock =3D tcp_rsk(req);
+=09else
+=09=09goto add_skb_to_sk;
+
+=09msk->is_mptfo =3D 1;
+
+=09//Solves: WARNING: at 704 _mptcp_move_skbs_from_subflow+0x5d0/0x651
+=09tp->copied_seq +=3D tp->rcv_nxt - tcp_r_sock->rcv_isn - 1;
+
+=09subflow->map_seq =3D mptcp_subflow_get_mapped_dsn(subflow);
+
+=09//Solves: BAD mapping: ssn=3D0 map_seq=3D1 map_data_len=3D3
+=09subflow->ssn_offset =3D tp->copied_seq - 1;
+
+=09skb_orphan(skb);
+=09skb->sk =3D socket;
+=09skb->destructor =3D mptcp_rfree;
+=09atomic_add(skb->truesize, &socket->sk_rmem_alloc);
+=09msk->rmem_fwd_alloc -=3D skb->truesize;
+
+=09__skb_queue_tail(&msk->receive_queue, skb);
+=09atomic64_set(&msk->rcv_wnd_sent, mptcp_subflow_get_mapped_dsn(subflow))=
;
+=09goto avoid_add_skb_to_sk;
+add_skb_to_sk:
 =09__skb_queue_tail(&sk->sk_receive_queue, skb);
+avoid_add_skb_to_sk:
 =09tp->syn_data_acked =3D 1;
=20
 =09/* u64_stats_update_begin(&tp->syncp) not needed here,
@@ -283,7 +315,7 @@ static struct sock *tcp_fastopen_create_child(struct so=
ck *sk,
=20
 =09tp->rcv_nxt =3D TCP_SKB_CB(skb)->seq + 1;
=20
-=09tcp_fastopen_add_skb(child, skb);
+=09tcp_fastopen_add_skb(child, skb, req);
=20
 =09tcp_rsk(req)->rcv_nxt =3D tp->rcv_nxt;
 =09tp->rcv_wup =3D tp->rcv_nxt;
@@ -350,17 +382,26 @@ struct sock *tcp_try_fastopen(struct sock *sk, struct=
 sk_buff *skb,
 =09bool syn_data =3D TCP_SKB_CB(skb)->end_seq !=3D TCP_SKB_CB(skb)->seq + =
1;
 =09int tcp_fastopen =3D READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_fastopen);
 =09struct tcp_fastopen_cookie valid_foc =3D { .len =3D -1 };
+=09struct tcp_sock *tp =3D tcp_sk(sk);
 =09struct sock *child;
 =09int ret =3D 0;
=20
 =09if (foc->len =3D=3D 0) /* Client requests a cookie */
 =09=09NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPFASTOPENCOOKIEREQD);
=20
-=09if (!((tcp_fastopen & TFO_SERVER_ENABLE) &&
-=09      (syn_data || foc->len >=3D 0) &&
-=09      tcp_fastopen_queue_check(sk))) {
-=09=09foc->len =3D -1;
-=09=09return NULL;
+=09if (tp->syn_fastopen && sk_is_mptcp(sk)) {
+=09=09if (((syn_data || foc->len >=3D 0) &&
+=09=09     tcp_fastopen_queue_check(sk))) {
+=09=09=09foc->len =3D -1;
+=09=09=09return NULL;
+=09=09}
+=09} else {
+=09=09if (!((tcp_fastopen & TFO_SERVER_ENABLE) &&
+=09=09      (syn_data || foc->len >=3D 0) &&
+=09=09      tcp_fastopen_queue_check(sk))) {
+=09=09=09foc->len =3D -1;
+=09=09=09return NULL;
+=09=09}
 =09}
=20
 =09if (tcp_fastopen_no_cookie(sk, dst, TFO_SERVER_COOKIE_NOT_REQD))
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index bc2ea12221f9..3facccee9dcb 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6134,7 +6134,7 @@ static bool tcp_rcv_fastopen_synack(struct sock *sk, =
struct sk_buff *synack,
 =09=09=09--tp->delivered;
 =09}
=20
-=09tcp_fastopen_add_skb(sk, synack);
+=09tcp_fastopen_add_skb(sk, synack, NULL);
=20
 =09return false;
 }
@@ -6954,7 +6954,14 @@ int tcp_conn_request(struct request_sock_ops *rsk_op=
s,
 =09if (IS_ENABLED(CONFIG_SMC) && want_cookie)
 =09=09tmp_opt.smc_ok =3D 0;
=20
-=09tmp_opt.tstamp_ok =3D tmp_opt.saw_tstamp;
+=09if (foc.len =3D=3D -1 && sk_is_mptcp(sk)) {
+=09=09tmp_opt.tstamp_ok =3D tmp_opt.saw_tstamp;
+=09} else {
+=09=09tmp_opt.tstamp_ok =3D 0;
+=09=09tcp_rsk(req)->ts_off =3D 1;
+=09=09tp->syn_fastopen =3D 1;
+=09}
+
 =09tcp_openreq_init(req, &tmp_opt, skb, sk);
 =09inet_rsk(req)->no_srccheck =3D inet_sk(sk)->transparent;
=20
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8cf307e4e59c..b2329ef298fd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -178,7 +178,7 @@ static void __mptcp_rmem_reclaim(struct sock *sk, int a=
mount)
 =09__sk_mem_reduce_allocated(sk, amount);
 }
=20
-static void mptcp_rmem_uncharge(struct sock *sk, int size)
+void mptcp_rmem_uncharge(struct sock *sk, int size)
 {
 =09struct mptcp_sock *msk =3D mptcp_sk(sk);
 =09int reclaimable;
@@ -191,7 +191,7 @@ static void mptcp_rmem_uncharge(struct sock *sk, int si=
ze)
 =09=09__mptcp_rmem_reclaim(sk, reclaimable);
 }
=20
-static void mptcp_rfree(struct sk_buff *skb)
+void mptcp_rfree(struct sk_buff *skb)
 {
 =09unsigned int len =3D skb->truesize;
 =09struct sock *sk =3D skb->sk;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3b9a349a7080..5d86cd7d8dab 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -840,6 +840,8 @@ void mptcp_event_addr_announced(const struct sock *ssk,=
 const struct mptcp_addr_
 void mptcp_event_addr_removed(const struct mptcp_sock *msk, u8 id);
 bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
 int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr, int =
addr_len, int flags);
+void mptcp_rmem_uncharge(struct sock *sk, int size);
+void mptcp_rfree(struct sk_buff *skb);
=20
 // Fast Open Mechanism functions begin
 int mptcp_setsockopt_sol_tcp_fastopen(struct mptcp_sock *msk, sockptr_t op=
tval,
--=20
2.25.1


