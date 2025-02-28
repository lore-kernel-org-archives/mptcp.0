Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B75276D38
	for <mptcp@lists.linux.dev>; Fri, 28 Feb 2025 02:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740710020; cv=none; b=FGjOWo7cauEhyG9/5/OX0PrAVd5uB6nJIkje9LZVycL8jgH8SlbDPXOnxZRxPlz5vuZyIYqg2eabkE8EkKf5XNBMHnUiegfD2Adk9Q+KqE/bg2y6gBkRtHVBUW1tzRcgTkg1JwB3sRlamJCyyUPwrxy6TWOLD7vwXSkOOfSmi4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740710020; c=relaxed/simple;
	bh=z/2M3pYxgSVrhcMTO3tHP0iENoDLfwkCirt5nqGSM84=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IUXuPIzPPQ5QTkuwks/heCvac+pkl6luLokXK06VUas2AU7acqa0EdG+kc8Ga5Wic12NTORbXEvsn450rlstFzddV4N7Wr9pKsIO2V9kWrWw07bb8x9sXwvB94tEnmZnZQ+mG/LDaKfi20vUAGtaa2goRwu4StR6Jmx8fF4zP6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdTr07gK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdTr07gK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C437C4CEDD;
	Fri, 28 Feb 2025 02:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740710019;
	bh=z/2M3pYxgSVrhcMTO3tHP0iENoDLfwkCirt5nqGSM84=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=UdTr07gKsRxEbZZB48CxJFFDa61Et/ZZvlBQYBvczuSZXwThzXx6EAoBwfbiruWEG
	 H1TI90qH3q8mpeElP9QTmajtDVm+w0bAZvcp7lcjVyH3YG0Y9/IRd9hF6+w35I5OfD
	 kSEZCBFFJc0i+tK9PqEe3anGc5AnubZZai36VJl3gSahQLU+S/AkQFBDo+7GcK3yJS
	 JCaCOEOET0yunGlzHvUkSJjZCIgc0tci04JS4ZDX4KT6ynAZ7WAy2DvzBMejPfliAP
	 MHBXmq/uJrcPiQmp7Sb3dFbdUJfRwabopkUKhuguvACrsPebCF/fqlkfQeuGynxWjU
	 PEWVptMeg+SAA==
Message-ID: <e8767a0affcd8bb61f8cf66782ac2408fe21a708.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 7/7] mptcp: pm: code reorganisation
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Fri, 28 Feb 2025 10:30:36 +0800
In-Reply-To: <20250227-mptcp-pm-reorg-code-v1-7-cb4677096709@kernel.org>
References: <20250227-mptcp-pm-reorg-code-v1-0-cb4677096709@kernel.org>
	 <20250227-mptcp-pm-reorg-code-v1-7-cb4677096709@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2025-02-27 at 21:08 +0100, Matthieu Baerts (NGI0) wrote:
