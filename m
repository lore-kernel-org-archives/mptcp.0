Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAB03D6E
	for <mptcp@lists.linux.dev>; Fri, 29 Jul 2022 23:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659135670; x=1690671670;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=kbdeRY9ibUSpsMkfehC5nFIex906v/MP4EdVHeW9mcU=;
  b=W7KphKBxcj5aCTxL9Sbx2SjVR39fYIXMTOz45xSa8yXufxPKk1E3PvBO
   ZPZexR/UPWfH4jPwVamEvyuEjLgkUXDO2mxKfGIbI96U98s8PyCT89hpr
   aYSQ3DYLbEMtiFmGAuQU+R3J9C74QqpYHGbWHs7adIXDstL8Qjf5rEIwy
   c/Sk/0TEkpj/nexGfZ1NQTYjufrIH+57rbaR/dVha3f6SI1UZZ+PS4UHQ
   66Ocqs0N1yLDNimlrhVfRU1fOnyLJIWtPHu7SYmBpC6avBA/VB2Ny9oyK
   75FwgwVhJiVmaZBRsJbk30VQAcUVlNM4udpsTE7vK1DlTrhut8K3Pd38K
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="289631910"
X-IronPort-AV: E=Sophos;i="5.93,202,1654585200"; 
   d="scan'208";a="289631910"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 16:01:09 -0700
X-IronPort-AV: E=Sophos;i="5.93,202,1654585200"; 
   d="scan'208";a="660422275"
Received: from jmborger-mobl.amr.corp.intel.com ([10.209.59.73])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 16:01:09 -0700
Date: Fri, 29 Jul 2022 16:01:09 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v2 mptcp-next 2/4] mptcp: more accurate receive buffer
 updates
In-Reply-To: <1da024c8ed9da4fcf78aa2d73e00c1f9e4d3e98f.1659117128.git.pabeni@redhat.com>
Message-ID: <13f2141b-f22b-8e16-1c74-13453ad3dc45@linux.intel.com>
References: <cover.1659117128.git.pabeni@redhat.com> <1da024c8ed9da4fcf78aa2d73e00c1f9e4d3e98f.1659117128.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 29 Jul 2022, Paolo Abeni wrote:

> Currently mptcp_cleanup_rbuf() makes a significant effort to avoid
> acquiring the subflow socket lock, estimating if the tcp level
> cleanup could actually send an ack.
>
> Such estimate is a bit rough when accounting for receive window
> change, as it consider the msk available buffer space instead
> of the announced mptcp-level window.
>
> Let's consider the announced window instead, mirroring closely
> the plain TCP implementation. We need to lockless access a bunch
> of additional, tcp fields.

Hi Paolo -

