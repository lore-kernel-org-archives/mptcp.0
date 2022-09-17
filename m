Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50805CB8
	for <mptcp@lists.linux.dev>; Sat, 17 Sep 2022 22:29:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663453761; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Kc+ddRLyJ6Vy7jPDpjCeSgcAxY4fmbtSGRyDimgVu3k7fiZ4wWK83Yy7mnhAgdCDoTf4of7JpwRxTTTbBwnvgRXot/NOUfjxcBAHJvsrI4c2u5K1oNGSGHgJ+WOxp/1rp5uN0ZbC5G3r0k508l5fCe7WeypuEpmQsBruatdeTC8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663453761; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=CjnHzb19W1HTiaiy3mDtVHHyf8GTgmbek5aJWS5nu7s=; 
	b=lXprRpUO0j18v9qEuGMsGELwGUVx82gqTS5RyDBrVNuwggoMbVAzZHPCrruZ+z0gNVtR/6GnlbuTjdpIwk/9TloOg/t7MDcNEFdd3hPbI5GAmWZHkZOxKsJUGlZlHyR1pKZ0HBl7pFtR0Dm1OS1f6MUqkdndYvxLeWE0NdoEzmc=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663453761;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=CjnHzb19W1HTiaiy3mDtVHHyf8GTgmbek5aJWS5nu7s=;
	b=NGBBkFjG8oGUGzJrNTMvrU8Oehrqv4Ryke0AbutmD3ELhv3l+n9wu0R7VJW7SN0D
	Xlprrvqc15BP6S3gxtUE7EBlTpXIPqomHdY7uOCvu4g1Ds0mxNAR7lmMLDuiNWYoNLm
	fORILZbiVgdBBpiNgneF5RtA1/NY2n1iZoxNDpe8=
Received: from doris.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 166345375965291.97026866699537; Sun, 18 Sep 2022 00:29:19 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220917222853.2406-11-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v7 10/11] mptcp_fastopen_add_skb() helpers (skb to msk)
Date: Sun, 18 Sep 2022 00:28:52 +0200
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220917222853.2406-1-dmytro@shytyi.net>
References: <20220917222853.2406-1-dmytro@shytyi.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

Set of helpers for mptcp_skb_add(). Some functions are inspired from tcp
fastopen.c file. This chain helps to add =E2=80=9Cskb=E2=80=9D to=20
=E2=80=9C&msk->sk_receive_queue=E2=80=9D
Example: =E2=80=9Csubflow_v4_conn_request=E2=80=9D->=E2=80=9Dmptcp_conn_req=
uest=E2=80=9D->
=E2=80=9Dmptcp_try_fastopen=E2=80=9D->=E2=80=9Dmptcp_fastopen_create_child=
=E2=80=9D->
=E2=80=9Dmptcp_fastopen_add_skb=E2=80=9D

Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
---
 include/net/tcp.h       |  27 +++++++
 net/ipv4/tcp_fastopen.c |  38 +++++-----
 net/ipv4/tcp_input.c    |  20 ++---
 net/mptcp/fastopen.c    | 163 ++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h    |  39 ++++++++++
 net/mptcp/subflow.c     |   2 +-
 6 files changed, 261 insertions(+), 28 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 735e957f7f4b..dc072d120f32 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1729,6 +1729,33 @@ int tcp_md5_hash_key(struct tcp_md5sig_pool *hp,
 =09=09     const struct tcp_md5sig_key *key);
=20
 /* From tcp_fastopen.c */
