Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E145D463D
	for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 23:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645141946; x=1676677946;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ipLSik9rn9Gd8PhfKigKCsfp+RUzqfmQQwoIfQO79jg=;
  b=LFaijXJZHSFLCTY7YJhAba6bIlznuPAvBGdDCeOGe7gQkM1XFQkWeTCX
   Ry7haBlels5jaGZ4Y++LJdIUptWTf/WMYUkvzD08U18FSCy4xXuCQDTPZ
   /oYvrNc2FhFnPeHr4sWsXU4dt1UcUnQQEi37pvVpipeYZcobBNu0jnIFE
   5axsn6ZAU0bmozInVeD6Fx96hwGotH9HJMsPj8IdycD6krnWuOhd3DBpT
   cH+zHsYUIYrSdVD9+V0oiDur4BArHF+G6w5kfCn2tiecFrGIfzSZLBivA
   aExWlFLgSxhvW3t3pvC9har873/DDRY1yUKSqufF6txJDMjt6O40Oh9AR
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="234537353"
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="234537353"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 15:52:19 -0800
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="503754610"
Received: from pjayapal-mobl1.amr.corp.intel.com ([10.212.185.200])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 15:52:19 -0800
Date: Thu, 17 Feb 2022 15:52:18 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 4/5] mptcp: handle join requests via pernet
 listen socket
In-Reply-To: <20220217142538.7849-5-fw@strlen.de>
Message-ID: <5cbaa9-26e5-4ce0-7950-3ff131f9f3f8@linux.intel.com>
References: <20220217142538.7849-1-fw@strlen.de> <20220217142538.7849-5-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 17 Feb 2022, Florian Westphal wrote:

> Currently mptcp adds kernel-based listener socket for all
> netlink-configured mptcp address endpoints.
>
> This has caveats because kernel may interfere with unrelated programs
> that use same address/port pairs.
>
> RFC 8684 says:
> Demultiplexing subflow SYNs MUST be done using the token; this is
> unlike traditional TCP, where the destination port is used for
> demultiplexing SYN packets.  Once a subflow is set up, demultiplexing
> packets is done using the 5-tuple, as in traditional TCP.
>
> This patch deviates from this in that it retrains the existing checks of

Typo: retains

> verifying the incoming requests destination vs. the list of announced
> addresses.
>
> This can be relaxed later if deemed appropriate.
>
> Furthermore, TCP-only listeners take precedence: An MPTCP peer
> MUST NOT announce address:port pairs that are already in use by a
> non-mptcp listener.
> This could be changed, but it requires move of mptcp_handle_join()
> hook *before* the tcp port demux, i.e. an additional conditional in
> hotpath.  As-is, the additional conditional (syn && !rst && ...) is
> in the 'no socket found' path.
>
> The pernet 'listening' socket is hidden from userspace.
> It is not part of any hashes and not bound to any address or port.
>
> TPROXY-like semantics apply: If tcp demux cannot find a port for a given
> packet, check if the packet is a syn packet with a valid join token.
>
> If so, the pernet listener is returned and tcp processing resumes.
> Otherwise, handling is intentical.

Typo: identical

>
> This patch does not cover timewait sockets.
>

Can you elaborate on what properly covering timewait sockets would look 
like? Does the approach used by multipath-tcp.org (handling token lookup 
after inet_lookup_listener() / case TCP_TW_SYN in tcp_v4_rcv()) fit?


I have one more comment below, but other than that the code that's here is 
looking good and the big outstanding questions are the things you noted as 
not-yet-changed in the cover letter (MP_JOIN token lookup for established 
or TCP listening sockets). We did discuss that in today's meeting so I 
won't rehash here.


> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
> include/net/mptcp.h  |  10 ++
> net/ipv6/tcp_ipv6.c  |  19 ++--
> net/mptcp/ctrl.c     | 211 ++++++++++++++++++++++++++++++++++++++++++-
> net/mptcp/protocol.c |   2 +-
> net/mptcp/protocol.h |   2 +-
> net/mptcp/subflow.c  |   3 +
> 6 files changed, 233 insertions(+), 14 deletions(-)
>

...

> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index ae20b7d92e28..6358c803ba12 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c

...

> @@ -185,13 +203,173 @@ static void mptcp_pernet_del_table(struct mptcp_pernet *pernet) {}
>
> #endif /* CONFIG_SYSCTL */
>
> +struct sock *__mptcp_handle_join(int af, struct sk_buff *skb)
> +{
> +	struct mptcp_options_received mp_opt;
> +	struct mptcp_pernet *pernet;
> +	struct socket *ssock;
> +	struct sock *lsk;
> +	struct net *net;
> +
> +	/* paranoia check: don't allow 0 destination port,
> +	 * else __inet_inherit_port will insert the child socket
> +	 * into the phony hash slot of the pernet listener.
> +	 */
> +	if (tcp_hdr(skb)->dest == 0)
> +		return NULL;
> +
> +	mptcp_get_options(skb, &mp_opt);
> +
> +	if (!(mp_opt.suboptions & OPTIONS_MPTCP_MPJ))
> +		return NULL;
> +
> +	net = dev_net(skb_dst(skb)->dev);
> +	if (!mptcp_is_enabled(net))
> +		return NULL;
> +
> +	/* RFC8684: If the token is unknown [..], the receiver will send
> +	 * back a reset (RST) signal, analogous to an unknown port in TCP,
> +	 * containing an MP_TCPRST option (Section 3.6) [..]
> +	 */
> +	if (!mptcp_token_exists(net, mp_opt.token)) {
> +		struct mptcp_ext *ext = skb_ext_add(skb, SKB_EXT_MPTCP);
> +
> +		if (ext) {
> +			memset(ext, 0, sizeof(*ext));
> +			ext->reset_reason = MPTCP_RST_EMPTCP;
> +		}
> +		return NULL;
> +	}
> +
> +	pernet = mptcp_get_pernet(net);
> +
> +	switch (af) {
> +	case AF_INET:
> +		lsk = pernet->join4.sk;
> +		break;
> +	case AF_INET6:
> +		lsk = pernet->join6.sk;
> +		break;

As kbuild noted, missing an

#if IS_ENABLED(CONFIG_MPTCP_IPV6)

check here.


--
Mat Martineau
Intel
