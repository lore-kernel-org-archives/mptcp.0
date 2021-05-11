Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C7A72
	for <mptcp@lists.linux.dev>; Tue, 11 May 2021 00:02:27 +0000 (UTC)
IronPort-SDR: wAanniVSbHhg8xO/22fjntpw6uCDzk41VEhUkbtFGRbVEq89lRpFpMB3htVp9uReIq8Y8fdTFj
 UVCpRckLWGRg==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="263246156"
X-IronPort-AV: E=Sophos;i="5.82,288,1613462400"; 
   d="scan'208";a="263246156"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 17:02:26 -0700
IronPort-SDR: TsT7prc2QJlneCCuuHrWjxFCWCXYYrM9PvFjwU+Ot+hpzo7jAGKe8LR0BH4Tw2HW2NwOF8/aAF
 PnjmU2JtdR4g==
X-IronPort-AV: E=Sophos;i="5.82,288,1613462400"; 
   d="scan'208";a="609281606"
Received: from akalita-mobl1.amr.corp.intel.com ([10.209.125.201])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 17:02:26 -0700
Date: Mon, 10 May 2021 17:02:26 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 1/8] mptcp: enable busypoll from mptcp receive
 path
In-Reply-To: <20210506102243.2390-2-fw@strlen.de>
Message-ID: <7dfc3b81-cab9-2a6b-917-3145f4dda45@linux.intel.com>
References: <20210506102243.2390-1-fw@strlen.de> <20210506102243.2390-2-fw@strlen.de>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 6 May 2021, Florian Westphal wrote:

> The setting is only relevant for the msk socket.
> While at it, also handle rcvlowat/rcvtimeo this way.
>
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
> net/mptcp/protocol.c | 7 +++++++
> net/mptcp/sockopt.c  | 8 ++++++++
> 2 files changed, 15 insertions(+)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index aec8e77b18e4..e51070883064 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -12,6 +12,7 @@
> #include <linux/sched/signal.h>
> #include <linux/atomic.h>
> #include <net/sock.h>
> +#include <net/busy_poll.h>
> #include <net/inet_common.h>
> #include <net/inet_hashtables.h>
> #include <net/protocol.h>
> @@ -1966,6 +1967,12 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
> 	if (unlikely(flags & MSG_ERRQUEUE))
> 		return inet_recv_error(sk, msg, len, addr_len);
>
> +	if (sk_can_busy_loop(sk) &&
> +	    skb_queue_empty_lockless(&msk->receive_queue) &&
> +	    skb_queue_empty_lockless(&sk->sk_receive_queue) &&
> +	     inet_sk_state_load(sk) == TCP_ESTABLISHED)

Minor nit-pick - extra indent space on the last line of this conditional. 
I'd just ask Matthieu to fix up when applying but I have one more comment 
on patch 5.


Mat


> +		sk_busy_loop(sk, nonblock);
> +
> 	mptcp_lock_sock(sk, __mptcp_splice_receive_queue(sk));
> 	if (unlikely(sk->sk_state == TCP_LISTEN)) {
> 		copied = -ENOTCONN;
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 00d941b66c1e..c98e4e116992 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -254,6 +254,14 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
> 		return mptcp_setsockopt_sol_socket_int(msk, optname, optval, optlen);
> 	case SO_LINGER:
> 		return mptcp_setsockopt_sol_socket_linger(msk, optval, optlen);
> +	case SO_RCVLOWAT:
> +	case SO_RCVTIMEO_OLD:
> +	case SO_RCVTIMEO_NEW:
> +	case SO_BUSY_POLL:
> +	case SO_PREFER_BUSY_POLL:
> +	case SO_BUSY_POLL_BUDGET:
> +		/* No need to copy: only relevant for msk */
> +		break;
> 	case SO_NO_CHECK:
> 	case SO_DONTROUTE:
> 	case SO_BROADCAST:
> -- 
> 2.26.3
>
>
>

--
Mat Martineau
Intel
