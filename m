Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3F37F
	for <mptcp@lists.linux.dev>; Wed,  3 Aug 2022 00:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659486744; x=1691022744;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=NT43/qHnNbzHvgSrAA5BHugOTNfIcNEPAETc29pwdXA=;
  b=UVt6YaBsnRMw7TqOM/y3W7y4R7XwP0oEsmWDc8u2C3jpK+R+9Wj1yeIl
   q6rAa5Imdkvl4nOutkkgZRSP1E/gU1qZ1+uD8qq871FhpwlCcnFLlSd9T
   BIUtNmFiqPL/w2yJ2lmqGjASgHvRCwoDTqf18gsYE46xHWZo3fvG8UdYJ
   aBomKg6em1ddFN3APoRTWsKD0qcr2BKerFMXGyshR7Dam4Pvr0wMMk6aa
   INSeaQo9RLiQBUoZAKm20ElFqCWMuIDRtL3wH4y350ulan00yCmsXFlK0
   +x7ZBVakMxshExj+t4EKTzEmeytx/ciZ1IrJq3W7H1bpP266q4gjGoW0c
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="375849944"
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="375849944"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 17:32:24 -0700
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="692049186"
Received: from dnrajurk-mobl.amr.corp.intel.com ([10.209.121.166])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 17:32:24 -0700
Date: Tue, 2 Aug 2022 17:32:23 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Dmytro SHYTYI <dmytro@shytyi.net>
cc: mptcp@lists.linux.dev
Subject: Re: [RFC PATCH mptcp-next v4] mptcp: Fast Open Mechanism
In-Reply-To: <20220801024656.397714-1-dmytro@shytyi.net>
Message-ID: <1d70103b-3ef9-1c1b-fedf-2359a93746f9@linux.intel.com>
References: <20220801024656.397714-1-dmytro@shytyi.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed

On Mon, 1 Aug 2022, Dmytro SHYTYI wrote:

> This set of patches will bring "Fast Open" Option support to MPTCP.
> The aim of Fast Open Mechanism is to eliminate one round trip
> time from a TCP conversation by allowing data to be included as
> part of the SYN segment that initiates the connection.
>
> IETF RFC 8684: Appendix B. TCP Fast Open and MPTCP.
>
> [PATCH v3] includes "client-server" partial support for :
> 1. MPTCP cookie request from client (seems to be working).
> 2. MPTCP cookie offering from server (seems to be working).
> 3. MPTCP SYN+DATA+COOKIE from client (seems to be working).
> 4. subsequent write + read on the opened socket (first launch
> with TFO request seems to be working, hovewer the second launch
> appears to have a mptcp "RST" issue).
>
> This patch is Work In Progress transitional draft.
> The differences between v3 and v4:
> 1. An attempt to reduce impact on existing TCP code.
> 2. 2 files related to mptcp_fastopen are created(*.h + *.c).
> 3. "subflow_v4_conn_request" is used to call "mptcp_conn_request"(
> located in "mptcp_fastopen.c") to process the received packet on the
> listener side when "SYN" is received during 3way handshake.
> 4. This chain adds "skb" to "&msk->sk_receive_queue"
> ("subflow_v4_conn_request"->"mptcp_conn_request"->
> "mptcp_try_fastopen"->"mptcp_fastopen_create_child"->
> "mptcp_fastopen_add_skb")
> 5. Some minor comments from mailing list are not yet included
> in the current version of the PATCH.
>
> Signed-off-by: Dmytro SHYTYI <dmytro@shytyi.net>

Hi Dmytro -

Thanks for sharing this work-in-progress, I appreciate all the changes 
from the last RFC.

Since you've noted that this current version is still transitional and my 
understanding is that Benjamin is going to be collaborating on TFO, I'm 
assuming it's best to do a detailed review after some more progress. (If 
you do want more feedback now, just let me know).

I do have one comment below on the socket option handling.

