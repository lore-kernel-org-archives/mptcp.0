Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A344C33C0
	for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 12:56:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663764966; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=RdH4qwsodOHLmu5k1M5opLh28aG/JWwsDjpsdmQ5rMctU/f5JkEM+YTVR4a9RVNQdrFP1cWpXiDzUYryVXROfu/76YOkiJ+ONJgQYxSejs/nDqP4YyQ6qpzn12EGCuEqukLd010bvuluvp7kly0zftEioi+UVpXOIHQ00oR1iwQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663764966; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=eokmlQ8oi4OXiUuVhpV+0KvYeCkgGnbZtyTz99fuKMY=; 
	b=XKxvWiGyUn8dW+/J3CvvujhqXdCeiRh6VzwYfannyp7XnQg24zWStdJiyXZYdR/zvq4wbHssUd8LyUQ97sDkZeCea2CbeNPuFApgQLYzglN/Jpg5guEoD5YTMRxXK0ReWoP3qz/o9JoBVkcWFerF6uj/krylLqJ3qaEJ3CrUPAE=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663764966;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=eokmlQ8oi4OXiUuVhpV+0KvYeCkgGnbZtyTz99fuKMY=;
	b=SJM8r6FzNfNFKHC8Wwd/t6ggjFlPO5Cm0aVJU6w+UnaV0Jw95z5KGQY0rypObGXu
	GM9rd5xs3IdVezJtIl5Kzbf8yTaqp6krKUZ6bbYaLdgtaU/MgVSC0ezHk5b4XFBu/hf
	2mJlfAjZC6xA3+/J3PgI4f1g+UlbPA/JFTmRzKfE=
Received: from doris.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663764963595498.2564563571075; Wed, 21 Sep 2022 14:56:03 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220921125558.19483-6-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v9 5/6] mptcp: add subflow_v(4,6)_send_synack()
Date: Wed, 21 Sep 2022 14:55:57 +0200
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220921125558.19483-1-dmytro@shytyi.net>
References: <20220921125558.19483-1-dmytro@shytyi.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8

In this patch we add skb to the msk, dequeue it from sk, remove TSs and
do skb mapping.

Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
---
 net/ipv4/tcp_fastopen.c | 19 +++++++----
 net/mptcp/protocol.c    |  2 +-
 net/mptcp/protocol.h    |  1 +
 net/mptcp/subflow.c     | 70 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 85 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 45cc7f1ca296..d6b1380525ea 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -356,13 +356,20 @@ struct sock *tcp_try_fastopen(struct sock *sk, struct=
 sk_buff *skb,
 =09if (foc->len =3D=3D 0) /* Client requests a cookie */
 =09=09NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPFASTOPENCOOKIEREQD);
=20
-=09if (!((tcp_fastopen & TFO_SERVER_ENABLE) &&
-=09      (syn_data || foc->len >=3D 0) &&
-=09      tcp_fastopen_queue_check(sk))) {
-=09=09foc->len =3D -1;
-=09=09return NULL;
+=09if (sk_is_mptcp(sk)) {
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
-
 =09if (tcp_fastopen_no_cookie(sk, dst, TFO_SERVER_COOKIE_NOT_REQD))
 =09=09goto fastopen;
=20
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d5c502d141b4..6a593be6076b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -200,7 +200,7 @@ static void mptcp_rfree(struct sk_buff *skb)
 =09mptcp_rmem_uncharge(sk, len);
 }
=20
-static void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk)
+void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk)
 {
 =09skb_orphan(skb);
 =09skb->sk =3D sk;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b9e251848099..58a04144fff0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -845,6 +845,7 @@ int mptcp_setsockopt_sol_tcp_fastopen(struct mptcp_sock=
 *msk, sockptr_t optval,
 =09=09=09=09      unsigned int optlen);
 void mptcp_gen_msk_ackseq_fastopen(struct mptcp_sock *msk, struct mptcp_su=
bflow_context *subflow,
 =09=09=09=09   struct mptcp_options_received mp_opt);
+void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk);
 // Fast Open Mechanism functions end
=20
 static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 07dd23d0fe04..7deb80c2af69 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -307,6 +307,74 @@ static struct dst_entry *subflow_v4_route_req(const st=
ruct sock *sk,
 =09return NULL;
 }
