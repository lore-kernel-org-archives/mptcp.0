Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6318D6F
	for <mptcp@lists.linux.dev>; Thu, 25 Mar 2021 01:22:54 +0000 (UTC)
IronPort-SDR: 2OYGMMKIT1VT5YahKO+7yun++3VsfRq6VNU04lp4rWE3OmXLcsjrQGmt1CVUwfz8GtWG3fcM7g
 gTg9LWiGcqNA==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="177939574"
X-IronPort-AV: E=Sophos;i="5.81,276,1610438400"; 
   d="scan'208";a="177939574"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 18:22:53 -0700
IronPort-SDR: Oq3a+EvbUPO4tADYD6sRhWo5BUXTWQ1dL5ol1WtdLO2fxnFaGCave09AccTYgeACtqAp7tULaD
 WVfO6vTn98PQ==
X-IronPort-AV: E=Sophos;i="5.81,276,1610438400"; 
   d="scan'208";a="514410131"
Received: from yuanzha5-mobl.amr.corp.intel.com ([10.252.129.242])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 18:22:53 -0700
Date: Wed, 24 Mar 2021 18:22:52 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: mptcp@lists.linux.dev, mptcp@lists.01.org
Subject: Re: [RFC PATCH mptcp-next v2 5/8] mptcp: setsockopt: add SO_MARK
 support
In-Reply-To: <20210324131546.13730-6-fw@strlen.de>
Message-ID: <c4fbd91c-2873-956b-df8-7bba2da711f@linux.intel.com>
References: <20210324131546.13730-1-fw@strlen.de> <20210324131546.13730-6-fw@strlen.de>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 24 Mar 2021, Florian Westphal wrote:

> Value is synced to all subflows.
>

The use case I remember for SO_MARK with MPTCP was to designate different 
interfaces for different subflows:

https://lore.kernel.org/mptcp/CAKD1Yr2sBCdUO48cp=rZQ6s4v13ytpPd9oPT+U=iYrdXtba5HA@mail.gmail.com/


Once we have a way to set individual subflow options, it could both be 
useful to set sk_mark on all subflows, and also to not override individual 
settings. The current sync mechanism would overwrite all supported options 
when any single option changes.

There's no way for these options to diverge yet, so we could wait on 
solving that problem. Do you think it's better to stick with the current 
syncing method for now, or to do more detailed tracking of which options 
need to be synced?


Mat


> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
> net/mptcp/sockopt.c | 13 +++++++++++++
> 1 file changed, 13 insertions(+)
>
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index f33a9ee12544..cb29013d7d74 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -66,6 +66,12 @@ static void mptcp_sol_socket_sync_intval(struct mptcp_sock *msk, int optname, in
> 			ssk->sk_userlocks |= SOCK_RCVBUF_LOCK;
> 			WRITE_ONCE(ssk->sk_rcvbuf, sk->sk_rcvbuf);
> 			break;
> +		case SO_MARK:
> +			if (READ_ONCE(ssk->sk_mark) != sk->sk_mark) {
> +				ssk->sk_mark = sk->sk_mark;
> +				sk_dst_reset(ssk);
> +			}
> +			break;
> 		}
>
> 		subflow->setsockopt_seq = msk->setsockopt_seq;
> @@ -103,6 +109,7 @@ static int mptcp_setsockopt_sol_socket_int(struct mptcp_sock *msk, int optname,
> 	case SO_KEEPALIVE:
> 		mptcp_sol_socket_sync_intval(msk, optname, val);
> 		return 0;
> +	case SO_MARK:
> 	case SO_PRIORITY:
> 	case SO_SNDBUF:
> 	case SO_SNDBUFFORCE:
> @@ -193,6 +200,7 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
> 	case SO_SNDBUFFORCE:
> 	case SO_RCVBUF:
> 	case SO_RCVBUFFORCE:
> +	case SO_MARK:
> 		return mptcp_setsockopt_sol_socket_int(msk, optname, optval, optlen);
> 	case SO_LINGER:
> 		return mptcp_setsockopt_sol_socket_linger(msk, optval, optlen);
> @@ -521,6 +529,11 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
> 	} else {
> 		sock_reset_flag(ssk, SOCK_LINGER);
> 	}
> +
> +	if (sk->sk_mark != ssk->sk_mark) {
> +		ssk->sk_mark = sk->sk_mark;
> +		sk_dst_reset(ssk);
> +	}
> }
>
> void mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk)
> -- 
> 2.26.3
>
>
>

--
Mat Martineau
Intel
