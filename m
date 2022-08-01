Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900807F
	for <mptcp@lists.linux.dev>; Mon,  1 Aug 2022 02:47:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1659322060; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=OzZn7UW8ibqSYty6znsDfwKQg1YmPRuj7vonD161ujZ+mFvQpTgVhgbk2YID1TBLmDK8NedRpaip0LlWCwGgd/sBYys0rzhHsCNSZhvkZOGXYV5r8Nnn1YKAkDt434xjgAeIPqTqnhnwhl3uvpfz9l+2s/PPRzX4/qiKJxumTFs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1659322060; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
	bh=luXiZ4NNPZc3nOpHyNh5QP/Sauz1fWVNf8zSeVqm/fw=; 
	b=dfAGaHzNw9RUcvaixj8DMQKSfocWkLcc40ec9TVpA6kecXK72DbIS+7ZkXLqYq+QsFXO0qDCwpXowKbZmM1Mbp+CXNhu4m44Z561W0Dv88j24VGRsu2IDGgZ2ZcE7SIbSSqA51jSGt4ICakRfZeu0R0HGoeGFQhmmuGiWxoesVI=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1659322060;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=luXiZ4NNPZc3nOpHyNh5QP/Sauz1fWVNf8zSeVqm/fw=;
	b=BvnzDrCFKeZOmJaY+dCf8/Qwn/WJxuVptDI2htMudvz0OqTcLhW9oJNzwIl2Z1t9
	C1PajPYzlWFdVXNFiE0RqZJyYcq09cCOAM0AkN2VlKcPJ86PDcKCfkufj87jXA48iGi
	oVCDwMQYcjBHaGL7Ik7nOSM65o9/crcUTJEbu8UA=
Received: from localhost.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1659322058997264.7051098893853; Mon, 1 Aug 2022 04:47:38 +0200 (CEST)
From: Dmytro SHYTYI <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro SHYTYI <dmytro@shytyi.net>
Message-ID: <20220801024656.397714-1-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v4] mptcp: Fast Open Mechanism
Date: Mon,  1 Aug 2022 03:46:56 +0100
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8

This set of patches will bring "Fast Open" Option support to MPTCP.
The aim of Fast Open Mechanism is to eliminate one round trip
time from a TCP conversation by allowing data to be included as
part of the SYN segment that initiates the connection.

IETF RFC 8684: Appendix B. TCP Fast Open and MPTCP.

[PATCH v3] includes "client-server" partial support for :
1. MPTCP cookie request from client (seems to be working).
2. MPTCP cookie offering from server (seems to be working).
3. MPTCP SYN+DATA+COOKIE from client (seems to be working).
4. subsequent write + read on the opened socket (first launch
with TFO request seems to be working, hovewer the second launch
appears to have a mptcp "RST" issue).

This patch is Work In Progress transitional draft.
The differences between v3 and v4:
1. An attempt to reduce impact on existing TCP code.
2. 2 files related to mptcp_fastopen are created(*.h + *.c).
3. "subflow_v4_conn_request" is used to call "mptcp_conn_request"(
located in "mptcp_fastopen.c") to process the received packet on the
listener side when "SYN" is received during 3way handshake.
4. This chain adds "skb" to "&msk->sk_receive_queue"
("subflow_v4_conn_request"->"mptcp_conn_request"->
"mptcp_try_fastopen"->"mptcp_fastopen_create_child"->
"mptcp_fastopen_add_skb")
5. Some minor comments from mailing list are not yet included
in the current version of the PATCH.