=20
+static int subflow_v4_send_synack(const struct sock *sk, struct dst_entry =
*dst,
+=09=09=09=09  struct flowi *fl,
+=09=09=09=09  struct request_sock *req,
+=09=09=09=09  struct tcp_fastopen_cookie *foc,
+=09=09=09=09  enum tcp_synack_type synack_type,
+=09=09=09=09  struct sk_buff *syn_skb)
+{
+=09struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+=09struct tcp_request_sock *tcp_r_sock =3D tcp_rsk(req);
+=09struct sock *socket =3D mptcp_subflow_ctx(sk)->conn;
+=09struct inet_request_sock *ireq =3D inet_rsk(req);
+=09struct mptcp_sock *msk =3D mptcp_sk(socket);
+=09struct sock *var_sk =3D subflow->tcp_sock;
+=09struct tcp_sock *tp =3D tcp_sk(sk);
+=09struct sk_buff *skb;
+
+=09//<evenutally clear tstamp_ok, as needed depending on cookie size>
+=09//We add ts here as in the "if" below it has no effect.
+=09if (foc->len > -1) {
+=09=09ireq->tstamp_ok =3D 0;
+=09}
+=09if (synack_type =3D=3D TCP_SYNACK_FASTOPEN) {
+=09=09// <mark subflow/msk as "mptfo">
+=09=09msk->is_mptfo =3D 1;
+
+=09=09skb =3D skb_peek(&var_sk->sk_receive_queue);
+
+=09=09//<dequeue the skb from sk receive queue>
+=09=09__skb_unlink(skb, &var_sk->sk_receive_queue);
+=09=09skb_ext_reset(skb);
+=09=09skb_orphan(skb);
+
+=09=09//<set the skb mapping>
+=09=09//Solves: WARNING: at 704 _mptcp_move_skbs_from_subflow+0x5d0/0x651
+=09=09tp->copied_seq +=3D tp->rcv_nxt - tcp_r_sock->rcv_isn - 1;
+
+=09=09subflow->map_seq =3D mptcp_subflow_get_mapped_dsn(subflow);
+
+=09=09//Solves: BAD mapping: ssn=3D0 map_seq=3D1 map_data_len=3D3
+=09=09subflow->ssn_offset =3D tp->copied_seq - 1;
+
+=09=09//<acquire the msk data lock>
+=09=09lock_sock((struct sock *)msk);
+
+=09=09//<move skb into msk receive queue>
+=09=09mptcp_set_owner_r(skb, (struct sock *)msk);
+=09=09__skb_queue_tail(&msk->receive_queue, skb);
+=09=09atomic64_set(&msk->rcv_wnd_sent, mptcp_subflow_get_mapped_dsn(subflo=
w));
+
+=09=09//<call msk data_ready>
+=09=09((struct sock *)msk)->sk_data_ready((struct sock *)msk);
+
+=09=09//<release the msk data lock>
+=09=09release_sock((struct sock *)msk);
+=09}
+=09return tcp_request_sock_ipv4_ops.send_synack(sk, dst, fl, req, foc, syn=
ack_type, syn_skb);
+}
+
+static int subflow_v6_send_synack(const struct sock *sk, struct dst_entry =
*dst,
+=09=09=09=09  struct flowi *fl,
+=09=09=09=09  struct request_sock *req,
+=09=09=09=09  struct tcp_fastopen_cookie *foc,
+=09=09=09=09  enum tcp_synack_type synack_type,
+=09=09=09=09  struct sk_buff *syn_skb)
+{
+=09return tcp_request_sock_ipv6_ops.send_synack(sk, dst, fl, req, foc, syn=
ack_type, syn_skb);
+}
+
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 static struct dst_entry *subflow_v6_route_req(const struct sock *sk,
 =09=09=09=09=09      struct sk_buff *skb,
@@ -1920,6 +1988,7 @@ void __init mptcp_subflow_init(void)
=20
 =09subflow_request_sock_ipv4_ops =3D tcp_request_sock_ipv4_ops;
 =09subflow_request_sock_ipv4_ops.route_req =3D subflow_v4_route_req;
+=09subflow_request_sock_ipv4_ops.send_synack =3D subflow_v4_send_synack;
=20
 =09subflow_specific =3D ipv4_specific;
 =09subflow_specific.conn_request =3D subflow_v4_conn_request;
@@ -1933,6 +2002,7 @@ void __init mptcp_subflow_init(void)
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 =09subflow_request_sock_ipv6_ops =3D tcp_request_sock_ipv6_ops;
 =09subflow_request_sock_ipv6_ops.route_req =3D subflow_v6_route_req;
+=09subflow_request_sock_ipv6_ops.send_synack =3D subflow_v6_send_synack;
=20
 =09subflow_v6_specific =3D ipv6_specific;
 =09subflow_v6_specific.conn_request =3D subflow_v6_conn_request;
--=20
2.25.1