The code changes look good. For this last sentence above ("...lockless 
access a bunch of ... tcp fields"), I only see access to msk->rcv_wnd_sent 
and msk->ack_seq, and nothing obvious in the later commits. Could you 
clarify?


- Mat



>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> include/net/mptcp.h  |  2 ++
> net/ipv4/tcp.c       |  3 +++
> net/mptcp/options.c  |  1 -
> net/mptcp/protocol.c | 14 +++++++++++---
> net/mptcp/protocol.h |  6 +++++-
> 5 files changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 7af7fd48acc7..4b6c66b73bf4 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -136,6 +136,7 @@ static inline bool rsk_drop_req(const struct request_sock *req)
> 	return tcp_rsk(req)->is_mptcp && tcp_rsk(req)->drop_req;
> }
>
> +void mptcp_receive_window(const struct sock *ssk, int *rwnd);
> void mptcp_space(const struct sock *ssk, int *space, int *full_space);
> bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
> 		       unsigned int *size, struct mptcp_out_options *opts);
> @@ -284,6 +285,7 @@ static inline bool mptcp_skb_can_collapse(const struct sk_buff *to,
> 	return true;
> }
>
> +static inline void mptcp_receive_window(const struct sock *ssk, int *rwnd) { }
> static inline void mptcp_space(const struct sock *ssk, int *s, int *fs) { }
> static inline void mptcp_seq_show(struct seq_file *seq) { }
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 970e9a2cca4a..d0c0100f74f3 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1606,6 +1606,9 @@ void tcp_cleanup_rbuf(struct sock *sk, int copied)
> 	if (copied > 0 && !time_to_ack && !(sk->sk_shutdown & RCV_SHUTDOWN)) {
> 		__u32 rcv_window_now = tcp_receive_window(tp);
>
> +		if (sk_is_mptcp(sk))
> +			mptcp_receive_window(sk, &rcv_window_now);
> +
> 		/* Optimize, __tcp_select_window() is not cheap. */
> 		if (2*rcv_window_now <= tp->window_clamp) {
> 			__u32 new_window = __tcp_select_window(sk);
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 30d289044e71..563ef8fe5a85 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -604,7 +604,6 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
> 	}
> 	opts->ext_copy.use_ack = 1;
> 	opts->suboptions = OPTION_MPTCP_DSS;
> -	WRITE_ONCE(msk->old_wspace, __mptcp_space((struct sock *)msk));
>
> 	/* Add kind/length/subtype/flag overhead if mapping is not populated */
> 	if (dss_size == 0)
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 5af3d591a20b..17e2dbe43639 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -535,6 +535,14 @@ static void mptcp_subflow_cleanup_rbuf(struct sock *ssk)
> 	unlock_sock_fast(ssk, slow);
> }
>
> +void mptcp_receive_window(const struct sock *ssk, int *rwnd)
> +{
> +	const struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> +	const struct sock *sk = subflow->conn;
> +
> +	*rwnd = __mptcp_receive_window(mptcp_sk(sk));
> +}
> +
> static bool mptcp_subflow_could_cleanup(const struct sock *ssk, bool rx_empty)
> {
> 	const struct inet_connection_sock *icsk = inet_csk(ssk);
> @@ -550,13 +558,13 @@ static bool mptcp_subflow_could_cleanup(const struct sock *ssk, bool rx_empty)
>
> static void mptcp_cleanup_rbuf(struct mptcp_sock *msk)
> {
> -	int old_space = READ_ONCE(msk->old_wspace);
> +	int cur_window = __mptcp_receive_window(msk);
> 	struct mptcp_subflow_context *subflow;
> 	struct sock *sk = (struct sock *)msk;
> -	int space =  __mptcp_space(sk);
> +	int new_window =  __mptcp_space(sk);
> 	bool cleanup, rx_empty;
>
> -	cleanup = (space > 0) && (space >= (old_space << 1));
> +	cleanup = new_window > 0 && new_window >= (cur_window << 1);
> 	rx_empty = !__mptcp_rmem(sk);
>
> 	mptcp_for_each_subflow(msk, subflow) {
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 1bc9f6e77ddd..1e603f28f1db 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -260,7 +260,6 @@ struct mptcp_sock {
> 	int		rmem_fwd_alloc;
> 	struct sock	*last_snd;
> 	int		snd_burst;
> -	int		old_wspace;
> 	u64		recovery_snd_nxt;	/* in recovery mode accept up to this seq;
> 						 * recovery related fields are under data_lock
> 						 * protection
> @@ -336,6 +335,11 @@ static inline int __mptcp_rmem(const struct sock *sk)
> 	return atomic_read(&sk->sk_rmem_alloc) - READ_ONCE(mptcp_sk(sk)->rmem_released);
> }
>
> +static inline int __mptcp_receive_window(const struct mptcp_sock *msk)
> +{
> +	return atomic64_read(&msk->rcv_wnd_sent) - READ_ONCE(msk->ack_seq);
> +}
> +
> static inline int __mptcp_space(const struct sock *sk)
> {
> 	return tcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf) - __mptcp_rmem(sk));
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
