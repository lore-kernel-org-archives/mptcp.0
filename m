Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B8170
	for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 00:31:50 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="199523649"
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="199523649"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2021 17:31:49 -0700
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="662344416"
Received: from jxu13-mobl.amr.corp.intel.com ([10.209.65.162])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2021 17:31:48 -0700
Date: Mon, 26 Jul 2021 17:31:48 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH mptcp-next] Squash to "Squash-to: mptcp: build
 ADD_ADDR/echo-ADD_ADDR option according pm.add_signal"
In-Reply-To: <313195dff50905ec809b66b2f195340dd80d68ff.1627219500.git.geliangtang@xiaomi.com>
Message-ID: <e8a07d66-3e27-4423-421f-f836e58cf276@linux.intel.com>
References: <313195dff50905ec809b66b2f195340dd80d68ff.1627219500.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Sun, 25 Jul 2021, Geliang Tang wrote:

> Paolo's patch (Squash-to: "mptcp: build ADD_ADDR/echo-ADD_ADDR option
> according pm.add_signal") reverts back to a single 'addr' field in struct
> mptcp_addr_info.
>
> Then no need to change the argument of mptcp_pm_add_addr_signal and no
> need to modify the code in mptcp_write_options now, the original code is
> fine.
>
> So this patch reverts back more code.
>
> And the commit log needs to be updated:
>
> '''
> According to the MPTCP_ADD_ADDR_SIGNAL or MPTCP_ADD_ADDR_ECHO flag, build
> the ADD_ADDR/ADD_ADDR_ECHO option.
>
> In mptcp_pm_add_addr_signal(), use opts->remote or opts->local to save the
> announced ADD_ADDR or ADD_ADDR_ECHO address.
> '''
>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>

Hi Geliang,

Thanks for the updates to this patch. The result of squashing Paolo's 
patch and yours to the "mptcp: build ADD_ADDR..." patch is much clearer.

As you note here (and in your reply), the commit message also needs some 
work. One more part of that, the commit message should say 
"pm.addr_signal" instead of "pm.add_signal", but that is a separate fix.


Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>



> ---
> net/mptcp/options.c  | 25 ++++++++++++-------------
> net/mptcp/pm.c       |  6 +++---
> net/mptcp/protocol.h |  2 +-
> 3 files changed, 16 insertions(+), 17 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index eafdb9408f3a..cb29a5605776 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -668,7 +668,7 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
> 	int len;
>
> 	if (!mptcp_pm_should_add_signal(msk) ||
> -	    !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, opts,
> +	    !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, &opts->addr,
> 		    &echo, &port, &drop_other_suboptions))
> 		return false;
>
> @@ -692,8 +692,8 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
> 						     msk->remote_key,
> 						     &opts->addr);
> 	}
> -	pr_debug("addr_id=%d, addr_port=%d, ahmac=%llu, echo=%d",
> -		 opts->addr.id, ntohs(opts->addr.port), opts->ahmac, echo);
> +	pr_debug("addr_id=%d, ahmac=%llu, echo=%d, port=%d",
> +		 opts->addr.id, opts->ahmac, echo, ntohs(opts->addr.port));
>
> 	return true;
> }
> @@ -1250,16 +1250,15 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
>
> mp_capable_done:
> 	if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
> -		struct mptcp_addr_info *addr = &opts->addr;
> 		u8 len = TCPOLEN_MPTCP_ADD_ADDR_BASE;
> 		u8 echo = MPTCP_ADDR_ECHO;
>
> #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> -		if (addr->family == AF_INET6)
> +		if (opts->addr.family == AF_INET6)
> 			len = TCPOLEN_MPTCP_ADD_ADDR6_BASE;
> #endif
>
> -		if (addr->port)
> +		if (opts->addr.port)
> 			len += TCPOLEN_MPTCP_PORT_LEN;
>
> 		if (opts->ahmac) {
> @@ -1268,25 +1267,25 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
> 		}
>
> 		*ptr++ = mptcp_option(MPTCPOPT_ADD_ADDR,
> -				      len, echo, addr->id);
> -		if (addr->family == AF_INET) {
> -			memcpy((u8 *)ptr, (u8 *)&addr->addr.s_addr, 4);
> +				      len, echo, opts->addr.id);
> +		if (opts->addr.family == AF_INET) {
> +			memcpy((u8 *)ptr, (u8 *)&opts->addr.addr.s_addr, 4);
> 			ptr += 1;
> 		}
> #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> -		else if (addr->family == AF_INET6) {
> -			memcpy((u8 *)ptr, addr->addr6.s6_addr, 16);
> +		else if (opts->addr.family == AF_INET6) {
> +			memcpy((u8 *)ptr, opts->addr.addr6.s6_addr, 16);
> 			ptr += 4;
> 		}
> #endif
>
> -		if (!addr->port) {
> +		if (!opts->addr.port) {
> 			if (opts->ahmac) {
> 				put_unaligned_be64(opts->ahmac, ptr);
> 				ptr += 2;
> 			}
> 		} else {
> -			u16 port = ntohs(addr->port);
> +			u16 port = ntohs(opts->addr.port);
>
> 			if (opts->ahmac) {
> 				u8 *bptr = (u8 *)ptr;
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 5fe3805af02a..781da0885f98 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -257,7 +257,7 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
>
> bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
> 			      unsigned int opt_size, unsigned int remaining,
> -			      struct mptcp_out_options *opts, bool *echo,
> +			      struct mptcp_addr_info *saddr, bool *echo,
> 			      bool *port, bool *drop_other_suboptions)
> {
> 	int ret = false;
> @@ -286,10 +286,10 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
> 		goto out_unlock;
>
> 	if (*echo) {
> -		opts->addr = msk->pm.remote;
> +		*saddr = msk->pm.remote;
> 		add_addr = msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_ECHO);
> 	} else {
> -		opts->addr = msk->pm.local;
> +		*saddr = msk->pm.local;
> 		add_addr = msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_SIGNAL);
> 	}
> 	WRITE_ONCE(msk->pm.addr_signal, add_addr);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index b54335857b6e..099e3e6a4c89 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -801,7 +801,7 @@ static inline int mptcp_rm_addr_len(const struct mptcp_rm_list *rm_list)
>
> bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
> 			      unsigned int opt_size, unsigned int remaining,
> -			      struct mptcp_out_options *opts, bool *echo,
> +			      struct mptcp_addr_info *saddr, bool *echo,
> 			      bool *port, bool *drop_other_suboptions);
> bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
> 			     struct mptcp_rm_list *rm_list);
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