> ---
> include/net/mptcp.h        |   2 +-
> net/ipv4/tcp_output.c      |   3 +-
> net/mptcp/Makefile         |   2 +-
> net/mptcp/mptcp_fastopen.c | 476 +++++++++++++++++++++++++++++++++++++
> net/mptcp/mptcp_fastopen.h |  67 ++++++
> net/mptcp/options.c        |   7 +-
> net/mptcp/protocol.c       |   8 +-
> net/mptcp/protocol.h       |   3 +
> net/mptcp/sockopt.c        |  41 ++++
> net/mptcp/subflow.c        |   7 +-
> 10 files changed, 604 insertions(+), 12 deletions(-)
> create mode 100644 net/mptcp/mptcp_fastopen.c
> create mode 100644 net/mptcp/mptcp_fastopen.h
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 6456ea26e4c7..692197187af8 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -139,7 +139,7 @@ void mptcp_space(const struct sock *ssk, int *space, int *full_space);
> bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
> 		       unsigned int *size, struct mptcp_out_options *opts);
> bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
> -			  struct mptcp_out_options *opts);
> +			  struct mptcp_out_options *opts, u16 *tcp_options);
> bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
> 			       unsigned int *size, unsigned int remaining,
> 			       struct mptcp_out_options *opts);
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index b4b2284ed4a2..864517e63bdf 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -747,7 +747,7 @@ static void mptcp_set_option_cond(const struct request_sock *req,
> 	if (rsk_is_mptcp(req)) {
> 		unsigned int size;
>
> -		if (mptcp_synack_options(req, &size, &opts->mptcp)) {
> +		if (mptcp_synack_options(req, &size, &opts->mptcp, &opts->options)) {
> 			if (*remaining >= size) {
> 				opts->options |= OPTION_MPTCP;
> 				*remaining -= size;
> @@ -822,7 +822,6 @@ static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb,
> 			tp->syn_fastopen_exp = fastopen->cookie.exp ? 1 : 0;
> 		}
> 	}
> -
> 	smc_set_option(tp, opts, &remaining);
>
> 	if (sk_is_mptcp(sk)) {
> diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
> index 8a7f68efa35f..0f1022b395ef 100644
> --- a/net/mptcp/Makefile
> +++ b/net/mptcp/Makefile
> @@ -2,7 +2,7 @@
> obj-$(CONFIG_MPTCP) += mptcp.o
>
> mptcp-y := protocol.o subflow.o options.o token.o crypto.o ctrl.o pm.o diag.o \
> -	   mib.o pm_netlink.o sockopt.o pm_userspace.o sched.o
> +	   mib.o pm_netlink.o sockopt.o pm_userspace.o sched.o mptcp_fastopen.o
>
> obj-$(CONFIG_SYN_COOKIES) += syncookies.o
> obj-$(CONFIG_INET_MPTCP_DIAG) += mptcp_diag.o
> diff --git a/net/mptcp/mptcp_fastopen.c b/net/mptcp/mptcp_fastopen.c
> new file mode 100644
> index 000000000000..cca086e178a6
> --- /dev/null
> +++ b/net/mptcp/mptcp_fastopen.c
> @@ -0,0 +1,476 @@
> +#include "mptcp_fastopen.h"
> +
> +int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
> +			   size_t len, struct mptcp_sock *msk,
> +			   size_t *copied)
> +{
> +	const struct iphdr *iph;
> +	struct ubuf_info *uarg;
> +	struct sockaddr *uaddr;
> +	struct sk_buff *skb;
> +	struct tcp_sock *tp;
> +	struct socket *ssk;
> +	int ret;
> +
> +	ssk = __mptcp_nmpc_socket(msk);
> +	if (unlikely(!ssk))
> +		goto out_EFAULT;
> +	skb = tcp_stream_alloc_skb(ssk->sk, 0, ssk->sk->sk_allocation, true);
> +	if (unlikely(!skb))
> +		goto out_EFAULT;
> +	iph = ip_hdr(skb);
> +	if (unlikely(!iph))
> +		goto out_EFAULT;
> +	uarg = msg_zerocopy_realloc(sk, len, skb_zcopy(skb));
> +	if (unlikely(!uarg))
> +		goto out_EFAULT;
> +	uaddr = msg->msg_name;
> +
> +	tp = tcp_sk(ssk->sk);
> +	if (unlikely(!tp))
> +		goto out_EFAULT;
> +	if (!tp->fastopen_req)
> +		tp->fastopen_req = kzalloc(sizeof(*tp->fastopen_req),
> +					   ssk->sk->sk_allocation);
> +
> +	if (unlikely(!tp->fastopen_req))
> +		goto out_EFAULT;
> +	tp->fastopen_req->data = msg;
> +	tp->fastopen_req->size = len;
> +	tp->fastopen_req->uarg = uarg;
> +
> +	/* requests a cookie */
> +	*copied = mptcp_stream_connect(sk->sk_socket, uaddr,
> +				   msg->msg_namelen, msg->msg_flags);
> +
> +	return 0;
> +out_EFAULT:
> +	ret = -EFAULT;
> +	return ret;
> +}
> +
> +void mptcp_reqsk_record_syn(const struct sock *sk,
> +			    struct request_sock *req,
> +			    const struct sk_buff *skb)
> +{
> +	if (tcp_sk(sk)->save_syn) {
> +		u32 length = skb_network_header_len(skb) + tcp_hdrlen(skb);
> +		struct saved_syn *svd_syn;
> +		u32 mac_headerlen;
> +		void *base;
> +
> +		if (tcp_sk(sk)->save_syn == 2) {
> +			base = skb_mac_header(skb);
> +			mac_headerlen = skb_mac_header_len(skb);
> +			length += mac_headerlen;
> +		} else {
> +			base = skb_network_header(skb);
> +			mac_headerlen = 0;
> +		}
> +
> +		svd_syn = kmalloc(struct_size(svd_syn, data, length),
> +				    GFP_ATOMIC);
> +		if (svd_syn) {
> +			svd_syn->mac_hdrlen = mac_headerlen;
> +			svd_syn->network_hdrlen = skb_network_header_len(skb);
> +			svd_syn->tcp_hdrlen = tcp_hdrlen(skb);
> +			memcpy(svd_syn->data, base, length);
> +			req->saved_syn = svd_syn;
> +		}
> +	}
> +}
> +
> +void mptcp_ecn_create_request(struct request_sock *req,
> +			      const struct sk_buff *skb,
> +			      const struct sock *listen_sk,
> +			      const struct dst_entry *dst)
> +{
> +	const struct tcphdr *thdr = tcp_hdr(skb);
> +	const struct net *net = sock_net(listen_sk);
> +	bool thdr_ecn = thdr->ece && thdr->cwr;
> +	bool ect_stat, ecn_okay;
> +	u32 ecn_okay_dst;
> +
> +	if (!thdr_ecn)
> +		return;
> +
> +	ect_stat = !INET_ECN_is_not_ect(TCP_SKB_CB(skb)->ip_dsfield);
> +	ecn_okay_dst = dst_feature(dst, DST_FEATURE_ECN_MASK);
> +	ecn_okay = net->ipv4.sysctl_tcp_ecn || ecn_okay_dst;
> +
> +	if (((!ect_stat || thdr->res1) && ecn_okay) || tcp_ca_needs_ecn(listen_sk) ||
> +	    (ecn_okay_dst & DST_FEATURE_ECN_CA) ||
> +	    tcp_bpf_ca_needs_ecn((struct sock *)req))
> +		inet_rsk(req)->ecn_ok = 1;
> +}
> +
> +void mptcp_openreq_init(struct request_sock *req,
> +			const struct tcp_options_received *rx_opt,
> +			struct sk_buff *skb, const struct sock *sk)
> +{
> +	struct inet_request_sock *ireq = inet_rsk(req);
> +
> +	req->rsk_rcv_wnd = 0;
> +	tcp_rsk(req)->rcv_isn = TCP_SKB_CB(skb)->seq;
> +	tcp_rsk(req)->rcv_nxt = TCP_SKB_CB(skb)->seq + 1;
> +	tcp_rsk(req)->snt_synack = 0;
> +	tcp_rsk(req)->last_oow_ack_time = 0;
> +	req->mss = rx_opt->mss_clamp;
> +	req->ts_recent = rx_opt->saw_tstamp ? rx_opt->rcv_tsval : 0;
> +	ireq->tstamp_ok = rx_opt->tstamp_ok;
> +	ireq->sack_ok = rx_opt->sack_ok;
> +	ireq->snd_wscale = rx_opt->snd_wscale;
> +	ireq->wscale_ok = rx_opt->wscale_ok;
> +	ireq->acked = 0;
> +	ireq->ecn_ok = 0;
> +	ireq->ir_rmt_port = tcp_hdr(skb)->source;
> +	ireq->ir_num = ntohs(tcp_hdr(skb)->dest);
> +	ireq->ir_mark = inet_request_mark(sk, skb);
> +}
> +
> +void mptcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb)
> +{
> +	struct sock *msk = mptcp_subflow_ctx(sk)->conn;
> +	struct tcp_sock *tp = tcp_sk(sk);
> +
> +	if (TCP_SKB_CB(skb)->end_seq == tp->rcv_nxt)
> +		return;
> +
> +	skb = skb_clone(skb, GFP_ATOMIC);
> +	if (!skb)
> +		return;
> +
> +	skb_dst_drop(skb);
> +
> +	tp->segs_in = 0;
> +	tcp_segs_in(tp, skb);
> +	__skb_pull(skb, tcp_hdrlen(skb));
> +	sk_forced_mem_schedule(sk, skb->truesize);
> +	skb_set_owner_r(skb, sk);
> +
> +	TCP_SKB_CB(skb)->seq++;
> +	TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_SYN;
> +
> +	tp->rcv_nxt = TCP_SKB_CB(skb)->end_seq;
> +
> +	__skb_queue_tail(&msk->sk_receive_queue, skb);
> +
> +	tp->syn_data_acked = 1;
> +
> +	tp->bytes_received = skb->len;
> +
> +	if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN)
> +		tcp_fin(sk);
> +}
> +
> +struct sock *mptcp_fastopen_create_child(struct sock *sk,
> +					 struct sk_buff *skb,
> +					 struct request_sock *req)
> +{
> +	struct request_sock_queue *r_sock_queue = &inet_csk(sk)->icsk_accept_queue;
> +	struct tcp_sock *tp;
> +	struct sock *child_sock;
> +	bool own_req;
> +
> +	child_sock = inet_csk(sk)->icsk_af_ops->syn_recv_sock(sk, skb, req, NULL,
> +							 NULL, &own_req);
> +	if (!child_sock)
> +		return NULL;
> +
> +	spin_lock(&r_sock_queue->fastopenq.lock);
> +	r_sock_queue->fastopenq.qlen++;
> +	spin_unlock(&r_sock_queue->fastopenq.lock);
> +
> +	tp = tcp_sk(child_sock);
> +
> +	rcu_assign_pointer(tp->fastopen_rsk, req);
> +	tcp_rsk(req)->tfo_listener = true;
> +
> +	tp->snd_wnd = ntohs(tcp_hdr(skb)->window);
> +	tp->max_window = tp->snd_wnd;
> +
> +	inet_csk_reset_xmit_timer(child_sock, ICSK_TIME_RETRANS,
> +				  TCP_TIMEOUT_INIT, TCP_RTO_MAX);
> +
> +	refcount_set(&req->rsk_refcnt, 2);
> +
> +	tcp_init_transfer(child_sock, BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB, skb);
> +
> +
> +	tp->rcv_nxt = TCP_SKB_CB(skb)->seq + 1;
> +	//tp->rcv_nxt = TCP_SKB_CB(skb)->end_seq;
> +	//tp->copied_seq = 4;//3
> +
> +	mptcp_fastopen_add_skb(child_sock, skb);
> +
> +	tcp_rsk(req)->rcv_nxt = tp->rcv_nxt;
> +	tp->rcv_wup = tp->rcv_nxt;
> +
> +	return child_sock;
> +}
> +
> +bool mptcp_fastopen_queue_check(struct sock *sk)
> +{
> +	struct fastopen_queue *fo_queue;
> +	struct request_sock *req_sock;
> +
> +	fo_queue = &inet_csk(sk)->icsk_accept_queue.fastopenq;
> +	if (fo_queue->max_qlen == 0)
> +		return false;
> +
> +	if (fo_queue->qlen >= fo_queue->max_qlen) {
> +
> +		spin_lock(&fo_queue->lock);
> +		req_sock = fo_queue->rskq_rst_head;
> +		if (!req_sock || time_after(req_sock->rsk_timer.expires, jiffies)) {
> +			spin_unlock(&fo_queue->lock);
> +			return false;
> +		}
> +		fo_queue->rskq_rst_head = req_sock->dl_next;
> +		fo_queue->qlen--;
> +		spin_unlock(&fo_queue->lock);
> +		reqsk_put(req_sock);
> +	}
> +	return true;
> +}
> +
> +bool mptcp_fastopen_cookie_gen_cipher(struct request_sock *req,
> +				      struct sk_buff *syn,
> +				      const siphash_key_t *key,
> +				      struct tcp_fastopen_cookie *foc)
> +{
> +	if (req->rsk_ops->family == AF_INET) {
> +		const struct iphdr *iph = ip_hdr(syn);
> +
> +		foc->val[0] = cpu_to_le64(siphash(&iph->saddr,
> +					  sizeof(iph->saddr) +
> +					  sizeof(iph->daddr),
> +					  key));
> +		foc->len = TCP_FASTOPEN_COOKIE_SIZE;
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +
> +void mptcp_fastopen_cookie_gen(struct sock *sk,
> +			       struct request_sock *req,
> +			       struct sk_buff *syn,
> +			       struct tcp_fastopen_cookie *foc)
> +{
> +	struct tcp_fastopen_context *ctx;
> +
> +	rcu_read_lock();
> +	ctx = tcp_fastopen_get_ctx(sk);
> +	if (ctx)
> +		mptcp_fastopen_cookie_gen_cipher(req, syn, &ctx->key[0], foc);
> +	rcu_read_unlock();
> +}
> +
> +int mptcp_fastopen_cookie_gen_check(struct sock *sk,
> +				    struct request_sock *req,
> +				    struct sk_buff *syn,
> +				    struct tcp_fastopen_cookie *orig,
> +				    struct tcp_fastopen_cookie *valid_foc)
> +{
> +	struct tcp_fastopen_cookie mptcp_search_foc = { .len = -1 };
> +	struct tcp_fastopen_cookie *mptcp_foc = valid_foc;
> +	struct tcp_fastopen_context *mptcp_fo_ctx;
> +	int i, ret = 0;
> +
> +	rcu_read_lock();
> +	mptcp_fo_ctx = tcp_fastopen_get_ctx(sk);
> +	if (!mptcp_fo_ctx)
> +		goto out;
> +	for (i = 0; i < tcp_fastopen_context_len(mptcp_fo_ctx); i++) {
> +		mptcp_fastopen_cookie_gen_cipher(req, syn, &mptcp_fo_ctx->key[i], mptcp_foc);
> +		if (tcp_fastopen_cookie_match(mptcp_foc, orig)) {
> +			ret = i + 1;
> +			goto out;
> +		}
> +		mptcp_foc = &mptcp_search_foc;
> +	}
> +out:
> +	rcu_read_unlock();
> +	return ret;
> +}
> +
> +
> +bool mptcp_fastopen_no_cookie(const struct sock *sk,
> +			      const struct dst_entry *dst,
> +			      int flag)
> +{
> +	return (sock_net(sk)->ipv4.sysctl_tcp_fastopen & flag) ||
> +	       tcp_sk(sk)->fastopen_no_cookie ||
> +	       (dst && dst_metric(dst, RTAX_FASTOPEN_NO_COOKIE));
> +}
> +
> +struct sock *mptcp_try_fastopen(struct sock *sk, struct sk_buff *skb,
> +				struct request_sock *req,
> +				struct tcp_fastopen_cookie *foc,
> +				const struct dst_entry *dst)
> +{
> +	bool syn_data_status = TCP_SKB_CB(skb)->end_seq != TCP_SKB_CB(skb)->seq + 1;
> +	struct tcp_fastopen_cookie valid_mptcp_foc = { .len = -1 };
> +	struct sock *child_sock;
> +	int ret = 0;
> +
> +
> +	if ((syn_data_status || foc->len >= 0) &&
> +	      mptcp_fastopen_queue_check(sk)) {
> +		foc->len = -1;
> +		return NULL;
> +	}
> +
> +	if (mptcp_fastopen_no_cookie(sk, dst, TFO_SERVER_COOKIE_NOT_REQD))
> +		goto fastopen;
> +
> +	if (foc->len == 0) {
> +		mptcp_fastopen_cookie_gen(sk, req, skb, &valid_mptcp_foc);
> +	} else if (foc->len > 0) {
> +		ret = mptcp_fastopen_cookie_gen_check(sk, req, skb, foc,
> +						    &valid_mptcp_foc);
> +		if (!ret) {
> +			__asm__ ("NOP");
> +		} else {
> +fastopen:
> +			child_sock = mptcp_fastopen_create_child(sk, skb, req);
> +			if (child_sock) {
> +				if (ret == 2) {
> +					valid_mptcp_foc.exp = foc->exp;
> +					*foc = valid_mptcp_foc;
> +				} else {
> +					foc->len = -1;
> +				}
> +				return child_sock;
> +			}
> +		}
> +	}
> +	valid_mptcp_foc.exp = foc->exp;
> +	*foc = valid_mptcp_foc;
> +	return NULL;
> +}
> +
> +int mptcp_conn_request(struct request_sock_ops *rsk_ops,
> +		       const struct tcp_request_sock_ops *af_ops,
> +		       struct sock *sk, struct sk_buff *skb)
> +{
> +	struct tcp_fastopen_cookie mptcp_foc = { .len = -1 };
> +	struct tcp_options_received tmp_opt_rcvd;
> +	__u32 isn = TCP_SKB_CB(skb)->tcp_tw_isn;
> +	struct tcp_sock *tp_sock = tcp_sk(sk);
> +	struct sock *mptcp_fo_sk = NULL;
> +	struct net *net = sock_net(sk);
> +	struct request_sock *req_sock;
> +	bool want_cookie = false;
> +	struct dst_entry *dst;
> +	struct flowi fl;
> +
> +	if (sk_acceptq_is_full(sk)) {
> +		goto drop;
> +	}
> +
> +	req_sock = inet_reqsk_alloc(rsk_ops, sk, !want_cookie);
> +	if (!req_sock)
> +		goto drop;
> +
> +	req_sock->syncookie = want_cookie;
> +	tcp_rsk(req_sock)->af_specific = af_ops;
> +	tcp_rsk(req_sock)->ts_off = 0;
> +	tcp_rsk(req_sock)->is_mptcp = 1;
> +
> +	tcp_clear_options(&tmp_opt_rcvd);
> +	tmp_opt_rcvd.mss_clamp = af_ops->mss_clamp;
> +	tmp_opt_rcvd.user_mss  = tp_sock->rx_opt.user_mss;
> +	tcp_parse_options(sock_net(sk), skb, &tmp_opt_rcvd, 0,
> +			  want_cookie ? NULL : &mptcp_foc);
> +
> +	if (want_cookie && !tmp_opt_rcvd.saw_tstamp)
> +		tcp_clear_options(&tmp_opt_rcvd);
> +
> +	if (IS_ENABLED(CONFIG_SMC) && want_cookie)
> +		tmp_opt_rcvd.smc_ok = 0;
> +
> +	tmp_opt_rcvd.tstamp_ok = tmp_opt_rcvd.saw_tstamp;
> +	mptcp_openreq_init(req_sock, &tmp_opt_rcvd, skb, sk);
> +	inet_rsk(req_sock)->no_srccheck = inet_sk(sk)->transparent;
> +
> +	inet_rsk(req_sock)->ir_iif = inet_request_bound_dev_if(sk, skb);
> +
> +	dst = af_ops->route_req(sk, skb, &fl, req_sock);
> +	if (!dst)
> +		goto drop_and_free;
> +
> +	if (tmp_opt_rcvd.tstamp_ok)
> +		tcp_rsk(req_sock)->ts_off = af_ops->init_ts_off(net, skb);
> +
> +	if (!want_cookie && !isn) {
> +		if (!net->ipv4.sysctl_tcp_syncookies &&
> +		    (net->ipv4.sysctl_max_syn_backlog - inet_csk_reqsk_queue_len(sk) <
> +		     (net->ipv4.sysctl_max_syn_backlog >> 2)) &&
> +		    !tcp_peer_is_proven(req_sock, dst)) {
> +			goto drop_and_release;
> +		}
> +
> +		isn = af_ops->init_seq(skb);
> +	}
> +
> +	mptcp_ecn_create_request(req_sock, skb, sk, dst);
> +
> +	if (want_cookie) {
> +		isn = cookie_init_sequence(af_ops, sk, skb, &req_sock->mss);
> +		if (!tmp_opt_rcvd.tstamp_ok)
> +			inet_rsk(req_sock)->ecn_ok = 0;
> +	}
> +
> +	tcp_rsk(req_sock)->snt_isn = isn;
> +	tcp_rsk(req_sock)->txhash = net_tx_rndhash();
> +	tcp_rsk(req_sock)->syn_tos = TCP_SKB_CB(skb)->ip_dsfield;
> +
> +	tcp_openreq_init_rwin(req_sock, sk, dst);
> +	sk_rx_queue_set(req_to_sk(req_sock), skb);
> +	if (!want_cookie) {
> +		mptcp_reqsk_record_syn(sk, req_sock, skb);
> +		mptcp_fo_sk = mptcp_try_fastopen(sk, skb, req_sock, &mptcp_foc, dst);
> +	}
> +	if (mptcp_fo_sk) {
> +		af_ops->send_synack(mptcp_fo_sk, dst, &fl, req_sock,
> +				    &mptcp_foc, TCP_SYNACK_FASTOPEN, skb);
> +		if (!inet_csk_reqsk_queue_add(sk, req_sock, mptcp_fo_sk)) {
> +			reqsk_fastopen_remove(mptcp_fo_sk, req_sock, false);
> +			bh_unlock_sock(mptcp_fo_sk);
> +			sock_put(mptcp_fo_sk);
> +			goto drop_and_free;
> +		}
> +		sk->sk_data_ready(sk);
> +		bh_unlock_sock(mptcp_fo_sk);
> +		sock_put(mptcp_fo_sk);
> +
> +
> +	} else {
> +		tcp_rsk(req_sock)->tfo_listener = false;
> +		if (!want_cookie) {
> +			req_sock->timeout = tcp_timeout_init((struct sock *)req_sock);
> +			inet_csk_reqsk_queue_hash_add(sk, req_sock, req_sock->timeout);
> +		}
> +		af_ops->send_synack(sk, dst, &fl, req_sock, &mptcp_foc,
> +				    !want_cookie ? TCP_SYNACK_NORMAL :
> +						   TCP_SYNACK_COOKIE,
> +				    skb);
> +		if (want_cookie) {
> +			reqsk_free(req_sock);
> +			return 0;
> +		}
> +	}
> +	reqsk_put(req_sock);
> +	return 0;
> +
> +drop_and_release:
> +	dst_release(dst);
> +drop_and_free:
> +	__reqsk_free(req_sock);
> +drop:
> +	tcp_listendrop(sk);
> +	return 0;
> +}
> diff --git a/net/mptcp/mptcp_fastopen.h b/net/mptcp/mptcp_fastopen.h
> new file mode 100644
> index 000000000000..c050195c60a7
> --- /dev/null
> +++ b/net/mptcp/mptcp_fastopen.h
> @@ -0,0 +1,67 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + * MPTCP Fast Open Mechanism. Copyright (c) 2021-2022, Dmytro SHYTYI.
> + */
> +
> +#ifndef __MPTCP_FASTOPEN_H
> +#define __MPTCP_FASTOPEN_H
> +
> +#include <uapi/linux/mptcp.h>
> +#include <net/mptcp.h>
> +#include <net/sock.h>
> +#include "protocol.h"
> +
> +int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
> +			   size_t len, struct mptcp_sock *msk,
> +			   size_t *copied);
> +
> +void mptcp_reqsk_record_syn(const struct sock *sk,
> +			    struct request_sock *req,
> +			    const struct sk_buff *skb);
> +
> +void mptcp_ecn_create_request(struct request_sock *req,
> +			      const struct sk_buff *skb,
> +			      const struct sock *listen_sk,
> +			      const struct dst_entry *dst);
> +
> +void mptcp_openreq_init(struct request_sock *req,
> +			const struct tcp_options_received *rx_opt,
> +			struct sk_buff *skb, const struct sock *sk);
> +
> +void mptcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb);
> +
> +struct sock *mptcp_fastopen_create_child(struct sock *sk,
> +					 struct sk_buff *skb,
> +					 struct request_sock *req);
> +
> +bool mptcp_fastopen_queue_check(struct sock *sk);
> +
> +bool mptcp_fastopen_cookie_gen_cipher(struct request_sock *req,
> +				      struct sk_buff *syn,
> +				      const siphash_key_t *key,
> +				      struct tcp_fastopen_cookie *foc);
> +
> +void mptcp_fastopen_cookie_gen(struct sock *sk,
> +			       struct request_sock *req,
> +			       struct sk_buff *syn,
> +			       struct tcp_fastopen_cookie *foc);
> +
> +int mptcp_fastopen_cookie_gen_check(struct sock *sk,
> +				    struct request_sock *req,
> +				    struct sk_buff *syn,
> +				    struct tcp_fastopen_cookie *orig,
> +				    struct tcp_fastopen_cookie *valid_foc);
> +
> +bool mptcp_fastopen_no_cookie(const struct sock *sk,
> +			      const struct dst_entry *dst,
> +			      int flag);
> +
> +struct sock *mptcp_try_fastopen(struct sock *sk, struct sk_buff *skb,
> +				struct request_sock *req,
> +				struct tcp_fastopen_cookie *foc,
> +				const struct dst_entry *dst);
> +
> +int mptcp_conn_request(struct request_sock_ops *rsk_ops,
> +		       const struct tcp_request_sock_ops *af_ops,
> +		       struct sock *sk, struct sk_buff *skb);
> +
> +#endif /* __MPTCP_FASTOPEN_H */
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index be3b918a6d15..1ce965ee71d2 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -887,16 +887,19 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
> }
>
> bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
> -			  struct mptcp_out_options *opts)
> +			  struct mptcp_out_options *opts, u16 *tcp_options)
> {
> 	struct mptcp_subflow_request_sock *subflow_req = mptcp_subflow_rsk(req);
> +	struct inet_request_sock *ireq = inet_rsk(req);
> +#define OPTION_TS               BIT(1)
> +	*tcp_options ^= OPTION_TS;
>
> 	if (subflow_req->mp_capable) {
> 		opts->suboptions = OPTION_MPTCP_MPC_SYNACK;
> 		opts->sndr_key = subflow_req->local_key;
> 		opts->csum_reqd = subflow_req->csum_reqd;
> 		opts->allow_join_id0 = subflow_req->allow_join_id0;
> -		*size = TCPOLEN_MPTCP_MPC_SYNACK;
> +		*size = TCPOLEN_MPTCP_MPC_SYNACK  - TCPOLEN_TSTAMP_ALIGNED + TCPOLEN_SACKPERM_ALIGNED;
> 		pr_debug("subflow_req=%p, local_key=%llu",
> 			 subflow_req, subflow_req->local_key);
> 		return true;
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index d6aef4b13b8a..64a2635405c4 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -25,6 +25,7 @@
> #include <asm/ioctls.h>
> #include "protocol.h"
> #include "mib.h"
> +#include "mptcp_fastopen.h"
>
> #define CREATE_TRACE_POINTS
> #include <trace/events/mptcp.h>
> @@ -1690,9 +1691,9 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
> 	int ret = 0;
> 	long timeo;
>
> -	/* we don't support FASTOPEN yet */
> +	/* we don't fully support FASTOPEN yet */
> 	if (msg->msg_flags & MSG_FASTOPEN)
> -		return -EOPNOTSUPP;
> +		mptcp_sendmsg_fastopen(sk, msg, len, msk, &copied);
>
> 	/* silently ignore everything else */
> 	msg->msg_flags &= MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL;
> @@ -2681,6 +2682,7 @@ void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how)
> 	case TCP_SYN_SENT:
> 		tcp_disconnect(ssk, O_NONBLOCK);
> 		break;
> +	case TCP_ESTABLISHED:
> 	default:
> 		if (__mptcp_check_fallback(mptcp_sk(sk))) {
> 			pr_debug("Fallback");
> @@ -3476,7 +3478,7 @@ static void mptcp_subflow_early_fallback(struct mptcp_sock *msk,
> 	__mptcp_do_fallback(msk);
> }
>
> -static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
> +int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
> 				int addr_len, int flags)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sock->sk);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 8739794166d8..6b8784a35244 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -891,6 +891,9 @@ unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
> unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk);
> unsigned int mptcp_pm_get_local_addr_max(const struct mptcp_sock *msk);
>
> +int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
> +			 int addr_len, int flags);
> +
> /* called under PM lock */
> static inline void __mptcp_pm_close_subflow(struct mptcp_sock *msk)
> {
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 423d3826ca1e..e1ae1ef224cf 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -560,6 +560,8 @@ static bool mptcp_supported_sockopt(int level, int optname)
> 		case TCP_TX_DELAY:
> 		case TCP_INQ:
> 			return true;
> +		case TCP_FASTOPEN:
> +			return true;
> 		}
>
> 		/* TCP_MD5SIG, TCP_MD5SIG_EXT are not supported, MD5 is not compatible with MPTCP */
> @@ -768,6 +770,43 @@ static int mptcp_setsockopt_sol_tcp_defer(struct mptcp_sock *msk, sockptr_t optv
> 	return tcp_setsockopt(listener->sk, SOL_TCP, TCP_DEFER_ACCEPT, optval, optlen);
> }
>
> +static int mptcp_setsockopt_sol_tcp_fastopen(struct mptcp_sock *msk, sockptr_t optval,
> +					     unsigned int optlen)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct sock *sk = (struct sock *)msk;
> +	struct net *net = sock_net(sk);
> +	int val;
> +	int ret;
> +
> +	ret = 0;
> +
> +	if (copy_from_sockptr(&val, optval, sizeof(val)))
> +		return -EFAULT;
> +
> +	lock_sock(sk);
> +
> +	mptcp_for_each_subflow(msk, subflow) {

Since fastopen is only relevant for the initial subflow (and never with 
MP_JOIN), I don't think it's necessary to iterate over the subflows here. 
__mptcp_nmpc_socket() should give the initial subflow, check how it is 
used elsewhere in net/mptcp/sockopt.c


Thanks,

Mat

> +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +
> +		lock_sock(ssk);
> +
> +		if (val >= 0 && ((1 << sk->sk_state) & (TCPF_CLOSE |
> +		    TCPF_LISTEN))) {
> +			tcp_fastopen_init_key_once(net);
> +			fastopen_queue_tune(sk, val);
> +		} else {
> +			ret = -EINVAL;
> +		}
> +
> +		release_sock(ssk);
> +	}
> +
> +	release_sock(sk);
> +
> +	return ret;
> +}
> +
> static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
> 				    sockptr_t optval, unsigned int optlen)
> {
> @@ -796,6 +835,8 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
> 		return mptcp_setsockopt_sol_tcp_nodelay(msk, optval, optlen);
> 	case TCP_DEFER_ACCEPT:
> 		return mptcp_setsockopt_sol_tcp_defer(msk, optval, optlen);
> +	case TCP_FASTOPEN:
> +		return mptcp_setsockopt_sol_tcp_fastopen(msk, optval, optlen);
> 	}
>
> 	return -EOPNOTSUPP;
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 8841e8cd9ad8..9fa71b67fd5a 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -22,6 +22,7 @@
> #endif
> #include <net/mptcp.h>
> #include <uapi/linux/mptcp.h>
> +#include "mptcp_fastopen.h"
> #include "protocol.h"
> #include "mib.h"
>
> @@ -542,9 +543,9 @@ static int subflow_v4_conn_request(struct sock *sk, struct sk_buff *skb)
> 	if (skb_rtable(skb)->rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST))
> 		goto drop;
>
> -	return tcp_conn_request(&mptcp_subflow_request_sock_ops,
> -				&subflow_request_sock_ipv4_ops,
> -				sk, skb);
> +	return mptcp_conn_request(&mptcp_subflow_request_sock_ops,
> +					  &subflow_request_sock_ipv4_ops,
> +					  sk, skb);
> drop:
> 	tcp_listendrop(sk);
> 	return 0;
> -- 
> 2.25.1
>
>
>
>

--
Mat Martineau
Intel
