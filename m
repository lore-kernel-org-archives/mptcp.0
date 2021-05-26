Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE34270
	for <mptcp@lists.linux.dev>; Wed, 26 May 2021 23:27:13 +0000 (UTC)
IronPort-SDR: AO7OFprVB1Vj78/k/8qf/t/HO/RVpN8sKNe3lGwK2dB16Spgfg1VbWjDDuWafSxLCVsPHjZi9E
 q6h1dWSkMvAA==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="189726152"
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; 
   d="scan'208";a="189726152"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 16:27:06 -0700
IronPort-SDR: 7bIb3X/PJTVG3Cxlvz41nI0CbZkYoHY/yw8C8PxCinEsMBb3EZRCyVmfs3VW0oXG1sXfOGnz1M
 kUc7NUIL7e3g==
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; 
   d="scan'208";a="472226976"
Received: from oelenito-mobl1.amr.corp.intel.com ([10.212.180.42])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 16:27:06 -0700
Date: Wed, 26 May 2021 16:27:04 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, max@internet.ru
Subject: Re: [PATCH mptcp-net] tcp: ensure that backlog coalescing don't
 break MPTCP DSS
In-Reply-To: <925dcab4e637ab2ad2d947baa937a62146040802.1622044966.git.pabeni@redhat.com>
Message-ID: <8268318-9d67-4752-46c5-5da27e507ebb@linux.intel.com>
References: <925dcab4e637ab2ad2d947baa937a62146040802.1622044966.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 26 May 2021, Paolo Abeni wrote:

> Currently the backlog coalescing does check for MPTCP validation:
> a relevant DSS could be lost leading to MPTCP stream corruption.
>
> The above is quite infrequent since the MPTCP subflows are not
> exposed to user-space but the MPTCP still acquires the ssk socket
> lock on some events.
>
> Fix the issue adding the missing test.
>
> Fixes: 85712484110d ("tcp: coalesce/collapse must respect MPTCP extensions")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> this can possibly fix issues/196, but it's very hard to demonstrate,
> even with pktdrill
> ---
> net/ipv4/tcp_ipv4.c | 1 +
> 1 file changed, 1 insertion(+)
>
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 4f5b68a90be9..6b033593d069 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -1822,6 +1822,7 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb)
>
> 	if (TCP_SKB_CB(tail)->end_seq != TCP_SKB_CB(skb)->seq ||
> 	    TCP_SKB_CB(tail)->ip_dsfield != TCP_SKB_CB(skb)->ip_dsfield ||
> +	    !mptcp_skb_can_collapse(tail, skb) ||
> 	    ((TCP_SKB_CB(tail)->tcp_flags |
> 	      TCP_SKB_CB(skb)->tcp_flags) & (TCPHDR_SYN | TCPHDR_RST | TCPHDR_URG)) ||
> 	    !((TCP_SKB_CB(tail)->tcp_flags &
> -- 
> 2.26.3

Yeah, definitely could lose MPTCP header information here.

Since mptcp_incoming_options() hasn't been called yet, skbs in the backlog 
queue will never have the MPTCP skb extensions that 
mptcp_skb_can_collapse() relies on.

Is it worth it to add a function that will do a subset of the 
mptcp_incoming_options() work to populate the skb extension for mptcp 
subflow socks? (and modify mptcp_incoming_options() to detect existing 
mpexts?)

--
Mat Martineau
Intel
