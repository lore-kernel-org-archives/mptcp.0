Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5AC168
	for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 00:20:49 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="212060589"
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="212060589"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2021 17:20:49 -0700
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="662342498"
Received: from jxu13-mobl.amr.corp.intel.com ([10.209.65.162])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2021 17:20:48 -0700
Date: Mon, 26 Jul 2021 17:20:47 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, Geliang Tang <geliangtang@gmail.com>, 
    Yonglong Li <liyonglong@chinatelecom.cn>
Subject: Re: [PATCH mptcp-next] Squash-to: "mptcp: build ADD_ADDR/echo-ADD_ADDR
 option according pm.add_signal"
In-Reply-To: <4206e5473ed255fa08af48a7b5bc0edd00abb99d.1627047074.git.pabeni@redhat.com>
Message-ID: <7e9eaade-e51a-dbd5-f4c6-94bc91c0dec9@linux.intel.com>
References: <4206e5473ed255fa08af48a7b5bc0edd00abb99d.1627047074.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 23 Jul 2021, Paolo Abeni wrote:

> We don't need to add a 2nd mptcp_addr_info inside out_options:
> it's quite huge and only one of local or remote is used.
>
> revert back to a single 'addr' field.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> include/net/mptcp.h |  3 +--
> net/mptcp/options.c | 13 +++++--------
> net/mptcp/pm.c      |  4 ++--
> 3 files changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index d0b9e4a7121f..8b5af683a818 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -61,8 +61,7 @@ struct mptcp_out_options {
> 	u64 sndr_key;
> 	u64 rcvr_key;
> 	u64 ahmac;
> -	struct mptcp_addr_info local;
> -	struct mptcp_addr_info remote;
> +	struct mptcp_addr_info addr;
> 	struct mptcp_rm_list rm_list;
> 	u8 join_id;
> 	u8 backup;
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 6803de5d4209..eafdb9408f3a 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -665,7 +665,6 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
> 	unsigned int opt_size = *size;
> 	bool echo;
> 	bool port;
> -	u8 family;
> 	int len;
>
> 	if (!mptcp_pm_should_add_signal(msk) ||
> @@ -675,8 +674,7 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
>
> 	if (drop_other_suboptions)
> 		remaining += opt_size;
> -	family = echo ? opts->remote.family : opts->local.family;
> -	len = mptcp_add_addr_len(family, echo, port);
> +	len = mptcp_add_addr_len(opts->addr.family, echo, port);
> 	if (remaining < len)
> 		return false;
>
> @@ -692,11 +690,10 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
> 	if (!echo) {
> 		opts->ahmac = add_addr_generate_hmac(msk->local_key,
> 						     msk->remote_key,
> -						     &opts->local);
> +						     &opts->addr);
> 	}
> -	pr_debug("local_id=%d, local_port=%d, remote_id=%d, remote_port=%d, ahmac=%llu, echo=%d",
> -		 opts->local.id, ntohs(opts->local.port), opts->remote.id,
> -		 ntohs(opts->remote.port), opts->ahmac, echo);
> +	pr_debug("addr_id=%d, addr_port=%d, ahmac=%llu, echo=%d",
> +		 opts->addr.id, ntohs(opts->addr.port), opts->ahmac, echo);
>
> 	return true;
> }
> @@ -1253,7 +1250,7 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
>
> mp_capable_done:
> 	if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
> -		struct mptcp_addr_info *addr = opts->ahmac ? &opts->local : &opts->remote;
> +		struct mptcp_addr_info *addr = &opts->addr;
> 		u8 len = TCPOLEN_MPTCP_ADD_ADDR_BASE;
> 		u8 echo = MPTCP_ADDR_ECHO;
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 692614c1f552..4d1828fd2482 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -282,10 +282,10 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
> 		goto out_unlock;
>
> 	if (*echo) {
> -		opts->remote = msk->pm.remote;
> +		opts->addr = msk->pm.remote;
> 		add_addr = msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_ECHO);
> 	} else {
> -		opts->local = msk->pm.local;
> +		opts->addr = msk->pm.local;
> 		add_addr = msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_SIGNAL);
> 	}
> 	WRITE_ONCE(msk->pm.addr_signal, add_addr);
> -- 
> 2.26.3

I agree that it's worthwhile to keep the size of mptcp_out_options down.

There's already a "!mptcp_pm_should_add_signal()" check earlier in 
mptcp_pm_add_addr_signal(), so I don't see a risk of opts->addr getting 
accidentally clobbered now that the mptcp_addr_info storage is shared 
again.

Looks good to me:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

--
Mat Martineau
Intel
