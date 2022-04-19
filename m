Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD357FC
	for <mptcp@lists.linux.dev>; Tue, 19 Apr 2022 00:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650327113; x=1681863113;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WhL4rAI3e1ueKTvIKA28solLSnr9bnKOf1FG8X5r6OQ=;
  b=E79uru12NcApsJXL4H2bTkFMYnL2TjSQEkcvoWKZah41M4JqEVBKNp3A
   /b5+Vrsd+svDAi0uVPzKsbhVoU54w6vLB814d513oSXLxQNOAATgcBhw+
   PogNgZmjTs+f3A3qAryZCElnEOE3BSAOueOdoHbNPYwpH0h+vV/URMBA+
   j0aDu6p8GR8kBTu44Peu/GqFYIa5UBk2wT+cYt7DXXsyCdu62ozIWEHfj
   T6YrzkgQIybJ6Fl5uADsWTuevI3oYIxgkCjhKHghDOOIFrMcCgQrYqztn
   zEy9/3fnH9QiRBy1NmMKFxQT4SGTjweV6yfa9LJxW+6auBlfMDbglzquf
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="263100142"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="263100142"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 17:11:52 -0700
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="554460401"
Received: from amandeep-mobl2.amr.corp.intel.com ([10.251.6.7])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 17:11:52 -0700
Date: Mon, 18 Apr 2022 17:11:52 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH net-next 3/5] tcp: allow MPTCP to update the announced
 window.
In-Reply-To: <89b12b9c11c6b35fc507f96d198719394caf6b08.1650034062.git.pabeni@redhat.com>
Message-ID: <5ec4e9a-e1f5-c698-bdf5-fd7fabc7374@linux.intel.com>
References: <cover.1650034062.git.pabeni@redhat.com> <89b12b9c11c6b35fc507f96d198719394caf6b08.1650034062.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 15 Apr 2022, Paolo Abeni wrote:

> The MPTCP RFC requires that the MPTCP-level receive window's
> right edge never moves backward. Currently the MPTCP code
> enforces such constraint while tracking the right edge, but it
> does not reflects it back on the wire, as lacks a suitable hook
> to update accordingly the TCP header.
>
> This change modifiy the existing mptcp_write_options() hook,
> providing the current packet's TCP header up to the MPTCP protocol
> level, so that the next patch could implement the above mentioned
> constraint.
>
> No functional changes intended.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> include/net/mptcp.h   |  2 +-
> net/ipv4/tcp_output.c | 13 +++++++------
> net/mptcp/options.c   |  2 +-
> 3 files changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 877077b53200..6b07011c060d 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -125,7 +125,7 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
> 			       struct mptcp_out_options *opts);
> bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb);
>
> -void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
> +void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
> 			 struct mptcp_out_options *opts);
>
> void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info);
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index c221f3bce975..27deec41a1f4 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -444,12 +444,13 @@ struct tcp_out_options {
> 	struct mptcp_out_options mptcp;
> };
>
> -static void mptcp_options_write(__be32 *ptr, const struct tcp_sock *tp,
> +static void mptcp_options_write(struct tcphdr *th, __be32 *ptr,
> +				struct tcp_sock *tp,
> 				struct tcp_out_options *opts)
> {
> #if IS_ENABLED(CONFIG_MPTCP)
> 	if (unlikely(OPTION_MPTCP & opts->options))
> -		mptcp_write_options(ptr, tp, &opts->mptcp);
> +		mptcp_write_options(th, ptr, tp, &opts->mptcp);
> #endif
> }
>
> @@ -605,7 +606,7 @@ static void bpf_skops_write_hdr_opt(struct sock *sk, struct sk_buff *skb,
>  * At least SACK_PERM as the first option is known to lead to a disaster
>  * (but it may well be that other scenarios fail similarly).
>  */
> -static void tcp_options_write(__be32 *ptr, struct tcp_sock *tp,
> +static void tcp_options_write(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
> 			      struct tcp_out_options *opts)

Having both th and ptr seems redundant to my eyes. I'd rather just have a 
th parameter and move the "ptr = (__be32 *)(th + 1);" code inside 
tcp_options_write().

If you're thinking/hoping that Eric finds the additional parameter more 
acceptible, we can go with this patch as-is.

- Mat

> {
> 	u16 options = opts->options;	/* mungable copy */
> @@ -701,7 +702,7 @@ static void tcp_options_write(__be32 *ptr, struct tcp_sock *tp,
>
> 	smc_options_write(ptr, &options);
>
> -	mptcp_options_write(ptr, tp, opts);
> +	mptcp_options_write(th, ptr, tp, opts);
> }
>
> static void smc_set_option(const struct tcp_sock *tp,
> @@ -1354,7 +1355,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
> 		th->window	= htons(min(tp->rcv_wnd, 65535U));
> 	}
>
> -	tcp_options_write((__be32 *)(th + 1), tp, &opts);
> +	tcp_options_write(th, (__be32 *)(th + 1), tp, &opts);
>
> #ifdef CONFIG_TCP_MD5SIG
> 	/* Calculate the MD5 hash, as we have all we need now */
> @@ -3590,7 +3591,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
>
> 	/* RFC1323: The window in SYN & SYN/ACK segments is never scaled. */
> 	th->window = htons(min(req->rsk_rcv_wnd, 65535U));
> -	tcp_options_write((__be32 *)(th + 1), NULL, &opts);
> +	tcp_options_write(th, (__be32 *)(th + 1), NULL, &opts);
> 	th->doff = (tcp_header_size >> 2);
> 	__TCP_INC_STATS(sock_net(sk), TCP_MIB_OUTSEGS);
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index e05d9458a025..2570911735ab 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1265,7 +1265,7 @@ static u16 mptcp_make_csum(const struct mptcp_ext *mpext)
> 				 ~csum_unfold(mpext->csum));
> }
>
> -void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
> +void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
> 			 struct mptcp_out_options *opts)
> {
> 	const struct sock *ssk = (const struct sock *)tp;
> -- 
> 2.35.1
>
>
>

--
Mat Martineau
Intel
