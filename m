Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1760B4C93
	for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 22:54:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1664319260; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=cXZFQfpwcu3Tk6aFavaI0pJSbDQGGW4H4wjUabfwiDAahtWnqVQhdjeoonc0s3hLK5GDdqecON4yA8uYF1o7OG/O9TPrYgygcHPJQZILjvH6wHjaVTqpgPvdC1TR+7QUNykvwS6kkZ097nCuYAsaQ+7iSVMal7l4nG2XyzTrArg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1664319260; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=NGUkgo3dSkuX/JOnRGP5gFdJh+kJcyaNwwKpsyK1Jsw=; 
	b=YkCiLG+9bbwvkTfqD6MBDkArIahn8aCcpfIZcgKBhiV8TCGTd57AyyPtclUjKsuc3Om9Od+jVS/QkIa1cJv8dyxvqAoYjWJET8gqzOmSzoiGekFuav4esI5BWR/5C8wLie5oo7JWPbM1NF6MGGt7aMZzHsct4WEaKDVgSA52Kfw=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1664319260;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=NGUkgo3dSkuX/JOnRGP5gFdJh+kJcyaNwwKpsyK1Jsw=;
	b=E1oWoLg7fBR0vqriI6MGSc3brq8YjrEK2uOv0199iC/+ppAxkRJhJeMfWFr43W+P
	GjahmSLOUsbuzFyeF6W6dPNhykzCGQMH1e09I8Dmd44Nih7dVnYITvgRL1ix8UHnaEc
	ILO/3yz20MVWvqmNBOg+dyiaF+8mHSosXPZpqjUY=
Received: from localhost.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1664319257546271.51229475042123; Wed, 28 Sep 2022 00:54:17 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220927225341.14165-4-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v12 3/7] mptcp: add subflow_v(4,6)_send_synack()
Date: Tue, 27 Sep 2022 22:53:37 +0000
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220927225341.14165-1-dmytro@shytyi.net>
References: <20220927225341.14165-1-dmytro@shytyi.net>
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
 net/ipv4/tcp_fastopen.c | 19 ++++++++++++------
 net/mptcp/fastopen.c    | 43 +++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.c    |  2 +-
 net/mptcp/protocol.h    |  3 +++
 net/mptcp/subflow.c     | 42 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 102 insertions(+), 7 deletions(-)

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
diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index d6fb45e6be4f..1d824a4d9606 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -17,3 +17,46 @@ void mptcp_gen_msk_ackseq_fastopen(struct mptcp_sock *ms=
k, struct mptcp_subflow_
 =09pr_debug("ack_seq=3D%llu sndr_key=3D%llu", msk->ack_seq, mp_opt.sndr_ke=
y);
 =09atomic64_set(&msk->rcv_wnd_sent, ack_seq);
 }
+
+void subflow_fastopen_send_synack_set_params(struct mptcp_subflow_context =
*subflow,
+=09=09=09=09=09     struct request_sock *req)
+{
+=09struct tcp_request_sock *tcp_r_sock =3D tcp_rsk(req);
+=09struct sock *ssk =3D subflow->tcp_sock;
+=09struct sock *sk =3D subflow->conn;
+=09struct mptcp_sock *msk;
+=09struct sk_buff *skb;
+=09struct tcp_sock *tp;
+
+=09msk =3D mptcp_sk(sk);
+=09tp =3D tcp_sk(ssk);
+
+=09/* <mark subflow/msk as "mptfo"> */
+=09msk->is_mptfo =3D 1;
+
+=09skb =3D skb_peek(&ssk->sk_receive_queue);
+
+=09/* <dequeue the skb from sk receive queue> */
+=09__skb_unlink(skb, &ssk->sk_receive_queue);
+=09skb_ext_reset(skb);
+=09skb_orphan(skb);
+
+=09/* <set the skb mapping> */
+=09tp->copied_seq +=3D tp->rcv_nxt - tcp_r_sock->rcv_isn - 1;
+=09subflow->map_seq =3D mptcp_subflow_get_mapped_dsn(subflow);
+=09subflow->ssn_offset =3D tp->copied_seq - 1;
+
+=09/* <acquire the msk data lock> */
+=09mptcp_data_lock(sk);
+
+=09/* <move skb into msk receive queue> */
+=09mptcp_set_owner_r(skb, sk);
+=09__skb_queue_tail(&msk->receive_queue, skb);
+=09atomic64_set(&msk->rcv_wnd_sent, mptcp_subflow_get_mapped_dsn(subflow))=
;
+
+=09/* <call msk data_ready> */
+=09(sk)->sk_data_ready(sk);
+
+=09/* <release the msk data lock> */
+=09mptcp_data_unlock(sk);
+}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0db50712bad7..7e63b414011c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -206,7 +206,7 @@ static void mptcp_rfree(struct sk_buff *skb)
 =09mptcp_rmem_uncharge(sk, len);
 }
=20
-static void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk)
+void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk)
 {
 =09skb_orphan(skb);
 =09skb->sk =3D sk;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a9708a2eb2bc..9c46e802a73a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -842,6 +842,9 @@ bool mptcp_userspace_pm_active(const struct mptcp_sock =
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
index 07dd23d0fe04..c48143bff114 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -307,6 +307,46 @@ static struct dst_entry *subflow_v4_route_req(const st=
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
+=09/* <evenutally clear tstamp_ok, as needed depending on cookie size> */
+=09if (foc)
+=09=09ireq->tstamp_ok =3D 0;
+
+=09if (synack_type =3D=3D TCP_SYNACK_FASTOPEN)
+=09=09subflow_fastopen_send_synack_set_params(subflow, req);
+
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
+=09struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+=09struct inet_request_sock *ireq =3D inet_rsk(req);
+
+=09/* <evenutally clear tstamp_ok, as needed depending on cookie size> */
+=09if (foc)
+=09=09ireq->tstamp_ok =3D 0;
+
+=09if (synack_type =3D=3D TCP_SYNACK_FASTOPEN)
+=09=09subflow_fastopen_send_synack_set_params(subflow, req);
+
+=09return tcp_request_sock_ipv6_ops.send_synack(sk, dst, fl, req, foc, syn=
ack_type, syn_skb);
+}
+
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 static struct dst_entry *subflow_v6_route_req(const struct sock *sk,
 =09=09=09=09=09      struct sk_buff *skb,
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


