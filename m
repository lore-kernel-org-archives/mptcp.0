Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7A82F28
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 01:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644369892; x=1675905892;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7M/UAbpdbpsYbLYmxsRECdIvzGXMwe0TLZEfkHvxeuw=;
  b=iUCP/N+LhqxGIe+0rWz37SZOeiYEs6Mw68Lv8jp+OWYkYA1Gf7nixVOL
   O+7nSf0kAMlWd35/4X+OTQVAPsZRS3EMysZHhQlPl7rbuR4t9ykgN7ex+
   uHeDrY8atqtPziLhNaf0hsoFdxzYZpbqz02QVwqrAHpDsnzEZkwMKsPMl
   DbOX+v4xTPfWJLKQ10FyvO0pv708LMNDrT42RVZ8/KtaJx9fQBCa8ED3c
   XRvHSRqvBdoGvT7bHtmQsrvqaIfdg11AuVzLxwISS3Kf1CXWFfbMBvjIa
   mkX09E3MaD0SecrIUMaFzMpRak3rPAbaR1zZ18DXlf/bhCzSfEI9k8913
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="335496104"
X-IronPort-AV: E=Sophos;i="5.88,354,1635231600"; 
   d="scan'208";a="335496104"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 17:24:51 -0800
X-IronPort-AV: E=Sophos;i="5.88,354,1635231600"; 
   d="scan'208";a="622100084"
Received: from tonysun-mobl.amr.corp.intel.com ([10.212.141.113])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 17:24:51 -0800
Date: Tue, 8 Feb 2022 17:24:51 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 2/4] mptcp: add echo bit in mptcp_addr_info
In-Reply-To: <e3236d76eae1f61afd43bcb1ad08f79f859bddb4.1644318561.git.geliang.tang@suse.com>
Message-ID: <73f36b8-62ed-8f99-8f6f-aee66d86a4@linux.intel.com>
References: <cover.1644318561.git.geliang.tang@suse.com> <e3236d76eae1f61afd43bcb1ad08f79f859bddb4.1644318561.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 8 Feb 2022, Geliang Tang wrote:

> The echo bit is one of the important properties of a MPTCP address. It
> makes sense to put it into struct mptcp_addr_info with others properties
> like the address family, the id number and the port number too.
>

It seems to me that keeping 'echo' in struct mptcp_options_received or 
passed to the various functions is better. struct mptcp_addr_info is used 
in other places where 'echo' isn't needed, and it's a bit of information 
that's useful only at rx or tx time and not something to store 
permanently.

I'd prefer to drop patches 2-4.

-Mat


> This patch added the echo bit in struct mptcp_addr_info. Use this instead
> of using the struct member echo in struct mptcp_options_received.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> include/net/mptcp.h  |  3 ++-
> net/mptcp/options.c  | 16 +++++++++-------
> net/mptcp/protocol.h |  1 -
> 3 files changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 8b1afd6f5cc4..53f66e1ca4fc 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -48,7 +48,8 @@ struct mptcp_rm_list {
>
> struct mptcp_addr_info {
> 	u8			id;
> -	sa_family_t		family;
> +	u8			echo:1,
> +				family:4;
> 	__be16			port;
> 	union {
> 		struct in_addr	addr;
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 4e516e88ab88..4070a9104386 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -234,8 +234,8 @@ static void mptcp_parse_option(const struct sk_buff *skb,
> 		break;
>
> 	case MPTCPOPT_ADD_ADDR:
> -		mp_opt->echo = (*ptr++) & MPTCP_ADDR_ECHO;
> -		if (!mp_opt->echo) {
> +		mp_opt->addr.echo = (*ptr++) & MPTCP_ADDR_ECHO;
> +		if (!mp_opt->addr.echo) {
> 			if (opsize == TCPOLEN_MPTCP_ADD_ADDR ||
> 			    opsize == TCPOLEN_MPTCP_ADD_ADDR_PORT)
> 				mp_opt->addr.family = AF_INET;
> @@ -283,13 +283,14 @@ static void mptcp_parse_option(const struct sk_buff *skb,
> 			}
> 		}
> #endif
> -		if (!mp_opt->echo) {
> +		if (!mp_opt->addr.echo) {
> 			mp_opt->ahmac = get_unaligned_be64(ptr);
> 			ptr += 8;
> 		}
> 		pr_debug("ADD_ADDR%s: id=%d, ahmac=%llu, echo=%d, port=%d",
> 			 (mp_opt->addr.family == AF_INET6) ? "6" : "",
> -			 mp_opt->addr.id, mp_opt->ahmac, mp_opt->echo, ntohs(mp_opt->addr.port));
> +			 mp_opt->addr.id, mp_opt->ahmac,
> +			 mp_opt->addr.echo, ntohs(mp_opt->addr.port));
> 		break;
>
> 	case MPTCPOPT_RM_ADDR:
> @@ -945,7 +946,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
> 	}
>
> 	if (((mp_opt->suboptions & OPTION_MPTCP_DSS) && mp_opt->use_ack) ||
> -	    ((mp_opt->suboptions & OPTION_MPTCP_ADD_ADDR) && !mp_opt->echo)) {
> +	    ((mp_opt->suboptions & OPTION_MPTCP_ADD_ADDR) && !mp_opt->addr.echo)) {
> 		/* subflows are fully established as soon as we get any
> 		 * additional ack, including ADD_ADDR.
> 		 */
> @@ -1076,7 +1077,7 @@ static bool add_addr_hmac_valid(struct mptcp_sock *msk,
> {
> 	u64 hmac = 0;
>
> -	if (mp_opt->echo)
> +	if (mp_opt->addr.echo)
> 		return true;
>
> 	hmac = add_addr_generate_hmac(msk->remote_key,
> @@ -1129,7 +1130,8 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
>
> 		if ((mp_opt.suboptions & OPTION_MPTCP_ADD_ADDR) &&
> 		    add_addr_hmac_valid(msk, &mp_opt)) {
> -			if (!mp_opt.echo) {
> +			if (!mp_opt.addr.echo) {
> +				mp_opt.addr.echo = 1;
> 				mptcp_pm_add_addr_received(msk, &mp_opt.addr);
> 				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
> 			} else {
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 0eebfc9f39bc..4becac89a4a6 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -151,7 +151,6 @@ struct mptcp_options_received {
> 		mpc_map:1,
> 		reset_reason:4,
> 		reset_transient:1,
> -		echo:1,
> 		backup:1,
> 		deny_join_id0:1,
> 		__unused:2;
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
