Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE1A363
	for <mptcp@lists.linux.dev>; Thu,  5 May 2022 00:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651709106; x=1683245106;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=x4wQb3b51qVU56CjchIKZMrYkCPSqiu5r3oOVilZMnA=;
  b=mcz5hN8Oyc8ctIRy+FwCfGEIuQVqTJzPaUTLVytpkvzM+FrWStfQfKOD
   tvnlauU+Iy6lFQC6cbhPrEdKDYqVntUyKnXFzg5a9TQXSaQb2+EFanlG7
   DCaDQlu+ioMoV/jY0bBd2KBqm9hibZw7MbberEJw5QTCeZ2CW+0oju9Br
   newTBb7uVWlbyF54VePMRhKpF2e800b1+kE8WEDLGW1EF7S0TvuqWlu8z
   8IjWYZAgCyTQ4dBciTJNOfSAxtfsUylxyfyEIbEgp7pniOL5vJXPawAYg
   civXpRyjVutLBb4RdClhOF1PfOUiLTw4NMpjwv4iV+csBpGrgmUz+mM1s
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="293131978"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="293131978"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 17:05:05 -0700
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="568339186"
Received: from jsbradle-mobl1.amr.corp.intel.com ([10.212.185.245])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 17:05:05 -0700
Date: Wed, 4 May 2022 17:05:05 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] mptcp: sockopt: add TCP_DEFER_ACCEPT
 support
In-Reply-To: <20220502163624.6110-1-fw@strlen.de>
Message-ID: <da50d518-b7f4-f225-a8de-d513bc29b40@linux.intel.com>
References: <20220502163624.6110-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 2 May 2022, Florian Westphal wrote:

> Support this via passthrough to the underlaying tcp listener socket.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/271
> Signed-off-by: Florian Westphal <fw@strlen.de>

Looks good to me:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> ---
> net/mptcp/sockopt.c | 15 +++++++++++++++
> 1 file changed, 15 insertions(+)
>
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 826b0c1dae98..423d3826ca1e 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -756,6 +756,18 @@ static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
> 	return -EOPNOTSUPP;
> }
>
> +static int mptcp_setsockopt_sol_tcp_defer(struct mptcp_sock *msk, sockptr_t optval,
> +					  unsigned int optlen)
> +{
> +	struct socket *listener;
> +
> +	listener = __mptcp_nmpc_socket(msk);
> +	if (!listener)
> +		return 0; /* TCP_DEFER_ACCEPT does not fail */
> +
> +	return tcp_setsockopt(listener->sk, SOL_TCP, TCP_DEFER_ACCEPT, optval, optlen);
> +}
> +
> static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
> 				    sockptr_t optval, unsigned int optlen)
> {
> @@ -782,6 +794,8 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
> 		return mptcp_setsockopt_sol_tcp_cork(msk, optval, optlen);
> 	case TCP_NODELAY:
> 		return mptcp_setsockopt_sol_tcp_nodelay(msk, optval, optlen);
> +	case TCP_DEFER_ACCEPT:
> +		return mptcp_setsockopt_sol_tcp_defer(msk, optval, optlen);
> 	}
>
> 	return -EOPNOTSUPP;
> @@ -1142,6 +1156,7 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
> 	case TCP_CONGESTION:
> 	case TCP_INFO:
> 	case TCP_CC_INFO:
> +	case TCP_DEFER_ACCEPT:
> 		return mptcp_getsockopt_first_sf_only(msk, SOL_TCP, optname,
> 						      optval, optlen);
> 	case TCP_INQ:
> -- 
> 2.35.1
>
>
>

--
Mat Martineau
Intel
