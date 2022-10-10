Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0DB5CBD
	for <mptcp@lists.linux.dev>; Mon, 10 Oct 2022 22:18:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1665440308; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Z72lMRtB88ZId2jYOb4JWMsie5Ne7XY5trl2Dkj29NuAGOlsOJ85BioEo7cl5bFuN1sqO94ZShgFaj7VDcrvu7wBiz4ECTG9WrFrz5fQUvk13pLxvJPdBkWFoOGr4J82n/Z7bzoKQ7btFzveVKU5+8/moo2kRPEq/vyeZuV/2fE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1665440308; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=0STQSYL3rOD1U1464f8CPMLuxkL/9A1MVWkaQQQuUQE=; 
	b=hEQ98g0rS7SmmTT3WJFmKLEpgPGYn32yQvULTfPfyQuXeH8jfuo6RVh2lo8xhtlXaxkLoEQbcMiVcDTgt6cGNqf2w82ZYQZqhxEsCFwsz0rXInwnhnuutryr1k64qL5S2yIpMjYHqO2/GQj+VOYg79mX2Yg9RfvROrmBZj3NLC8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1665440308;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=0STQSYL3rOD1U1464f8CPMLuxkL/9A1MVWkaQQQuUQE=;
	b=c5+HKBsrqtmh9Vojy4h5fbMDH4wIj7RrR0n7xdtTJHXEfiZreGuYajsRGNQ/oW34
	mgb5WwkPsCE97X9pbZvCEv1/W2Z7fekmjdZT+ytCZSst/5J44OgvtzjBeW1p0vQ+gU1
	oDB8uFEmPQdmWncunHwvpJePfN8r9QDAyc/lpyIo=
Received: from localhost.localdomain (vps-940813d4.vps.ovh.net [198.244.188.50]) by mx.zoho.eu
	with SMTPS id 1665440307208502.7425994858363; Tue, 11 Oct 2022 00:18:27 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20221010221809.1792-4-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v14 3/5] mptcp: add subflow_v(4,6)_send_synack()
Date: Mon, 10 Oct 2022 22:18:07 +0000
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221010221809.1792-1-dmytro@shytyi.net>
References: <20221010221809.1792-1-dmytro@shytyi.net>
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
 net/mptcp/fastopen.c | 78 ++++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.c |  2 +-
 net/mptcp/protocol.h |  3 ++
 net/mptcp/subflow.c  | 42 ++++++++++++++++++++++++
 4 files changed, 124 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index d6fb45e6be4f..f9ed409fdfb7 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -4,6 +4,84 @@
=20
 #include "protocol.h"
=20
+struct mptcp_skb_cb {
+=09u64 map_seq;
+=09u64 end_seq;
+=09u32 offset;
+=09u8  has_rxtstamp:1;
+};
+
+#define MPTCP_SKB_CB(__skb)=09((struct mptcp_skb_cb *)&((__skb)->cb[0]))
+
+void subflow_fastopen_send_synack_set_params(struct mptcp_subflow_context =
*subflow,
+=09=09=09=09=09     struct request_sock *req)
+{
+=09struct tcp_request_sock *treq =3D tcp_rsk(req);
+=09struct sock *ssk =3D subflow->tcp_sock;
+=09struct sock *sk =3D subflow->conn;
+=09struct mptcp_sock *msk;
+=09struct sk_buff *skb;
+=09struct tcp_sock *tp;
+=09u32 offset;
+
+=09msk =3D mptcp_sk(sk);
+=09tp =3D tcp_sk(ssk);
+
+=09/* mark subflow/msk as "mptfo" */
+=09msk->is_mptfo =3D 1;
+
+=09skb =3D skb_peek(&ssk->sk_receive_queue);
+
+=09/* dequeue the skb from sk receive queue */
+=09__skb_unlink(skb, &ssk->sk_receive_queue);
+=09skb_ext_reset(skb);
+=09skb_orphan(skb);
+
+=09/* set the skb mapping */
+=09tp->copied_seq +=3D tp->rcv_nxt - treq->rcv_isn - 1;
+=09subflow->map_seq =3D mptcp_subflow_get_mapped_dsn(subflow);
+=09subflow->ssn_offset =3D tp->copied_seq - 1;
+
+=09/* innitialize MPTCP_CB */
+=09offset =3D tp->copied_seq - TCP_SKB_CB(skb)->seq;
+=09MPTCP_SKB_CB(skb)->map_seq =3D mptcp_subflow_get_mapped_dsn(subflow);
+=09MPTCP_SKB_CB(skb)->end_seq =3D MPTCP_SKB_CB(skb)->map_seq +
+=09=09=09=09     (skb->len - offset);
+=09MPTCP_SKB_CB(skb)->offset =3D offset;
+=09MPTCP_SKB_CB(skb)->has_rxtstamp =3D TCP_SKB_CB(skb)->has_rxtstamp;
+
+=09mptcp_data_lock(sk);
+
+=09mptcp_set_owner_r(skb, sk);
+=09__skb_queue_tail(&msk->receive_queue, skb);
+
+=09(sk)->sk_data_ready(sk);
+
+=09mptcp_data_unlock(sk);
+}
+
+void __mptcp_pre_connect(struct mptcp_sock *msk, struct sock *ssk,
+=09=09=09 struct msghdr *msg, size_t size)
+{
+=09struct tcp_sock *tp;
+=09struct sk_buff *skb;
+=09struct ubuf_info *uarg;
+
+=09lock_sock(ssk);
+
+=09tp =3D tcp_sk(ssk);
+
+=09skb =3D tcp_write_queue_tail(ssk);
+=09uarg =3D msg_zerocopy_realloc(ssk, size, skb_zcopy(skb));
+=09tp->fastopen_req =3D kzalloc(sizeof(*tp->fastopen_req),
+=09=09=09=09   ssk->sk_allocation);
+=09tp->fastopen_req->data =3D msg;
+=09tp->fastopen_req->size =3D size;
+=09tp->fastopen_req->uarg =3D uarg;
+
+=09release_sock(ssk);
+}
+
 void mptcp_gen_msk_ackseq_fastopen(struct mptcp_sock *msk, struct mptcp_su=
bflow_context *subflow,
 =09=09=09=09   struct mptcp_options_received mp_opt)
 {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b06f9bbe0e0a..a7571cae2807 100644
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
index 41276788626b..257a3a62a71b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -844,6 +844,9 @@ bool mptcp_userspace_pm_active(const struct mptcp_sock =
*msk);
 // Fast Open Mechanism functions begin
 void mptcp_gen_msk_ackseq_fastopen(struct mptcp_sock *msk, struct mptcp_su=
bflow_context *subflow,
 =09=09=09=09   struct mptcp_options_received mp_opt);
+void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk);
+void subflow_fastopen_send_synack_set_params(struct mptcp_subflow_context =
*subflow,
+=09=09=09=09=09     struct request_sock *req);
 // Fast Open Mechanism functions end
