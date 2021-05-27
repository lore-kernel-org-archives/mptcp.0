Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42982FAD
	for <mptcp@lists.linux.dev>; Thu, 27 May 2021 04:17:16 +0000 (UTC)
IronPort-SDR: 5RoRMNVF/epXTjUtNdOCqTdYnfqELPud7mlCt/sAt7zAJEiWzhqfZ0k8bOe4cnXRu8JhqTDQqe
 ciFH7Y5buhGA==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="202677693"
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; 
   d="scan'208";a="202677693"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 21:17:15 -0700
IronPort-SDR: gSWMSiYm/3PT+lxQmVXjWFQClJmyhjPvw5fFNzK4DmT4+uXcXPvHeKTEkGpUCuuZqZkj8ielie
 i784V4gCER7w==
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; 
   d="scan'208";a="477313487"
Received: from oelenito-mobl1.amr.corp.intel.com ([10.212.180.42])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 21:17:15 -0700
Date: Wed, 26 May 2021 21:17:13 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net] mptcp: try harder to borrow memory from subflow
 under pressure
In-Reply-To: <bc6471c8f7444b89e7e5f6c8f7713972477fda36.1622045437.git.pabeni@redhat.com>
Message-ID: <e4ed3091-8734-ff3f-89fd-28ecc5981d5e@linux.intel.com>
References: <bc6471c8f7444b89e7e5f6c8f7713972477fda36.1622045437.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 26 May 2021, Paolo Abeni wrote:

> If the host is under sever memory pressure, and RX forward
> memory allocation for the msk fails, we try to borrow the
> required memory from the ingress subflow.
>
> The current attempt is a bit flaky: if skb->truesize is less
> than SK_MEM_QUANTUM, the ssk will not release any memory, and
> the next schedule will fail again.
>
> Instead, directly move the required amount of pages from the
> ssk to the msk, if available
>
> Fixes: 9c3f94e1681b ("mptcp: add missing memory scheduling in the rx path")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/protocol.c | 10 ++++++----
> 1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index bb029dd4ff5e..785e74c13b3c 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -286,11 +286,13 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
>
> 	/* try to fetch required memory from subflow */
> 	if (!sk_rmem_schedule(sk, skb, skb->truesize)) {
> -		if (ssk->sk_forward_alloc < skb->truesize)
> -			goto drop;
> -		__sk_mem_reclaim(ssk, skb->truesize);
> -		if (!sk_rmem_schedule(sk, skb, skb->truesize))
> +		int amount = sk_mem_pages(skb->truesize) << SK_MEM_QUANTUM_SHIFT;
> +
> +		if (ssk->sk_forward_alloc < amount)
> 			goto drop;
> +
> +		ssk->sk_forward_alloc -= amount;
> +		sk->sk_forward_alloc += amount;
> 	}
>
> 	has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
> -- 
> 2.26.3

Looks ok to me - the memory will be reclaimed from the msk later, if I 
understand correctly.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

--
Mat Martineau
Intel
