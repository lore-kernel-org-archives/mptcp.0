Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580122C9E
	for <mptcp@lists.linux.dev>; Fri,  3 Dec 2021 01:48:09 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="300278045"
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="300278045"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 17:48:08 -0800
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="746467931"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2) ([10.209.65.201])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 17:48:08 -0800
Date: Thu, 2 Dec 2021 17:48:07 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>, 
    Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH mptcp-next v5 1/2] Squash to "mptcp: implement fastclose
 xmit path"
In-Reply-To: <41e52e743ee397180dab0ad4a980e2b8d532bfe2.1638429740.git.geliang.tang@suse.com>
Message-ID: <3f716c5-dc2-5852-de11-f1aad3abc5@linux.intel.com>
References: <cover.1638429740.git.geliang.tang@suse.com> <41e52e743ee397180dab0ad4a980e2b8d532bfe2.1638429740.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 2 Dec 2021, Geliang Tang wrote:

> MP_FAIL could be sent with MP_RST at the same time, fix this in
> mptcp_established_options().
>
> MP_RST could be sent with FASTCLOSE at the same time, fix this in
> mptcp_write_options().
>

Matthieu -

We talked about the MP_FAIL+DSS combination in the meeting this week, and 
I think there is a case I overlooked in that discussion: When a peer 
receives an MP_FAIL, it may need to respond with both MP_FAIL and an 
infinite mapping (which is a DSS option). So it seems reasonable to handle 
those in the same header.


> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/options.c | 29 ++++++++++++++++++-----------
> 1 file changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 8a1020e4285c..73242304ada5 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -829,8 +829,12 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
>
> 	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
> 		if (mptcp_established_options_fastclose(sk, &opt_size, remaining, opts) ||
> -		    mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts) ||
> -		    mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) {
> +		    mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
> +			*size += opt_size;
> +			remaining -= opt_size;
> +		}
> +		/* MP_RST can be used with MP_FASTCLOSE and MP_FAIL if there is room */
> +		if (mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) {
> 			*size += opt_size;
> 			remaining -= opt_size;
> 		}
> @@ -1257,6 +1261,7 @@ static u16 mptcp_make_csum(const struct mptcp_ext *mpext)
> void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
> 			 struct mptcp_out_options *opts)
> {
> +	/* MP_FAIL is mutually exclusive with others except RST and DSS */
> 	if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions)) {
> 		const struct sock *ssk = (const struct sock *)tp;
> 		struct mptcp_subflow_context *subflow;
> @@ -1271,7 +1276,16 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
> 		ptr += 2;
> 	}
>
> -	/* DSS, MPC, MPJ, ADD_ADDR, FASTCLOSE and RST are mutually exclusive,
> +	/* RST is mutually exclusive with others except MP_FAIL and FASTCLOSE */
> +	if (unlikely(OPTION_MPTCP_RST & opts->suboptions)) {
> +		*ptr++ = mptcp_option(MPTCPOPT_RST,
> +				      TCPOLEN_MPTCP_RST,
> +				      opts->reset_transient,
> +				      opts->reset_reason);
> +		return;
> +	}

Geliang -

Moving this before the DSS block undoes some of Paolo's optimization for 
DSS. It would be better to handle the mutual exclusion with FASTCLOSE in a 
way that does not add this extra conditional in the common DSS case.

> +
> +	/* DSS, MPC, MPJ, ADD_ADDR and FASTCLOSE are mutually exclusive,
> 	 * see mptcp_established_options*()
> 	 */
> 	if (likely(OPTION_MPTCP_DSS & opts->suboptions)) {
> @@ -1458,15 +1472,8 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
> 				ptr += 1;
> 			}
> 		}
> -	} else if (unlikely(OPTION_MPTCP_RST & opts->suboptions)) {
> -		/* RST is mutually exclusive with everything else */
> -		*ptr++ = mptcp_option(MPTCPOPT_RST,
> -				      TCPOLEN_MPTCP_RST,
> -				      opts->reset_transient,
> -				      opts->reset_reason);
> -		return;
> 	} else if (unlikely(OPTION_MPTCP_FASTCLOSE & opts->suboptions)) {
> -		/* FASTCLOSE is mutually exclusive with everything else */
> +		/* FASTCLOSE is mutually exclusive with others except RST */
> 		*ptr++ = mptcp_option(MPTCPOPT_MP_FASTCLOSE,
> 				      TCPOLEN_MPTCP_FASTCLOSE,
> 				      0, 0);
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
