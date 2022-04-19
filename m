Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442A481D
	for <mptcp@lists.linux.dev>; Tue, 19 Apr 2022 00:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650328169; x=1681864169;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Me3xWLuAUWjnjpDcM5bYbDrmynP+09vfnV7DKT0L3PI=;
  b=O+XN5ThxN9pmG8Q0wEYSY56/6qLdOb1P7XHZjnkK52wcw3o+LPWxUpIF
   bEWExrsONK0FNK7NxUwJaXsP2yQ+12qCOpMvrbrxpymmWEJY6je7XgeYW
   vCvvj1aNiy2WH8klIHixY/e1zp4Yhs0866r/Vp9jLQsA2jjQh8BltRJXr
   YXqTLId8/Hd6EI8tWHcSfL+C2nGDW7uQ4U2Bakbvcw4KBVBYp8zAVjpln
   F6GkcUbskDXvFtgzkLsydQoHQNG0Ox3akcj14FQRR73dfmkjxSXDjz3xC
   J52roRLfpav5Ftfuba5zOM01wVhWKNa2KsKPyAzTYx7EyKH6UyA5oDM1z
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="245532728"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="245532728"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 17:29:25 -0700
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="554465661"
Received: from amandeep-mobl2.amr.corp.intel.com ([10.251.6.7])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 17:29:25 -0700
Date: Mon, 18 Apr 2022 17:29:25 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH net-next 4/5] mptcp: never shrink offered window
In-Reply-To: <1f9262fde4d50db2d9d5c46254b823fd3e451465.1650034062.git.pabeni@redhat.com>
Message-ID: <c5a12ac8-563c-61e1-6d9-fbe318f6b8ec@linux.intel.com>
References: <cover.1650034062.git.pabeni@redhat.com> <1f9262fde4d50db2d9d5c46254b823fd3e451465.1650034062.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 15 Apr 2022, Paolo Abeni wrote:

> As per RFC, the offered MPTCP-level window should never shrink.
> While we currently track the right edge, we don't enforce the
> above constraint on the wire.
> Additionally, concurrent xmit on different subflows can end-up in
> erroneous right edge update.
> Address the above explicitly updating the announced window and
> protecting the update with an additional atomic operation (sic)

By "(sic)", are you saying the new atomic operation is consistent with the 
use of an atomic write in the previously written code?

I'm accustomed to "sic" meaning "there's a misspelling in the previous few 
words that have been preserved from some copied text" when I encounter it 
in English text, so I figure the Latin word may have slightly different 
meaning here!


But, aside from the commit message, the code seems to build & test out 
fine - so just the one code question in patch 3.


- Mat

>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> RFC -> v1:
> - rebased on previous patch
> ---
> net/mptcp/options.c | 52 +++++++++++++++++++++++++++++++++++++++------
> 1 file changed, 45 insertions(+), 7 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 2570911735ab..9c76a171af1e 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1224,20 +1224,58 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
> 	return true;
> }
>
> -static void mptcp_set_rwin(const struct tcp_sock *tp)
> +static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
> {
> 	const struct sock *ssk = (const struct sock *)tp;
> -	const struct mptcp_subflow_context *subflow;
> +	struct mptcp_subflow_context *subflow;
> +	u64 ack_seq, rcv_wnd_old, rcv_wnd_new;
> 	struct mptcp_sock *msk;
> -	u64 ack_seq;
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
> +
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
> +raise_win:
> +		win = rcv_wnd_old - ack_seq;
> +		tp->rcv_wnd = min_t(u64, win, U32_MAX);
> +		new_win = tp->rcv_wnd;
>
> -	if (after64(ack_seq, READ_ONCE(msk->rcv_wnd_sent)))
> -		WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
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
> @@ -1554,7 +1592,7 @@ void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
> 	}
>
> 	if (tp)
> -		mptcp_set_rwin(tp);
> +		mptcp_set_rwin(tp, th);
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