+struct sock *tcp_fastopen_create_child(struct sock *sk,
+=09=09=09=09       struct sk_buff *skb,
+=09=09=09=09       struct request_sock *req);
+bool tcp_fastopen_queue_check(struct sock *sk);
+int tcp_fastopen_get_cipher(struct net *net, struct inet_connection_sock *=
icsk,
+=09=09=09    u64 *key);
+void tcp_fastopen_cookie_gen(struct sock *sk,
+=09=09=09     struct request_sock *req,
+=09=09=09     struct sk_buff *syn,
+=09=09=09     struct tcp_fastopen_cookie *foc);
+int tcp_fastopen_cookie_gen_check(struct sock *sk,
+=09=09=09=09  struct request_sock *req,
+=09=09=09=09  struct sk_buff *syn,
+=09=09=09=09  struct tcp_fastopen_cookie *orig,
+=09=09=09=09  struct tcp_fastopen_cookie *valid_foc);
+bool tcp_fastopen_no_cookie(const struct sock *sk,
+=09=09=09    const struct dst_entry *dst,
+=09=09=09    int flag);
+void tcp_reqsk_record_syn(const struct sock *sk,
+=09=09=09  struct request_sock *req,
+=09=09=09  const struct sk_buff *skb);
+void tcp_ecn_create_request(struct request_sock *req,
+=09=09=09    const struct sk_buff *skb,
+=09=09=09    const struct sock *listen_sk,
+=09=09=09    const struct dst_entry *dst);
+void tcp_openreq_init(struct request_sock *req,
+=09=09      const struct tcp_options_received *rx_opt,
+=09=09      struct sk_buff *skb, const struct sock *sk);
 void tcp_fastopen_cache_get(struct sock *sk, u16 *mss,
 =09=09=09    struct tcp_fastopen_cookie *cookie);
 void tcp_fastopen_cache_set(struct sock *sk, u16 mss,
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 45cc7f1ca296..0963d7cbc8df 100644
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
@@ -149,10 +150,10 @@ static bool __tcp_fastopen_cookie_gen_cipher(struct r=
equest_sock *req,
 /* Generate the fastopen cookie by applying SipHash to both the source and
  * destination addresses.
  */
-static void tcp_fastopen_cookie_gen(struct sock *sk,
-=09=09=09=09    struct request_sock *req,
-=09=09=09=09    struct sk_buff *syn,
-=09=09=09=09    struct tcp_fastopen_cookie *foc)
+void tcp_fastopen_cookie_gen(struct sock *sk,
+=09=09=09     struct request_sock *req,
+=09=09=09     struct sk_buff *syn,
+=09=09=09     struct tcp_fastopen_cookie *foc)
 {
 =09struct tcp_fastopen_context *ctx;
=20
@@ -207,11 +208,11 @@ void tcp_fastopen_add_skb(struct sock *sk, struct sk_=
buff *skb)
 }
=20
 /* returns 0 - no key match, 1 for primary, 2 for backup */
-static int tcp_fastopen_cookie_gen_check(struct sock *sk,
-=09=09=09=09=09 struct request_sock *req,
-=09=09=09=09=09 struct sk_buff *syn,
-=09=09=09=09=09 struct tcp_fastopen_cookie *orig,
-=09=09=09=09=09 struct tcp_fastopen_cookie *valid_foc)
+int tcp_fastopen_cookie_gen_check(struct sock *sk,
+=09=09=09=09  struct request_sock *req,
+=09=09=09=09  struct sk_buff *syn,
+=09=09=09=09  struct tcp_fastopen_cookie *orig,
+=09=09=09=09  struct tcp_fastopen_cookie *valid_foc)
 {
 =09struct tcp_fastopen_cookie search_foc =3D { .len =3D -1 };
 =09struct tcp_fastopen_cookie *foc =3D valid_foc;
@@ -235,9 +236,9 @@ static int tcp_fastopen_cookie_gen_check(struct sock *s=
k,
 =09return ret;
 }
=20
-static struct sock *tcp_fastopen_create_child(struct sock *sk,
-=09=09=09=09=09      struct sk_buff *skb,
-=09=09=09=09=09      struct request_sock *req)
+struct sock *tcp_fastopen_create_child(struct sock *sk,
+=09=09=09=09       struct sk_buff *skb,
+=09=09=09=09       struct request_sock *req)
 {
 =09struct tcp_sock *tp;
 =09struct request_sock_queue *queue =3D &inet_csk(sk)->icsk_accept_queue;
@@ -283,7 +284,10 @@ static struct sock *tcp_fastopen_create_child(struct s=
ock *sk,
=20
 =09tp->rcv_nxt =3D TCP_SKB_CB(skb)->seq + 1;
=20
-=09tcp_fastopen_add_skb(child, skb);
+=09if (sk_is_mptcp(sk))
+=09=09mptcp_fastopen_add_skb(child, skb, req);
+=09else
+=09=09tcp_fastopen_add_skb(child, skb);
=20
 =09tcp_rsk(req)->rcv_nxt =3D tp->rcv_nxt;
 =09tp->rcv_wup =3D tp->rcv_nxt;
@@ -293,7 +297,7 @@ static struct sock *tcp_fastopen_create_child(struct so=
ck *sk,
 =09return child;
 }
=20
-static bool tcp_fastopen_queue_check(struct sock *sk)
+bool tcp_fastopen_queue_check(struct sock *sk)
 {
 =09struct fastopen_queue *fastopenq;
=20
@@ -329,9 +333,9 @@ static bool tcp_fastopen_queue_check(struct sock *sk)
 =09return true;
 }
=20
-static bool tcp_fastopen_no_cookie(const struct sock *sk,
-=09=09=09=09   const struct dst_entry *dst,
-=09=09=09=09   int flag)
+bool tcp_fastopen_no_cookie(const struct sock *sk,
+=09=09=09    const struct dst_entry *dst,
+=09=09=09    int flag)
 {
 =09return (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_fastopen) & flag) ||
 =09       tcp_sk(sk)->fastopen_no_cookie ||
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index bc2ea12221f9..c82b3d0a801a 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6730,10 +6730,10 @@ static inline void pr_drop_req(struct request_sock =
*req, __u16 port, int family)
  * RFC8311 =C2=A74.3 which updates RFC3168 to allow the development of suc=
h
  * extensions.
  */
-static void tcp_ecn_create_request(struct request_sock *req,
-=09=09=09=09   const struct sk_buff *skb,
-=09=09=09=09   const struct sock *listen_sk,
-=09=09=09=09   const struct dst_entry *dst)
+void tcp_ecn_create_request(struct request_sock *req,
+=09=09=09    const struct sk_buff *skb,
+=09=09=09    const struct sock *listen_sk,
+=09=09=09    const struct dst_entry *dst)
 {
 =09const struct tcphdr *th =3D tcp_hdr(skb);
 =09const struct net *net =3D sock_net(listen_sk);
@@ -6754,9 +6754,9 @@ static void tcp_ecn_create_request(struct request_soc=
k *req,
 =09=09inet_rsk(req)->ecn_ok =3D 1;
 }
=20
-static void tcp_openreq_init(struct request_sock *req,
-=09=09=09     const struct tcp_options_received *rx_opt,
-=09=09=09     struct sk_buff *skb, const struct sock *sk)
+void tcp_openreq_init(struct request_sock *req,
+=09=09      const struct tcp_options_received *rx_opt,
+=09=09      struct sk_buff *skb, const struct sock *sk)
 {
 =09struct inet_request_sock *ireq =3D inet_rsk(req);
=20
@@ -6837,9 +6837,9 @@ static bool tcp_syn_flood_action(const struct sock *s=
k, const char *proto)
 =09return want_cookie;
 }
=20
-static void tcp_reqsk_record_syn(const struct sock *sk,
-=09=09=09=09 struct request_sock *req,
-=09=09=09=09 const struct sk_buff *skb)
+void tcp_reqsk_record_syn(const struct sock *sk,
+=09=09=09  struct request_sock *req,
+=09=09=09  const struct sk_buff *skb)
 {
 =09if (tcp_sk(sk)->save_syn) {
 =09=09u32 len =3D skb_network_header_len(skb) + tcp_hdrlen(skb);
diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index 1b9caf56e02f..b7c1c4523c10 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -166,3 +166,166 @@ void mptcp_fastopen_add_skb(struct sock *sk, struct s=
k_buff *skb, struct request
 =09if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN)
 =09=09tcp_fin(sk);
 }
+
+struct sock *mptcp_try_fastopen(struct sock *sk, struct sk_buff *skb,
+=09=09=09=09struct request_sock *req,
+=09=09=09=09struct tcp_fastopen_cookie *foc,
+=09=09=09=09const struct dst_entry *dst)
+{
+=09bool syn_data_status =3D TCP_SKB_CB(skb)->end_seq !=3D TCP_SKB_CB(skb)-=
>seq + 1;
+=09struct tcp_fastopen_cookie valid_mptcp_foc =3D { .len =3D -1 };
+=09struct sock *child_sock;
+=09int ret =3D 0;
+
+=09if ((syn_data_status || foc->len >=3D 0) &&
+=09    tcp_fastopen_queue_check(sk)) {
+=09=09foc->len =3D -1;
+=09=09return NULL;
+=09}
+
+=09if (tcp_fastopen_no_cookie(sk, dst, TFO_SERVER_COOKIE_NOT_REQD))
+=09=09goto fastopen;
+
+=09if (foc->len =3D=3D 0) {
+=09=09tcp_fastopen_cookie_gen(sk, req, skb, &valid_mptcp_foc);
+=09} else if (foc->len > 0) {
+=09=09ret =3D tcp_fastopen_cookie_gen_check(sk, req, skb, foc,
+=09=09=09=09=09=09    &valid_mptcp_foc);
+=09=09if (ret) {
+fastopen:
+=09=09=09child_sock =3D tcp_fastopen_create_child(sk, skb, req);
+=09=09=09if (child_sock) {
+=09=09=09=09if (ret =3D=3D 2) {
+=09=09=09=09=09valid_mptcp_foc.exp =3D foc->exp;
+=09=09=09=09=09*foc =3D valid_mptcp_foc;
+=09=09=09=09} else {
+=09=09=09=09=09foc->len =3D -1;
+=09=09=09=09}
+=09=09=09=09return child_sock;
+=09=09=09}
+=09=09}
+=09}
+=09valid_mptcp_foc.exp =3D foc->exp;
+=09*foc =3D valid_mptcp_foc;
+=09return NULL;
+}
+
+int mptcp_conn_request(struct request_sock_ops *rsk_ops,
+=09=09       const struct tcp_request_sock_ops *af_ops,
+=09=09       struct sock *sk, struct sk_buff *skb)
+{
+=09struct tcp_fastopen_cookie mptcp_foc =3D { .len =3D -1 };
+=09struct tcp_options_received tmp_opt_rcvd;
+=09__u32 isn =3D TCP_SKB_CB(skb)->tcp_tw_isn;
+=09struct tcp_sock *tp_sock =3D tcp_sk(sk);
+=09struct sock *mptcp_fo_sk =3D NULL;
+=09struct net *net =3D sock_net(sk);
+=09struct request_sock *req_sock;
+=09bool want_cookie =3D false;
+=09struct dst_entry *dst;
+=09struct flowi fl;
+
+=09if (sk_acceptq_is_full(sk))
+=09=09goto drop;
+
+=09req_sock =3D inet_reqsk_alloc(rsk_ops, sk, !want_cookie);
+=09if (!req_sock)
+=09=09goto drop;
+
+=09req_sock->syncookie =3D want_cookie;
+=09tcp_rsk(req_sock)->af_specific =3D af_ops;
+=09tcp_rsk(req_sock)->ts_off =3D 1;
+=09tcp_rsk(req_sock)->is_mptcp =3D 1;
+
+=09tcp_clear_options(&tmp_opt_rcvd);
+=09tmp_opt_rcvd.mss_clamp =3D af_ops->mss_clamp;
+=09tmp_opt_rcvd.user_mss  =3D tp_sock->rx_opt.user_mss;
+=09tcp_parse_options(sock_net(sk), skb, &tmp_opt_rcvd, 0,
+=09=09=09  want_cookie ? NULL : &mptcp_foc);
+
+=09if (want_cookie && !tmp_opt_rcvd.saw_tstamp)
+=09=09tcp_clear_options(&tmp_opt_rcvd);
+
+=09if (IS_ENABLED(CONFIG_SMC) && want_cookie)
+=09=09tmp_opt_rcvd.smc_ok =3D 0;
+
+=09tmp_opt_rcvd.tstamp_ok =3D 0;
+=09tcp_openreq_init(req_sock, &tmp_opt_rcvd, skb, sk);
+=09inet_rsk(req_sock)->no_srccheck =3D inet_sk(sk)->transparent;
+
+=09inet_rsk(req_sock)->ir_iif =3D inet_request_bound_dev_if(sk, skb);
+
+=09dst =3D af_ops->route_req(sk, skb, &fl, req_sock);
+=09if (!dst)
+=09=09goto drop_and_free;
+
+=09if (tmp_opt_rcvd.tstamp_ok)
+=09=09tcp_rsk(req_sock)->ts_off =3D af_ops->init_ts_off(net, skb);
+
+=09if (!want_cookie && !isn) {
+=09=09if (!net->ipv4.sysctl_tcp_syncookies &&
+=09=09    (net->ipv4.sysctl_max_syn_backlog - inet_csk_reqsk_queue_len(sk)=
 <
+=09=09     (net->ipv4.sysctl_max_syn_backlog >> 2)) &&
+=09=09    !tcp_peer_is_proven(req_sock, dst)) {
+=09=09=09goto drop_and_release;
+=09=09}
+
+=09=09isn =3D af_ops->init_seq(skb);
+=09}
+
+=09tcp_ecn_create_request(req_sock, skb, sk, dst);
+
+=09if (want_cookie) {
+=09=09isn =3D cookie_init_sequence(af_ops, sk, skb, &req_sock->mss);
+=09=09if (!tmp_opt_rcvd.tstamp_ok)
+=09=09=09inet_rsk(req_sock)->ecn_ok =3D 0;
+=09}
+
+=09tcp_rsk(req_sock)->snt_isn =3D isn;
+=09tcp_rsk(req_sock)->txhash =3D net_tx_rndhash();
+=09tcp_rsk(req_sock)->syn_tos =3D TCP_SKB_CB(skb)->ip_dsfield;
+
+=09tcp_openreq_init_rwin(req_sock, sk, dst);
+=09sk_rx_queue_set(req_to_sk(req_sock), skb);
+=09if (!want_cookie) {
+=09=09tcp_reqsk_record_syn(sk, req_sock, skb);
+=09=09mptcp_fo_sk =3D mptcp_try_fastopen(sk, skb, req_sock, &mptcp_foc, ds=
t);
+=09}
+=09if (mptcp_fo_sk) {
+=09=09af_ops->send_synack(mptcp_fo_sk, dst, &fl, req_sock,
+=09=09=09=09    &mptcp_foc, TCP_SYNACK_FASTOPEN, skb);
+=09=09if (!inet_csk_reqsk_queue_add(sk, req_sock, mptcp_fo_sk)) {
+=09=09=09reqsk_fastopen_remove(mptcp_fo_sk, req_sock, false);
+=09=09=09bh_unlock_sock(mptcp_fo_sk);
+=09=09=09sock_put(mptcp_fo_sk);
+=09=09=09goto drop_and_free;
+=09=09}
+=09=09sk->sk_data_ready(sk);
+=09=09bh_unlock_sock(mptcp_fo_sk);
+=09=09sock_put(mptcp_fo_sk);
+=09} else {
+=09=09tcp_rsk(req_sock)->tfo_listener =3D false;
+=09=09if (!want_cookie) {
+=09=09=09req_sock->timeout =3D tcp_timeout_init((struct sock *)req_sock);
+=09=09=09inet_csk_reqsk_queue_hash_add(sk, req_sock, req_sock->timeout);
+=09=09}
+=09=09af_ops->send_synack(sk, dst, &fl, req_sock, &mptcp_foc,
+=09=09=09=09    !want_cookie ? TCP_SYNACK_NORMAL :
+=09=09=09=09=09=09   TCP_SYNACK_COOKIE,
+=09=09=09=09    skb);
+=09=09if (want_cookie) {
+=09=09=09reqsk_free(req_sock);
+=09=09=09return 0;
+=09=09}
+=09}
+=09reqsk_put(req_sock);
+=09return 0;
+
+drop_and_release:
+=09dst_release(dst);
+drop_and_free:
+=09__reqsk_free(req_sock);
+drop:
+=09tcp_listendrop(sk);
+=09return 0;
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b90279c734ae..8d894a2d06b3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -849,6 +849,45 @@ int mptcp_setsockopt_sol_tcp_fastopen(struct mptcp_soc=
k *msk, sockptr_t optval,
 =09=09=09=09      unsigned int optlen);
 void mptcp_treat_hshake_ack_fastopen(struct mptcp_sock *msk, struct mptcp_=
subflow_context *subflow,
 =09=09=09=09     struct mptcp_options_received mp_opt);
+void mptcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb,
+=09=09=09    struct request_sock *req);
+void mptcp_reqsk_record_syn(const struct sock *sk,
+=09=09=09    struct request_sock *req,
+=09=09=09    const struct sk_buff *skb);
+void mptcp_ecn_create_request(struct request_sock *req,
+=09=09=09      const struct sk_buff *skb,
+=09=09=09      const struct sock *listen_sk,
+=09=09=09      const struct dst_entry *dst);
+void mptcp_openreq_init(struct request_sock *req,
+=09=09=09const struct tcp_options_received *rx_opt,
+=09=09=09struct sk_buff *skb, const struct sock *sk);
+struct sock *mptcp_fastopen_create_child(struct sock *sk,
+=09=09=09=09=09 struct sk_buff *skb,
+=09=09=09=09=09 struct request_sock *req);
+bool mptcp_fastopen_queue_check(struct sock *sk);
+bool mptcp_fastopen_cookie_gen_cipher(struct request_sock *req,
+=09=09=09=09      struct sk_buff *syn,
+=09=09=09=09      const siphash_key_t *key,
+=09=09=09=09      struct tcp_fastopen_cookie *foc);
+void mptcp_fastopen_cookie_gen(struct sock *sk,
+=09=09=09       struct request_sock *req,
+=09=09=09       struct sk_buff *syn,
+=09=09=09       struct tcp_fastopen_cookie *foc);
+int mptcp_fastopen_cookie_gen_check(struct sock *sk,
+=09=09=09=09    struct request_sock *req,
+=09=09=09=09    struct sk_buff *syn,
+=09=09=09=09    struct tcp_fastopen_cookie *orig,
+=09=09=09=09    struct tcp_fastopen_cookie *valid_foc);
+bool mptcp_fastopen_no_cookie(const struct sock *sk,
+=09=09=09      const struct dst_entry *dst,
+=09=09=09      int flag);
+struct sock *mptcp_try_fastopen(struct sock *sk, struct sk_buff *skb,
+=09=09=09=09struct request_sock *req,
+=09=09=09=09struct tcp_fastopen_cookie *foc,
+=09=09=09=09const struct dst_entry *dst);
+int mptcp_conn_request(struct request_sock_ops *rsk_ops,
+=09=09       const struct tcp_request_sock_ops *af_ops,
+=09=09       struct sock *sk, struct sk_buff *skb);
 // Fast Open Mechanism functions end
=20
 static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 075c61d1d37f..ff5fe4ff3d21 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -542,7 +542,7 @@ static int subflow_v4_conn_request(struct sock *sk, str=
uct sk_buff *skb)
 =09if (skb_rtable(skb)->rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST))
 =09=09goto drop;
=20
-=09return tcp_conn_request(&mptcp_subflow_request_sock_ops,
+=09return mptcp_conn_request(&mptcp_subflow_request_sock_ops,
 =09=09=09=09&subflow_request_sock_ipv4_ops,
 =09=09=09=09sk, skb);
 drop:
--=20
2.25.1


