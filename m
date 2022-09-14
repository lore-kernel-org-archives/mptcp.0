Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D093D7B
	for <mptcp@lists.linux.dev>; Wed, 14 Sep 2022 11:32:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663155123; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Zh1HAgaUZ7/v3IBfH6QpO3JHj01kL6DnclEUVfhpQUVclpFNyzVlj3w4hCYF8lCWGDXeTTjSkGfEe916GJAitg1a4E1IRjRnorjsPj4zzdpFds8spD3WQTmv57p0837YsEcO7y+7tRyom8Hd4xR5KzTd1DYfhi67E4I+s+Huw+M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663155123; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=W/hf8v5NfL8KDilHeNdSo5X+p9r+zPdNsko9pu4qVVU=; 
	b=e8rCFAvYvAQSCMrOVCbTdauYSjLy2Te/RhdbREEyQgmx5dr0WFsJIynYpUiXbISe7dXhwvT0D8FCQwRH+enxtOfCybUUKq2AclZsi4qupeDodVHS2dEnK/Sxwees5+h7zdgZ+Bp4Vok2ciawnY9qnlJqp6apdX+TWeLnjBhkOjA=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663155123;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=W/hf8v5NfL8KDilHeNdSo5X+p9r+zPdNsko9pu4qVVU=;
	b=SkJ9gUs0HfGhRGiRSJH/Hz22K0cLqbbFKOWPpwktZXBtvN8sKvusfNAoHac+0RXq
	CXVIZgGENVU/1wFMfxud4IHKsiPbMaznScodE7DcXKojFmjJzCZTYUq5JG7RAkZCU+i
	03N9gpI1p+vI63Cyqn2t6tRDx4ptLLqaMHTxkvOs=
Received: from doris.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 166315512210638.324434956880395; Wed, 14 Sep 2022 13:32:02 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220914113151.9898-7-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v5 07/10] Add the received skb on the listener side to msk and set flag mptfo to 1 to treat some parts only in MPTFO case. This function is called from the functions presented in the next patch
Date: Wed, 14 Sep 2022 13:31:48 +0200
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220914113151.9898-1-dmytro@shytyi.net>
References: <20220914113151.9898-1-dmytro@shytyi.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8

Add the received skb on the listener
side to msk and set flag mptfo to 1 to treat some parts only in MPTFO case.
This function is called from the functions presented in the next patch

Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
---
 net/mptcp/fastopen.c | 444 +++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h |  41 ++++
 net/mptcp/subflow.c  |   2 +-
 3 files changed, 486 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index ea46a4b405db..fd0e4b7c8f68 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -101,3 +101,447 @@ void mptcp_treat_3d_ack_fastopen(struct mptcp_sock *m=
sk, struct mptcp_subflow_co
 =09=09atomic64_set(&msk->rcv_wnd_sent, ack_seq);
 =09}
 }