=20
 static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 07dd23d0fe04..0fbc45eb7bec 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -307,7 +307,47 @@ static struct dst_entry *subflow_v4_route_req(const st=
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
+=09struct inet_request_sock *ireq =3D inet_rsk(req);
+
+=09/* clear tstamp_ok, as needed depending on cookie */
+=09if (foc && foc->len > -1)
+=09=09ireq->tstamp_ok =3D 0;
+
+=09if (synack_type =3D=3D TCP_SYNACK_FASTOPEN)
+=09=09subflow_fastopen_send_synack_set_params(subflow, req);
+
+=09return tcp_request_sock_ipv4_ops.send_synack(sk, dst, fl, req, foc, syn=
ack_type, syn_skb);
+}
+
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
+static int subflow_v6_send_synack(const struct sock *sk, struct dst_entry =
*dst,
+=09=09=09=09  struct flowi *fl,
+=09=09=09=09  struct request_sock *req,
+=09=09=09=09  struct tcp_fastopen_cookie *foc,
+=09=09=09=09  enum tcp_synack_type synack_type,
+=09=09=09=09  struct sk_buff *syn_skb)
+{
+=09struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+=09struct inet_request_sock *ireq =3D inet_rsk(req);
+
+=09/* clear tstamp_ok, as needed depending on cookie */
+=09if (foc && foc->len > -1)
+=09=09ireq->tstamp_ok =3D 0;
+
+=09if (synack_type =3D=3D TCP_SYNACK_FASTOPEN)
+=09=09subflow_fastopen_send_synack_set_params(subflow, req);
+
+=09return tcp_request_sock_ipv6_ops.send_synack(sk, dst, fl, req, foc, syn=
ack_type, syn_skb);
+}
+
 static struct dst_entry *subflow_v6_route_req(const struct sock *sk,
 =09=09=09=09=09      struct sk_buff *skb,
 =09=09=09=09=09      struct flowi *fl,
@@ -1920,6 +1960,7 @@ void __init mptcp_subflow_init(void)
=20
 =09subflow_request_sock_ipv4_ops =3D tcp_request_sock_ipv4_ops;
 =09subflow_request_sock_ipv4_ops.route_req =3D subflow_v4_route_req;
+=09subflow_request_sock_ipv4_ops.send_synack =3D subflow_v4_send_synack;
=20
 =09subflow_specific =3D ipv4_specific;
 =09subflow_specific.conn_request =3D subflow_v4_conn_request;
@@ -1933,6 +1974,7 @@ void __init mptcp_subflow_init(void)
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 =09subflow_request_sock_ipv6_ops =3D tcp_request_sock_ipv6_ops;
 =09subflow_request_sock_ipv6_ops.route_req =3D subflow_v6_route_req;
+=09subflow_request_sock_ipv6_ops.send_synack =3D subflow_v6_send_synack;
=20
 =09subflow_v6_specific =3D ipv6_specific;
 =09subflow_v6_specific.conn_request =3D subflow_v6_conn_request;
--=20
2.34.1


