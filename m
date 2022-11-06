Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDBB2916
	for <mptcp@lists.linux.dev>; Sun,  6 Nov 2022 15:24:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1667748272; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=dwUSmQwTDcXjqUtBRNwXZplV5+Tiq7RiFeqBuiuS3f2+SM2Sfrp4cQDp9KdF9yfub2MTTNaIZsqPEyhnQCj67Joi64qpRZlKlAQ+NfmX0OHErlgqqcBXyPyB7kWFpA937EzkJ2g4Wj/y4hnIPP5oEQSNyUcacGIPXsv6utglU74=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1667748272; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=uBHnCaTPkCl9ptAXn/bUliRp2mKgDTipt1hXqdKTF7I=; 
	b=iG5bMCY0bfqLz1zlEI/EILtTeXvlAPGESdZVZcGn0NxSjbKBRPRhEC4CpGNL8yXQOwEVIAoIG44U+Mx5UcgTPtvJPJWQ8SlIQyDznrkKQGmhUMnRf/MODHRkazxzh7K235lP8HFBWx0aGyzKjhSPQuMLIOe1KqbyAMvU99VrKzE=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1667748272;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=uBHnCaTPkCl9ptAXn/bUliRp2mKgDTipt1hXqdKTF7I=;
	b=TIvyYeo2wYAzIg3bKQZyLevzUmj5kzuLBe/fGIq3nLrDdS+cQYqWem4lU9wJ2Oft
	hv6HsT6+ea5RtdmvNjGA+dgUc1ycEQZ4c+nlZT/aXh5wNJ4n5k39AMdoPtCwgFkGl/B
	xMMG3zPu2xsW9zqnOMLsSITpC1Y0NmQ9Dr12K6vI=
Received: from localhost.localdomain (vps-940813d4.vps.ovh.net [198.244.188.50]) by mx.zoho.eu
	with SMTPS id 1667748271351834.3852447482699; Sun, 6 Nov 2022 16:24:31 +0100 (CET)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20221106152411.655-4-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v15 3/5] mptcp: add subflow_v(4,6)_send_synack()
Date: Sun,  6 Nov 2022 15:24:09 +0000
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221106152411.655-1-dmytro@shytyi.net>
References: <20221106152411.655-1-dmytro@shytyi.net>
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
 net/mptcp/fastopen.c | 47 ++++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.c | 11 +----------
 net/mptcp/protocol.h | 12 +++++++++++
 net/mptcp/subflow.c  | 42 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 102 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index d6fb45e6be4f..2a36a83cd846 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -4,6 +4,53 @@
=20
 #include "protocol.h"
=20
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
+=09/* initialize MPTCP_CB */
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
 void mptcp_gen_msk_ackseq_fastopen(struct mptcp_sock *msk, struct mptcp_su=
bflow_context *subflow,
 =09=09=09=09   struct mptcp_options_received mp_opt)
 {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f4247218fd1b..bf04f4161070 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -36,15 +36,6 @@ struct mptcp6_sock {
 };
 #endif
=20
-struct mptcp_skb_cb {
-=09u64 map_seq;
-=09u64 end_seq;
-=09u32 offset;
-=09u8  has_rxtstamp:1;
-};
-
-#define MPTCP_SKB_CB(__skb)=09((struct mptcp_skb_cb *)&((__skb)->cb[0]))
-
 enum {
 =09MPTCP_CMSG_TS =3D BIT(0),
 =09MPTCP_CMSG_INQ =3D BIT(1),
@@ -200,7 +191,7 @@ static void mptcp_rfree(struct sk_buff *skb)
 =09mptcp_rmem_uncharge(sk, len);
 }
=20
-static void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk)
+void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk)
 {
 =09skb_orphan(skb);
 =09skb->sk =3D sk;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f4b6f817ec46..b3dfd0dacde5 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -126,6 +126,15 @@
 #define MPTCP_CONNECTED=09=096
 #define MPTCP_RESET_SCHEDULER=097
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
 static inline bool before64(__u64 seq1, __u64 seq2)
 {
 =09return (__s64)(seq1 - seq2) < 0;
@@ -845,6 +854,9 @@ bool mptcp_userspace_pm_active(const struct mptcp_sock =
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
index 02a54d59697b..5e28b02822e4 100644
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
@@ -1927,6 +1967,7 @@ void __init mptcp_subflow_init(void)
=20
 =09subflow_request_sock_ipv4_ops =3D tcp_request_sock_ipv4_ops;
 =09subflow_request_sock_ipv4_ops.route_req =3D subflow_v4_route_req;
+=09subflow_request_sock_ipv4_ops.send_synack =3D subflow_v4_send_synack;
=20
 =09subflow_specific =3D ipv4_specific;
 =09subflow_specific.conn_request =3D subflow_v4_conn_request;
@@ -1940,6 +1981,7 @@ void __init mptcp_subflow_init(void)
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 =09subflow_request_sock_ipv6_ops =3D tcp_request_sock_ipv6_ops;
 =09subflow_request_sock_ipv6_ops.route_req =3D subflow_v6_route_req;
+=09subflow_request_sock_ipv6_ops.send_synack =3D subflow_v6_send_synack;
=20
 =09subflow_v6_specific =3D ipv6_specific;
 =09subflow_v6_specific.conn_request =3D subflow_v6_conn_request;
--=20
2.34.1