Signed-off-by: Dmytro SHYTYI <dmytro@shytyi.net>
---
 include/net/mptcp.h        |   2 +-
 net/ipv4/tcp_output.c      |   3 +-
 net/mptcp/Makefile         |   2 +-
 net/mptcp/mptcp_fastopen.c | 476 +++++++++++++++++++++++++++++++++++++
 net/mptcp/mptcp_fastopen.h |  67 ++++++
 net/mptcp/options.c        |   7 +-
 net/mptcp/protocol.c       |   8 +-
 net/mptcp/protocol.h       |   3 +
 net/mptcp/sockopt.c        |  41 ++++
 net/mptcp/subflow.c        |   7 +-
 10 files changed, 604 insertions(+), 12 deletions(-)
 create mode 100644 net/mptcp/mptcp_fastopen.c
 create mode 100644 net/mptcp/mptcp_fastopen.h

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 6456ea26e4c7..692197187af8 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -139,7 +139,7 @@ void mptcp_space(const struct sock *ssk, int *space, in=
t *full_space);
 bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
 =09=09       unsigned int *size, struct mptcp_out_options *opts);
 bool mptcp_synack_options(const struct request_sock *req, unsigned int *si=
ze,
-=09=09=09  struct mptcp_out_options *opts);
+=09=09=09  struct mptcp_out_options *opts, u16 *tcp_options);
 bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 =09=09=09       unsigned int *size, unsigned int remaining,
 =09=09=09       struct mptcp_out_options *opts);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index b4b2284ed4a2..864517e63bdf 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -747,7 +747,7 @@ static void mptcp_set_option_cond(const struct request_=
sock *req,
 =09if (rsk_is_mptcp(req)) {
 =09=09unsigned int size;
=20
-=09=09if (mptcp_synack_options(req, &size, &opts->mptcp)) {
+=09=09if (mptcp_synack_options(req, &size, &opts->mptcp, &opts->options)) =
{
 =09=09=09if (*remaining >=3D size) {
 =09=09=09=09opts->options |=3D OPTION_MPTCP;
 =09=09=09=09*remaining -=3D size;
@@ -822,7 +822,6 @@ static unsigned int tcp_syn_options(struct sock *sk, st=
ruct sk_buff *skb,
 =09=09=09tp->syn_fastopen_exp =3D fastopen->cookie.exp ? 1 : 0;
 =09=09}
 =09}
-
 =09smc_set_option(tp, opts, &remaining);
=20
 =09if (sk_is_mptcp(sk)) {
diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index 8a7f68efa35f..0f1022b395ef 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -2,7 +2,7 @@
 obj-$(CONFIG_MPTCP) +=3D mptcp.o
=20
 mptcp-y :=3D protocol.o subflow.o options.o token.o crypto.o ctrl.o pm.o d=
iag.o \
-=09   mib.o pm_netlink.o sockopt.o pm_userspace.o sched.o
+=09   mib.o pm_netlink.o sockopt.o pm_userspace.o sched.o mptcp_fastopen.o
=20
 obj-$(CONFIG_SYN_COOKIES) +=3D syncookies.o
 obj-$(CONFIG_INET_MPTCP_DIAG) +=3D mptcp_diag.o
diff --git a/net/mptcp/mptcp_fastopen.c b/net/mptcp/mptcp_fastopen.c
new file mode 100644
index 000000000000..cca086e178a6
--- /dev/null
+++ b/net/mptcp/mptcp_fastopen.c
@@ -0,0 +1,476 @@
+#include "mptcp_fastopen.h"
+
+int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
+=09=09=09   size_t len, struct mptcp_sock *msk,
+=09=09=09   size_t *copied)
+{
+=09const struct iphdr *iph;
+=09struct ubuf_info *uarg;
+=09struct sockaddr *uaddr;
+=09struct sk_buff *skb;
+=09struct tcp_sock *tp;
+=09struct socket *ssk;
+=09int ret;
+
+=09ssk =3D __mptcp_nmpc_socket(msk);
+=09if (unlikely(!ssk))
+=09=09goto out_EFAULT;
+=09skb =3D tcp_stream_alloc_skb(ssk->sk, 0, ssk->sk->sk_allocation, true);
+=09if (unlikely(!skb))
+=09=09goto out_EFAULT;
+=09iph =3D ip_hdr(skb);
+=09if (unlikely(!iph))
+=09=09goto out_EFAULT;
+=09uarg =3D msg_zerocopy_realloc(sk, len, skb_zcopy(skb));
+=09if (unlikely(!uarg))
+=09=09goto out_EFAULT;
+=09uaddr =3D msg->msg_name;
+
+=09tp =3D tcp_sk(ssk->sk);
+=09if (unlikely(!tp))
+=09=09goto out_EFAULT;
+=09if (!tp->fastopen_req)
+=09=09tp->fastopen_req =3D kzalloc(sizeof(*tp->fastopen_req),
+=09=09=09=09=09   ssk->sk->sk_allocation);
+
+=09if (unlikely(!tp->fastopen_req))
+=09=09goto out_EFAULT;
+=09tp->fastopen_req->data =3D msg;
+=09tp->fastopen_req->size =3D len;
+=09tp->fastopen_req->uarg =3D uarg;
+
+=09/* requests a cookie */
+=09*copied =3D mptcp_stream_connect(sk->sk_socket, uaddr,
+=09=09=09=09   msg->msg_namelen, msg->msg_flags);
+
+=09return 0;
+out_EFAULT:
+=09ret =3D -EFAULT;
+=09return ret;
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
+=09=09=09=09    GFP_ATOMIC);
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
+
+void mptcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb)
+{
+=09struct sock *msk =3D mptcp_subflow_ctx(sk)->conn;
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
+=09skb_set_owner_r(skb, sk);
+
+=09TCP_SKB_CB(skb)->seq++;
+=09TCP_SKB_CB(skb)->tcp_flags &=3D ~TCPHDR_SYN;
+
+=09tp->rcv_nxt =3D TCP_SKB_CB(skb)->end_seq;
+
+=09__skb_queue_tail(&msk->sk_receive_queue, skb);
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
+=09=09=09=09=09=09=09 NULL, &own_req);
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
+
+=09tp->rcv_nxt =3D TCP_SKB_CB(skb)->seq + 1;
+=09//tp->rcv_nxt =3D TCP_SKB_CB(skb)->end_seq;
+=09//tp->copied_seq =3D 4;//3
+
+=09mptcp_fastopen_add_skb(child_sock, skb);
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
+
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
+
+=09if ((syn_data_status || foc->len >=3D 0) &&
+=09      mptcp_fastopen_queue_check(sk)) {
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
+=09=09=09=09=09=09    &valid_mptcp_foc);
+=09=09if (!ret) {
+=09=09=09__asm__ ("NOP");
+=09=09} else {
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
+=09if (sk_acceptq_is_full(sk)) {
+=09=09goto drop;
+=09}
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
+
+
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
diff --git a/net/mptcp/mptcp_fastopen.h b/net/mptcp/mptcp_fastopen.h
new file mode 100644
index 000000000000..c050195c60a7
--- /dev/null
+++ b/net/mptcp/mptcp_fastopen.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0
+ * MPTCP Fast Open Mechanism. Copyright (c) 2021-2022, Dmytro SHYTYI.
+ */
+
+#ifndef __MPTCP_FASTOPEN_H
+#define __MPTCP_FASTOPEN_H
+
+#include <uapi/linux/mptcp.h>
+#include <net/mptcp.h>
+#include <net/sock.h>
+#include "protocol.h"
+
+int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
+=09=09=09   size_t len, struct mptcp_sock *msk,
+=09=09=09   size_t *copied);
+
+void mptcp_reqsk_record_syn(const struct sock *sk,
+=09=09=09    struct request_sock *req,
+=09=09=09    const struct sk_buff *skb);
+
+void mptcp_ecn_create_request(struct request_sock *req,
+=09=09=09      const struct sk_buff *skb,
+=09=09=09      const struct sock *listen_sk,
+=09=09=09      const struct dst_entry *dst);
+
+void mptcp_openreq_init(struct request_sock *req,
+=09=09=09const struct tcp_options_received *rx_opt,
+=09=09=09struct sk_buff *skb, const struct sock *sk);
+
+void mptcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb);
+
+struct sock *mptcp_fastopen_create_child(struct sock *sk,
+=09=09=09=09=09 struct sk_buff *skb,
+=09=09=09=09=09 struct request_sock *req);
+
+bool mptcp_fastopen_queue_check(struct sock *sk);
+
+bool mptcp_fastopen_cookie_gen_cipher(struct request_sock *req,
+=09=09=09=09      struct sk_buff *syn,
+=09=09=09=09      const siphash_key_t *key,
+=09=09=09=09      struct tcp_fastopen_cookie *foc);
+
+void mptcp_fastopen_cookie_gen(struct sock *sk,
+=09=09=09       struct request_sock *req,
+=09=09=09       struct sk_buff *syn,
+=09=09=09       struct tcp_fastopen_cookie *foc);
+
+int mptcp_fastopen_cookie_gen_check(struct sock *sk,
+=09=09=09=09    struct request_sock *req,
+=09=09=09=09    struct sk_buff *syn,
+=09=09=09=09    struct tcp_fastopen_cookie *orig,
+=09=09=09=09    struct tcp_fastopen_cookie *valid_foc);
+
+bool mptcp_fastopen_no_cookie(const struct sock *sk,
+=09=09=09      const struct dst_entry *dst,
+=09=09=09      int flag);
+
+struct sock *mptcp_try_fastopen(struct sock *sk, struct sk_buff *skb,
+=09=09=09=09struct request_sock *req,
+=09=09=09=09struct tcp_fastopen_cookie *foc,
+=09=09=09=09const struct dst_entry *dst);
+
+int mptcp_conn_request(struct request_sock_ops *rsk_ops,
+=09=09       const struct tcp_request_sock_ops *af_ops,
+=09=09       struct sock *sk, struct sk_buff *skb);
+
+#endif /* __MPTCP_FASTOPEN_H */
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index be3b918a6d15..1ce965ee71d2 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -887,16 +887,19 @@ bool mptcp_established_options(struct sock *sk, struc=
t sk_buff *skb,
 }
=20
 bool mptcp_synack_options(const struct request_sock *req, unsigned int *si=
ze,
-=09=09=09  struct mptcp_out_options *opts)
+=09=09=09  struct mptcp_out_options *opts, u16 *tcp_options)
 {
 =09struct mptcp_subflow_request_sock *subflow_req =3D mptcp_subflow_rsk(re=
q);
+=09struct inet_request_sock *ireq =3D inet_rsk(req);
+#define OPTION_TS               BIT(1)
+=09*tcp_options ^=3D OPTION_TS;
=20
 =09if (subflow_req->mp_capable) {
 =09=09opts->suboptions =3D OPTION_MPTCP_MPC_SYNACK;
 =09=09opts->sndr_key =3D subflow_req->local_key;
 =09=09opts->csum_reqd =3D subflow_req->csum_reqd;
 =09=09opts->allow_join_id0 =3D subflow_req->allow_join_id0;
-=09=09*size =3D TCPOLEN_MPTCP_MPC_SYNACK;
+=09=09*size =3D TCPOLEN_MPTCP_MPC_SYNACK  - TCPOLEN_TSTAMP_ALIGNED + TCPOL=
EN_SACKPERM_ALIGNED;
 =09=09pr_debug("subflow_req=3D%p, local_key=3D%llu",
 =09=09=09 subflow_req, subflow_req->local_key);
 =09=09return true;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d6aef4b13b8a..64a2635405c4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -25,6 +25,7 @@
 #include <asm/ioctls.h>
 #include "protocol.h"
 #include "mib.h"
+#include "mptcp_fastopen.h"
=20
 #define CREATE_TRACE_POINTS
 #include <trace/events/mptcp.h>
@@ -1690,9 +1691,9 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 =09int ret =3D 0;
 =09long timeo;
=20
-=09/* we don't support FASTOPEN yet */
+=09/* we don't fully support FASTOPEN yet */
 =09if (msg->msg_flags & MSG_FASTOPEN)
-=09=09return -EOPNOTSUPP;
+=09=09mptcp_sendmsg_fastopen(sk, msg, len, msk, &copied);
=20
 =09/* silently ignore everything else */
 =09msg->msg_flags &=3D MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL;
@@ -2681,6 +2682,7 @@ void mptcp_subflow_shutdown(struct sock *sk, struct s=
ock *ssk, int how)
 =09case TCP_SYN_SENT:
 =09=09tcp_disconnect(ssk, O_NONBLOCK);
 =09=09break;
+=09case TCP_ESTABLISHED:
 =09default:
 =09=09if (__mptcp_check_fallback(mptcp_sk(sk))) {
 =09=09=09pr_debug("Fallback");
@@ -3476,7 +3478,7 @@ static void mptcp_subflow_early_fallback(struct mptcp=
_sock *msk,
 =09__mptcp_do_fallback(msk);
 }
=20
-static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uadd=
r,
+int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 =09=09=09=09int addr_len, int flags)
 {
 =09struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8739794166d8..6b8784a35244 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -891,6 +891,9 @@ unsigned int mptcp_pm_get_add_addr_accept_max(const str=
uct mptcp_sock *msk);
 unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_local_addr_max(const struct mptcp_sock *msk);
=20
+int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
+=09=09=09 int addr_len, int flags);
+
 /* called under PM lock */
 static inline void __mptcp_pm_close_subflow(struct mptcp_sock *msk)
 {
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 423d3826ca1e..e1ae1ef224cf 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -560,6 +560,8 @@ static bool mptcp_supported_sockopt(int level, int optn=
ame)
 =09=09case TCP_TX_DELAY:
 =09=09case TCP_INQ:
 =09=09=09return true;
+=09=09case TCP_FASTOPEN:
+=09=09=09return true;
 =09=09}
=20
 =09=09/* TCP_MD5SIG, TCP_MD5SIG_EXT are not supported, MD5 is not compatib=
le with MPTCP */
@@ -768,6 +770,43 @@ static int mptcp_setsockopt_sol_tcp_defer(struct mptcp=
_sock *msk, sockptr_t optv
 =09return tcp_setsockopt(listener->sk, SOL_TCP, TCP_DEFER_ACCEPT, optval, =
optlen);
 }
=20
+static int mptcp_setsockopt_sol_tcp_fastopen(struct mptcp_sock *msk, sockp=
tr_t optval,
+=09=09=09=09=09     unsigned int optlen)
+{
+=09struct mptcp_subflow_context *subflow;
+=09struct sock *sk =3D (struct sock *)msk;
+=09struct net *net =3D sock_net(sk);
+=09int val;
+=09int ret;
+
+=09ret =3D 0;
+
+=09if (copy_from_sockptr(&val, optval, sizeof(val)))
+=09=09return -EFAULT;
+
+=09lock_sock(sk);
+
+=09mptcp_for_each_subflow(msk, subflow) {
+=09=09struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+
+=09=09lock_sock(ssk);
+
+=09=09if (val >=3D 0 && ((1 << sk->sk_state) & (TCPF_CLOSE |
+=09=09    TCPF_LISTEN))) {
+=09=09=09tcp_fastopen_init_key_once(net);
+=09=09=09fastopen_queue_tune(sk, val);
+=09=09} else {
+=09=09=09ret =3D -EINVAL;
+=09=09}
+
+=09=09release_sock(ssk);
+=09}
+
+=09release_sock(sk);
+
+=09return ret;
+}
+
 static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 =09=09=09=09    sockptr_t optval, unsigned int optlen)
 {
@@ -796,6 +835,8 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *=
msk, int optname,
 =09=09return mptcp_setsockopt_sol_tcp_nodelay(msk, optval, optlen);
 =09case TCP_DEFER_ACCEPT:
 =09=09return mptcp_setsockopt_sol_tcp_defer(msk, optval, optlen);
+=09case TCP_FASTOPEN:
+=09=09return mptcp_setsockopt_sol_tcp_fastopen(msk, optval, optlen);
 =09}
=20
 =09return -EOPNOTSUPP;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8841e8cd9ad8..9fa71b67fd5a 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -22,6 +22,7 @@
 #endif
 #include <net/mptcp.h>
 #include <uapi/linux/mptcp.h>
+#include "mptcp_fastopen.h"
 #include "protocol.h"
 #include "mib.h"
=20
@@ -542,9 +543,9 @@ static int subflow_v4_conn_request(struct sock *sk, str=
uct sk_buff *skb)
 =09if (skb_rtable(skb)->rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST))
 =09=09goto drop;
=20
-=09return tcp_conn_request(&mptcp_subflow_request_sock_ops,
-=09=09=09=09&subflow_request_sock_ipv4_ops,
-=09=09=09=09sk, skb);
+=09return mptcp_conn_request(&mptcp_subflow_request_sock_ops,
+=09=09=09=09=09  &subflow_request_sock_ipv4_ops,
+=09=09=09=09=09  sk, skb);
 drop:
 =09tcp_listendrop(sk);
 =09return 0;
--=20
2.25.1