> Before this patch, the PM code was dispersed in different places:
> 
> - pm.c had common code for all PMs
> 
> - pm_netlink.c was supposed to be about the in-kernel PM, but also
> had
>   exported common helpers, callbacks used by the different PMs, NL
>   events for PM userspace daemon, etc. quite confusing.
> 
> - pm_userspace.c had userspace PM only code, but using specific
>   in-kernel PM helpers
> 
> To clarify the code, a reorganisation is suggested here, only by
> moving
> code around, and small helper renaming to avoid confusions:
> 
> - pm_netlink.c now only contains common PM Netlink code:
>   - PM events: this code was already there
>   - shared helpers around Netlink code that were already there as
> well
>   - shared Netlink commands code from pm.c
> 
> - pm_kernel.c now contains only code that is specific to the in-
> kernel
>   PM. Now all functions are either called from:
>   - pm.c: events coming from the core, when this PM is being used
>   - pm_netlink.c: for shared Netlink commands
>   - mptcp_pm_gen.c: for Netlink commands specific to the in-kernel PM
>   - sockopt.c: for the exported counters per netns
>   - (while at it, two checkpatch warnings have been fixed: remove
>      unneeded return, and the duplicated condition before a kfree())
> 
> - pm.c got many code from pm_netlink.c:
>   - helpers used from both PMs and not linked to Netlink
>   - callbacks used by different PMs, e.g. ADD_ADDR management
>   - some helpers have been renamed to remove the '_nl' prefix, and
> they
>     have been marked as 'static'.
> 
> - protocol.h has been updated accordingly:
>   - some helpers no longer need to be exported
>   - new ones needed to be exported: they have been prefixed if
> needed.
> 
> The code around the PM is now less confusing, which should help for
> the
> maintenance in the long term.
> 
> This will certainly impact future backports, but because other
> cleanups
> have already done recently, and more are coming to ease the addition
> of
> a new path-manager controlled with BPF (struct_ops), doing that now
> seems to be a good time. Also, many issues around the PM have been
> fixed
> a few months ago while increasing the code coverage in the selftests,
> so
> such big reorganisation can be done with more confidence now.
> 
> No behavioural changes intended.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/mptcp/Makefile     |    2 +-
>  net/mptcp/pm.c         |  664 +++++++++++++----
>  net/mptcp/pm_kernel.c  | 1410 +++++++++++++++++++++++++++++++++++
>  net/mptcp/pm_netlink.c | 1917 +++-----------------------------------
> ----------
>  net/mptcp/protocol.h   |   21 +-
>  5 files changed, 2009 insertions(+), 2005 deletions(-)
> 
> diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
> index
> 5dbc37d38d7a4b0779c71e7b291ef83a49e46648..bd72b300a0f68fa862bcae5aa1e
> 1e913f595f315 100644
> --- a/net/mptcp/Makefile
> +++ b/net/mptcp/Makefile
> @@ -3,7 +3,7 @@ obj-$(CONFIG_MPTCP) += mptcp.o
>  
>  mptcp-y := protocol.o subflow.o options.o token.o crypto.o ctrl.o
> pm.o diag.o \
>  	   mib.o pm_netlink.o sockopt.o pm_userspace.o fastopen.o
> sched.o \
> -	   mptcp_pm_gen.o
> +	   mptcp_pm_gen.o pm_kernel.o
>  
>  obj-$(CONFIG_SYN_COOKIES) += syncookies.o
>  obj-$(CONFIG_INET_MPTCP_DIAG) += mptcp_diag.o
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index
> c17828981dd6400b2ed74dd28a95e21f76ed37b9..8b9117abbe7cd22e8770810e9d5
> aeb9ee0e001e6 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -5,12 +5,399 @@
>   */
>  #define pr_fmt(fmt) "MPTCP: " fmt
>  
> -#include <linux/kernel.h>
> -#include <net/mptcp.h>
>  #include "protocol.h"
> -
>  #include "mib.h"
> -#include "mptcp_pm_gen.h"
> +
> +#define ADD_ADDR_RETRANS_MAX	3
> +
> +struct mptcp_pm_add_entry {
> +	struct list_head	list;
> +	struct mptcp_addr_info	addr;
> +	u8			retrans_times;
> +	struct timer_list	add_timer;
> +	struct mptcp_sock	*sock;
> +};
> +
> +/* path manager helpers */
> +
> +bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
> +			   const struct mptcp_addr_info *b, bool
> use_port)
> +{
> +	bool addr_equals = false;
> +
> +	if (a->family == b->family) {
> +		if (a->family == AF_INET)
> +			addr_equals = a->addr.s_addr == b-
> >addr.s_addr;
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +		else
> +			addr_equals = ipv6_addr_equal(&a->addr6, &b-
> >addr6);
> +	} else if (a->family == AF_INET) {
> +		if (ipv6_addr_v4mapped(&b->addr6))
> +			addr_equals = a->addr.s_addr == b-
> >addr6.s6_addr32[3];
> +	} else if (b->family == AF_INET) {
> +		if (ipv6_addr_v4mapped(&a->addr6))
> +			addr_equals = a->addr6.s6_addr32[3] == b-
> >addr.s_addr;
> +#endif
> +	}
> +
> +	if (!addr_equals)
> +		return false;
> +	if (!use_port)
> +		return true;
> +
> +	return a->port == b->port;
> +}
> +
> +void mptcp_remote_address(const struct sock_common *skc,
> +			  struct mptcp_addr_info *addr)
> +{
> +	addr->family = skc->skc_family;
> +	addr->port = skc->skc_dport;
> +	if (addr->family == AF_INET)
> +		addr->addr.s_addr = skc->skc_daddr;
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +	else if (addr->family == AF_INET6)
> +		addr->addr6 = skc->skc_v6_daddr;
> +#endif
> +}

nit: remote_address() is after mptcp_local_address() in pm_netlink.c,
how about keeping this order after moving here?

> +
> +void mptcp_local_address(const struct sock_common *skc,
> +			 struct mptcp_addr_info *addr)
> +{
> +	addr->family = skc->skc_family;
> +	addr->port = htons(skc->skc_num);
> +	if (addr->family == AF_INET)
> +		addr->addr.s_addr = skc->skc_rcv_saddr;
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +	else if (addr->family == AF_INET6)
> +		addr->addr6 = skc->skc_v6_rcv_saddr;
> +#endif
> +}
> +
> 
... ...

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index
> 8742527196887598eb242c82f06004107d29ef92..380b61be4cf65bc42f791bf2254
> c8a2b4aa333fe 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -729,7 +729,10 @@ void mptcp_set_state(struct sock *sk, int
> state);
>  
>  bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
>  			   const struct mptcp_addr_info *b, bool
> use_port);
> -void mptcp_local_address(const struct sock_common *skc, struct
> mptcp_addr_info *addr);
> +void mptcp_remote_address(const struct sock_common *skc,
> +			  struct mptcp_addr_info *addr);
> +void mptcp_local_address(const struct sock_common *skc,
> +			 struct mptcp_addr_info *addr);

Same here.

Thanks,
-Geliang

>  
>  /* called with sk socket lock held */

