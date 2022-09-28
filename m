Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BE34C62
	for <mptcp@lists.linux.dev>; Wed, 28 Sep 2022 19:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664391928; x=1695927928;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=OnYB9AUdntp40ScGXAV/kd18idTsVM4exTdlvNlsKN8=;
  b=mp+CK4eloVwe92a7dk2le5ua2K3EWyvitIxTgzu6TPN+kLFR0m9WKLBf
   t+OHkVnBFtD/ForObBjPkEnr3UmgWzWwUuVzV3NAohXex7yxAhZQSAjOD
   zg8owz+gWNUJcpifNx1x4UbTWPS+ouGCMbT1nQ8STZ1GHREbPqGsxVdaB
   CDDp1+LkhPuKu0FBRnGGdIIm/DhDqnPup0YqLIIDFyOirvrFTCOCMu1vJ
   6Pbw4dL80BFVllxD+veYZIcNEA+uIVP9t9gOf9pWZ6hDjMLAjstdVlm7L
   NPO4uHgxo7ZJSsJtcWNsr0etxcxbQI0Q/1vW5rvEbN7JGwSySp2zWTu7y
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="299292208"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="299292208"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 12:05:27 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="624267479"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="624267479"
Received: from vnagbugb-mobl3.amr.corp.intel.com ([10.209.4.164])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 12:05:27 -0700
Date: Wed, 28 Sep 2022 12:05:26 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH mptcp-next] mptcp: sockopt: use new helper for
 TCP_DEFER_ACCEPT
In-Reply-To: <20220928091852.1933333-1-matthieu.baerts@tessares.net>
Message-ID: <49a8b516-1dd6-7abd-8be5-5a3f6fd441fb@linux.intel.com>
References: <20220928091852.1933333-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 28 Sep 2022, Matthieu Baerts wrote:

> mptcp_setsockopt_sol_tcp_defer() was doing the same thing as
> mptcp_setsockopt_first_sf_only() except for the returned code in case of
> error.
>
> Ignoring the error is needed to mimic how TCP_DEFER_ACCEPT is handled
> when used with "plain" TCP sockets.
>
> The specific function for TCP_DEFER_ACCEPT can be replaced by the new
> mptcp_setsockopt_first_sf_only() helper and errors can be ignored to
> stay compatible with TCP. A bit of cleanup.
>
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Suggested-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Looks good to me, thanks!

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> ---
> net/mptcp/sockopt.c | 16 +++-------------
> 1 file changed, 3 insertions(+), 13 deletions(-)
>
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 1857281a0dd5..f85e9bbfe86f 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -758,18 +758,6 @@ static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
> 	return -EOPNOTSUPP;
> }
>
> -static int mptcp_setsockopt_sol_tcp_defer(struct mptcp_sock *msk, sockptr_t optval,
> -					  unsigned int optlen)
> -{
> -	struct socket *listener;
> -
> -	listener = __mptcp_nmpc_socket(msk);
> -	if (!listener)
> -		return 0; /* TCP_DEFER_ACCEPT does not fail */
> -
> -	return tcp_setsockopt(listener->sk, SOL_TCP, TCP_DEFER_ACCEPT, optval, optlen);
> -}
> -
> static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int optname,
> 					  sockptr_t optval, unsigned int optlen)
> {
> @@ -810,7 +798,9 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
> 	case TCP_NODELAY:
> 		return mptcp_setsockopt_sol_tcp_nodelay(msk, optval, optlen);
> 	case TCP_DEFER_ACCEPT:
> -		return mptcp_setsockopt_sol_tcp_defer(msk, optval, optlen);
> +		/* See tcp.c: TCP_DEFER_ACCEPT does not fail */
> +		mptcp_setsockopt_first_sf_only(msk, SOL_TCP, optname, optval, optlen);
> +		return 0;
> 	case TCP_FASTOPEN_CONNECT:
> 	case TCP_FASTOPEN_NO_COOKIE:
> 		return mptcp_setsockopt_first_sf_only(msk, SOL_TCP, optname,
>
> base-commit: 6711fbb5e6c8541f84685542127455c18145d559
> -- 
> 2.37.2
>
>

--
Mat Martineau
Intel
