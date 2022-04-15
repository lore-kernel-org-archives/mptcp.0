Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869407B
	for <mptcp@lists.linux.dev>; Fri, 15 Apr 2022 00:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649983145; x=1681519145;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Kud5wavpeEsnaunHLzrEhLVsenF5MHHWZx5hujJ/Ovw=;
  b=h5WeAx6MlVu4hY+vO+NseH1ZT1oqEc1XpMkH9LjsSFduLM4h6TWkZ2AR
   H9sLEvnPM72Vhg9J/txQrg6u7PumezyKLWZdQ9Jnhl8NoKDJhjU91Idcq
   d+WbPpLaSUKvdYtTJ2Wy0jP/cfKcVPITRAHmWVx9oqLw3zliErfQ8d/uS
   /5PocUv/iEkUshqazNN4YW1j6uxSalzg8ey67lFqmrRd3uv0HADPkfI2i
   lG+CCZ/l/mcRtpHUHNqdg1y9hle/uJDn9vX+8L6GUGkYusVvjXS6ybfVC
   7e/O5esleb/qkkvkZNL5zOyTiKmLtX7pcEfcKREKl33DMDxIBDcjD/Yb/
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="261909979"
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; 
   d="scan'208";a="261909979"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 17:39:03 -0700
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; 
   d="scan'208";a="591386494"
Received: from woodmatt-mobl1.amr.corp.intel.com ([10.212.148.55])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 17:39:03 -0700
Date: Thu, 14 Apr 2022 17:39:03 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [RFC PATCH 3/4] mptcp: never shrink offered window
In-Reply-To: <ab1fd2897c57a50d7580950dbe6fb58006c04253.1649672265.git.pabeni@redhat.com>
Message-ID: <5da064a1-b272-49b1-4d71-4b635251316@linux.intel.com>
References: <cover.1649672265.git.pabeni@redhat.com> <ab1fd2897c57a50d7580950dbe6fb58006c04253.1649672265.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 11 Apr 2022, Paolo Abeni wrote:

> As per RFC, the offered MPTCP-level window should never shrink.
> While we currently track the right edge, we don't enforce the
> above constraint on the wire.
> Additionally, concurrent xmit on different subflows can end-up in
> erroneous right edge update.
> Address the above explicitly updating the announced window and
> protecting the update with an additional atomic operation (sic)
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> include/net/mptcp.h   |  2 +-
> net/ipv4/tcp_output.c |  2 +-
> net/mptcp/options.c   | 57 +++++++++++++++++++++++++++++++++++++------
> 3 files changed, 51 insertions(+), 10 deletions(-)
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 877077b53200..5706d132713e 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -125,7 +125,7 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
> 			       struct mptcp_out_options *opts);
> bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb);
>
> -void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
> +void mptcp_write_options(__be32 *ptr, struct tcp_sock *tp,
> 			 struct mptcp_out_options *opts);
>
> void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info);
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index c221f3bce975..edad33b9db11 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -444,7 +444,7 @@ struct tcp_out_options {
> 	struct mptcp_out_options mptcp;
> };
>
> -static void mptcp_options_write(__be32 *ptr, const struct tcp_sock *tp,
> +static void mptcp_options_write(__be32 *ptr, struct tcp_sock *tp,
> 				struct tcp_out_options *opts)
> {
> #if IS_ENABLED(CONFIG_MPTCP)
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index e05d9458a025..ffc0292da041 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1224,20 +1224,61 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
> 	return true;
> }
>
> -static void mptcp_set_rwin(const struct tcp_sock *tp)
> +static void mptcp_set_rwin(struct tcp_sock *tp, void *opt)
> {
> 	const struct sock *ssk = (const struct sock *)tp;
> -	const struct mptcp_subflow_context *subflow;
> +	struct mptcp_subflow_context *subflow;
> +	u64 ack_seq, rcv_wnd_old, rcv_wnd_new;
> 	struct mptcp_sock *msk;
> -	u64 ack_seq;
> +	struct tcphdr *th;
> +	u32 new_win;
> +	u64 win;
>
> 	subflow = mptcp_subflow_ctx(ssk);
> 	msk = mptcp_sk(subflow->conn);
>
> -	ack_seq = READ_ONCE(msk->ack_seq) + tp->rcv_wnd;
> +	ack_seq = READ_ONCE(msk->ack_seq);
> +	rcv_wnd_new = ack_seq + tp->rcv_wnd;
> +
> +	rcv_wnd_old = READ_ONCE(msk->rcv_wnd_sent);
> +	if (after64(rcv_wnd_new, rcv_wnd_old)) {
> +		u64 rcv_wnd;
>
> -	if (after64(ack_seq, READ_ONCE(msk->rcv_wnd_sent)))
> -		WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
> +		for (;;) {
> +			rcv_wnd = cmpxchg64(&msk->rcv_wnd_sent, rcv_wnd_old, rcv_wnd_new);
> +
> +			if (rcv_wnd == rcv_wnd_old)
> +				break;
> +			if (before64(rcv_wnd_new, rcv_wnd))
> +				goto raise_win;
> +			rcv_wnd_old = rcv_wnd;
> +		};
> +		return;
> +	}
> +
> +	if (rcv_wnd_new != rcv_wnd_old) {
> +
> +raise_win:
> +		th = opt - sizeof(struct tcphdr);

'opt' is a pointer to a struct mptcp_out_options, not a pointer to the 
option bytes in a tcp header... so this ends up writing somewhere 
unexpected on the stack.

'ptr' (in mptcp_write_options()) is somewhere in the TCP header, but we 
don't know how much option space was consumed before mptcp_write_options() 
was called. Looks like a copy of the original ptr passed in to 
tcp_options_write() (or, even better, an actual tcphdr pointer!) needs to 
be plumbed in to this function.


- Mat

> +		win = rcv_wnd_old - ack_seq;
> +		tp->rcv_wnd = min_t(u64, win, U32_MAX);
> +		new_win = tp->rcv_wnd;
> +
> +		/* Make sure we do not exceed the maximum possible
> +		 * scaled window.
> +		 */
> +		if (unlikely(th->syn))
> +			new_win = min(new_win, 65535U) << tp->rx_opt.rcv_wscale;
> +		if (!tp->rx_opt.rcv_wscale &&
> +		    sock_net(ssk)->ipv4.sysctl_tcp_workaround_signed_windows)
> +			new_win = min(new_win, MAX_TCP_WINDOW);
> +		else
> +			new_win = min(new_win, (65535U << tp->rx_opt.rcv_wscale));
> +
> +		/* RFC1323 scaling applied */
> +		new_win >>= tp->rx_opt.rcv_wscale;
> +		th->window = htons(new_win);
> +	}
> }
>
> u16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __wsum sum)
> @@ -1265,7 +1306,7 @@ static u16 mptcp_make_csum(const struct mptcp_ext *mpext)
> 				 ~csum_unfold(mpext->csum));
> }
>
> -void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
> +void mptcp_write_options(__be32 *ptr, struct tcp_sock *tp,
> 			 struct mptcp_out_options *opts)
> {
> 	const struct sock *ssk = (const struct sock *)tp;
> @@ -1554,7 +1595,7 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
> 	}
>
> 	if (tp)
> -		mptcp_set_rwin(tp);
> +		mptcp_set_rwin(tp, opts);
> }
>
> __be32 mptcp_get_reset_option(const struct sk_buff *skb)
> -- 
> 2.35.1
>
>
>

--
Mat Martineau
Intel