+
+void mptcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb, struct r=
equest_sock *req)
+{
+=09struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+=09struct tcp_request_sock *tcp_r_sock =3D tcp_rsk(req);
+=09struct sock *socket =3D mptcp_subflow_ctx(sk)->conn;
+=09struct mptcp_sock *msk =3D mptcp_sk(socket);
+=09struct tcp_sock *tp =3D tcp_sk(sk);
+
+=09if (TCP_SKB_CB(skb)->end_seq =3D=3D tp->rcv_nxt)
+=09=09return;
+
+=09skb =3D skb_clone(skb, GFP_ATOMIC);
+=09if (!skb)
+=09=09return;
+
+=09skb_dst_drop(skb);
+
+=09tp->segs_in =3D 0;
+=09tcp_segs_in(tp, skb);
+=09__skb_pull(skb, tcp_hdrlen(skb));
+=09sk_forced_mem_schedule(sk, skb->truesize);
+
+=09TCP_SKB_CB(skb)->seq++;
+=09TCP_SKB_CB(skb)->tcp_flags &=3D ~TCPHDR_SYN;
+
+=09tp->rcv_nxt =3D TCP_SKB_CB(skb)->end_seq;
+
+=09msk->is_mptfo =3D 1;
+
+=09//Solves: WARNING: at 704 _mptcp_move_skbs_from_subflow+0x5d0/0x651
+=09tp->copied_seq +=3D tp->rcv_nxt - tcp_r_sock->rcv_isn - 1;
+
+=09TCP_SKB_CB(skb)->seq +=3D tp->rcv_nxt - tcp_r_sock->rcv_isn - 1;
+=09TCP_SKB_CB(skb)->end_seq =3D TCP_SKB_CB(skb)->seq;
+
+=09TCP_SKB_CB(skb)->seq +=3D tp->rcv_nxt - tcp_r_sock->rcv_isn - 1;
+=09TCP_SKB_CB(skb)->end_seq =3D  TCP_SKB_CB(skb)->seq;
+
+=09subflow->map_seq =3D mptcp_subflow_get_mapped_dsn(subflow);
+
+=09//Solves: BAD mapping: ssn=3D0 map_seq=3D1 map_data_len=3D3
+=09subflow->ssn_offset =3D tp->copied_seq - 1;
+
+=09skb_ext_reset(skb);
+
+=09//mptcp_set_owner_r begin
+=09skb_orphan(skb);
+=09skb->sk =3D socket;
+=09skb->destructor =3D mptcp_rfree;
+=09atomic_add(skb->truesize, &socket->sk_rmem_alloc);
+=09msk->rmem_fwd_alloc -=3D skb->truesize;
+=09//mptcp_set owner_r end
+
+=09__skb_queue_tail(&msk->receive_queue, skb);
+
+=09atomic64_set(&msk->rcv_wnd_sent, mptcp_subflow_get_mapped_dsn(subflow))=
;
+
+=09tp->syn_data_acked =3D 1;
+
+=09tp->bytes_received =3D skb->len;
+
+=09if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN)
+=09=09tcp_fin(sk);
+}
+
+struct sock *mptcp_fastopen_create_child(struct sock *sk,
+=09=09=09=09=09 struct sk_buff *skb,
+=09=09=09=09=09 struct request_sock *req)
+{
+=09struct request_sock_queue *r_sock_queue =3D &inet_csk(sk)->icsk_accept_=
queue;
+=09struct tcp_sock *tp;
+=09struct sock *child_sock;
+=09bool own_req;
+
+=09child_sock =3D inet_csk(sk)->icsk_af_ops->syn_recv_sock(sk, skb, req, N=
ULL,
+=09=09=09=09=09=09=09      NULL, &own_req);
+=09if (!child_sock)
+=09=09return NULL;
+
+=09spin_lock(&r_sock_queue->fastopenq.lock);
+=09r_sock_queue->fastopenq.qlen++;
+=09spin_unlock(&r_sock_queue->fastopenq.lock);
+
+=09tp =3D tcp_sk(child_sock);
+
+=09rcu_assign_pointer(tp->fastopen_rsk, req);
+=09tcp_rsk(req)->tfo_listener =3D true;
+
+=09tp->snd_wnd =3D ntohs(tcp_hdr(skb)->window);
+=09tp->max_window =3D tp->snd_wnd;
+
+=09inet_csk_reset_xmit_timer(child_sock, ICSK_TIME_RETRANS,
+=09=09=09=09  TCP_TIMEOUT_INIT, TCP_RTO_MAX);
+
+=09refcount_set(&req->rsk_refcnt, 2);
+
+=09tcp_init_transfer(child_sock, BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB, skb)=
;
+
+=09tp->rcv_nxt =3D TCP_SKB_CB(skb)->seq + 1;
+
+=09mptcp_fastopen_add_skb(child_sock, skb, req);
+
+=09tcp_rsk(req)->rcv_nxt =3D tp->rcv_nxt;
+=09tp->rcv_wup =3D tp->rcv_nxt;
+
+=09return child_sock;
+}
+
+bool mptcp_fastopen_queue_check(struct sock *sk)
+{
+=09struct fastopen_queue *fo_queue;
+=09struct request_sock *req_sock;
+
+=09fo_queue =3D &inet_csk(sk)->icsk_accept_queue.fastopenq;
+=09if (fo_queue->max_qlen =3D=3D 0)
+=09=09return false;
+
+=09if (fo_queue->qlen >=3D fo_queue->max_qlen) {
+=09=09spin_lock(&fo_queue->lock);
+=09=09req_sock =3D fo_queue->rskq_rst_head;
+=09=09if (!req_sock || time_after(req_sock->rsk_timer.expires, jiffies)) {
+=09=09=09spin_unlock(&fo_queue->lock);
+=09=09=09return false;
+=09=09}
+=09=09fo_queue->rskq_rst_head =3D req_sock->dl_next;
+=09=09fo_queue->qlen--;
+=09=09spin_unlock(&fo_queue->lock);
+=09=09reqsk_put(req_sock);
+=09}
+=09return true;
+}
+
+bool mptcp_fastopen_cookie_gen_cipher(struct request_sock *req,
+=09=09=09=09      struct sk_buff *syn,
+=09=09=09=09      const siphash_key_t *key,
+=09=09=09=09      struct tcp_fastopen_cookie *foc)
+{
+=09if (req->rsk_ops->family =3D=3D AF_INET) {
+=09=09const struct iphdr *iph =3D ip_hdr(syn);
+
+=09=09foc->val[0] =3D cpu_to_le64(siphash(&iph->saddr,
+=09=09=09=09=09  sizeof(iph->saddr) +
+=09=09=09=09=09  sizeof(iph->daddr),
+=09=09=09=09=09  key));
+=09=09foc->len =3D TCP_FASTOPEN_COOKIE_SIZE;
+=09=09return true;
+=09}
+
+=09return false;
+}
+
+void mptcp_fastopen_cookie_gen(struct sock *sk,
+=09=09=09       struct request_sock *req,
+=09=09=09       struct sk_buff *syn,
+=09=09=09       struct tcp_fastopen_cookie *foc)
+{
+=09struct tcp_fastopen_context *ctx;
+
+=09rcu_read_lock();
+=09ctx =3D tcp_fastopen_get_ctx(sk);
+=09if (ctx)
+=09=09mptcp_fastopen_cookie_gen_cipher(req, syn, &ctx->key[0], foc);
+=09rcu_read_unlock();
+}
+
+int mptcp_fastopen_cookie_gen_check(struct sock *sk,
+=09=09=09=09    struct request_sock *req,
+=09=09=09=09    struct sk_buff *syn,
+=09=09=09=09    struct tcp_fastopen_cookie *orig,
+=09=09=09=09    struct tcp_fastopen_cookie *valid_foc)
+{
+=09struct tcp_fastopen_cookie mptcp_search_foc =3D { .len =3D -1 };
+=09struct tcp_fastopen_cookie *mptcp_foc =3D valid_foc;
+=09struct tcp_fastopen_context *mptcp_fo_ctx;
+=09int i, ret =3D 0;
+
+=09rcu_read_lock();
+=09mptcp_fo_ctx =3D tcp_fastopen_get_ctx(sk);
+=09if (!mptcp_fo_ctx)
+=09=09goto out;
+=09for (i =3D 0; i < tcp_fastopen_context_len(mptcp_fo_ctx); i++) {
+=09=09mptcp_fastopen_cookie_gen_cipher(req, syn, &mptcp_fo_ctx->key[i], mp=
tcp_foc);
+=09=09if (tcp_fastopen_cookie_match(mptcp_foc, orig)) {
+=09=09=09ret =3D i + 1;
+=09=09=09goto out;
+=09=09}
+=09=09mptcp_foc =3D &mptcp_search_foc;
+=09}
+out:
+=09rcu_read_unlock();
+=09return ret;
+}
+
+bool mptcp_fastopen_no_cookie(const struct sock *sk,
+=09=09=09      const struct dst_entry *dst,
+=09=09=09      int flag)
+{
+=09return (sock_net(sk)->ipv4.sysctl_tcp_fastopen & flag) ||
+=09       tcp_sk(sk)->fastopen_no_cookie ||
+=09       (dst && dst_metric(dst, RTAX_FASTOPEN_NO_COOKIE));
+}
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
+=09    mptcp_fastopen_queue_check(sk)) {
+=09=09foc->len =3D -1;
+=09=09return NULL;
+=09}
+
+=09if (mptcp_fastopen_no_cookie(sk, dst, TFO_SERVER_COOKIE_NOT_REQD))
+=09=09goto fastopen;
+
+=09if (foc->len =3D=3D 0) {
+=09=09mptcp_fastopen_cookie_gen(sk, req, skb, &valid_mptcp_foc);
+=09} else if (foc->len > 0) {
+=09=09ret =3D mptcp_fastopen_cookie_gen_check(sk, req, skb, foc,
+=09=09=09=09=09=09      &valid_mptcp_foc);
+=09=09if (ret) {
+fastopen:
+=09=09=09child_sock =3D mptcp_fastopen_create_child(sk, skb, req);
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
+=09tcp_rsk(req_sock)->ts_off =3D 0;
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
+=09tmp_opt_rcvd.tstamp_ok =3D tmp_opt_rcvd.saw_tstamp;
+=09mptcp_openreq_init(req_sock, &tmp_opt_rcvd, skb, sk);
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
+=09mptcp_ecn_create_request(req_sock, skb, sk, dst);
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
+=09=09mptcp_reqsk_record_syn(sk, req_sock, skb);
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
+
+void mptcp_reqsk_record_syn(const struct sock *sk,
+=09=09=09    struct request_sock *req,
+=09=09=09    const struct sk_buff *skb)
+{
+=09if (tcp_sk(sk)->save_syn) {
+=09=09u32 length =3D skb_network_header_len(skb) + tcp_hdrlen(skb);
+=09=09struct saved_syn *svd_syn;
+=09=09u32 mac_headerlen;
+=09=09void *base;
+
+=09=09if (tcp_sk(sk)->save_syn =3D=3D 2) {
+=09=09=09base =3D skb_mac_header(skb);
+=09=09=09mac_headerlen =3D skb_mac_header_len(skb);
+=09=09=09length +=3D mac_headerlen;
+=09=09} else {
+=09=09=09base =3D skb_network_header(skb);
+=09=09=09mac_headerlen =3D 0;
+=09=09}
+
+=09=09svd_syn =3D kmalloc(struct_size(svd_syn, data, length),
+=09=09=09=09  GFP_ATOMIC);
+=09=09if (svd_syn) {
+=09=09=09svd_syn->mac_hdrlen =3D mac_headerlen;
+=09=09=09svd_syn->network_hdrlen =3D skb_network_header_len(skb);
+=09=09=09svd_syn->tcp_hdrlen =3D tcp_hdrlen(skb);
+=09=09=09memcpy(svd_syn->data, base, length);
+=09=09=09req->saved_syn =3D svd_syn;
+=09=09}
+=09}
+}
+
+void mptcp_ecn_create_request(struct request_sock *req,
+=09=09=09      const struct sk_buff *skb,
+=09=09=09      const struct sock *listen_sk,
+=09=09=09      const struct dst_entry *dst)
+{
+=09const struct tcphdr *thdr =3D tcp_hdr(skb);
+=09const struct net *net =3D sock_net(listen_sk);
+=09bool thdr_ecn =3D thdr->ece && thdr->cwr;
+=09bool ect_stat, ecn_okay;
+=09u32 ecn_okay_dst;
+
+=09if (!thdr_ecn)
+=09=09return;
+
+=09ect_stat =3D !INET_ECN_is_not_ect(TCP_SKB_CB(skb)->ip_dsfield);
+=09ecn_okay_dst =3D dst_feature(dst, DST_FEATURE_ECN_MASK);
+=09ecn_okay =3D net->ipv4.sysctl_tcp_ecn || ecn_okay_dst;
+
+=09if (((!ect_stat || thdr->res1) && ecn_okay) || tcp_ca_needs_ecn(listen_=
sk) ||
+=09    (ecn_okay_dst & DST_FEATURE_ECN_CA) ||
+=09    tcp_bpf_ca_needs_ecn((struct sock *)req))
+=09=09inet_rsk(req)->ecn_ok =3D 1;
+}
+
+void mptcp_openreq_init(struct request_sock *req,
+=09=09=09const struct tcp_options_received *rx_opt,
+=09=09=09struct sk_buff *skb, const struct sock *sk)
+{
+=09struct inet_request_sock *ireq =3D inet_rsk(req);
+
+=09req->rsk_rcv_wnd =3D 0;
+=09tcp_rsk(req)->rcv_isn =3D TCP_SKB_CB(skb)->seq;
+=09tcp_rsk(req)->rcv_nxt =3D TCP_SKB_CB(skb)->seq + 1;
+=09tcp_rsk(req)->snt_synack =3D 0;
+=09tcp_rsk(req)->last_oow_ack_time =3D 0;
+=09req->mss =3D rx_opt->mss_clamp;
+=09req->ts_recent =3D rx_opt->saw_tstamp ? rx_opt->rcv_tsval : 0;
+=09ireq->tstamp_ok =3D rx_opt->tstamp_ok;
+=09ireq->sack_ok =3D rx_opt->sack_ok;
+=09ireq->snd_wscale =3D rx_opt->snd_wscale;
+=09ireq->wscale_ok =3D rx_opt->wscale_ok;
+=09ireq->acked =3D 0;
+=09ireq->ecn_ok =3D 0;
+=09ireq->ir_rmt_port =3D tcp_hdr(skb)->source;
+=09ireq->ir_num =3D ntohs(tcp_hdr(skb)->dest);
+=09ireq->ir_mark =3D inet_request_mark(sk, skb);
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a23f4529827e..aea413f8d9cc 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -847,6 +847,47 @@ int mptcp_setsockopt_sol_tcp_fastopen(struct mptcp_soc=
k *msk, sockptr_t optval,
 =09=09=09=09      unsigned int optlen);
 void mptcp_treat_3d_ack_fastopen(struct mptcp_sock *msk, struct mptcp_subf=
low_context *subflow,
 =09=09=09=09 struct mptcp_options_received mp_opt);
+void mptcp_treat_3d_ack_fastopen(struct mptcp_sock *msk, struct mptcp_subf=
low_context *subflow,
+=09=09=09=09 struct mptcp_options_received mp_opt);
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


