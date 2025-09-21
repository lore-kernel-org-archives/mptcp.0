Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C21182B7
	for <mptcp@lists.linux.dev>; Sun, 21 Sep 2025 00:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758414474; cv=none; b=AV2iTYxxCnjmz/sHGJzJ894NcJ4laF84d+4pXRLoEYtdsY1w8aTZBpH6ODNjt/PuVL/Od8nfZ5ux+kmRQI9amF+cPsKOzq1ugO2jsECmnVKpQF6fwdYB+ZoKBqfY/HzjM9h1wvQ5KSj5oYIqQDzRJlY+YYE/rmibDHfeUVw7emc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758414474; c=relaxed/simple;
	bh=9ijE/N/Fmwg/+tduuK/veAiMZFQQoa5zf0ElzBPD7n0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lm6sFeKK3Hm+rrWS7VJRl4NbbE7GgBaEDblOB87PEAy19k9wCBe6vJzjbUExZBramiIEG3zcC9MkloDpah8zbtAspp7q6G9KMKpPQ/WF1DsBztwBkiJtr2S6iUpsqGElcOb7bmTUZ8XQRbB5AYuoNfq0i0h5hZiNPf2hXUHdboY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dw3g/y1w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dw3g/y1w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716D3C4CEEB;
	Sun, 21 Sep 2025 00:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758414474;
	bh=9ijE/N/Fmwg/+tduuK/veAiMZFQQoa5zf0ElzBPD7n0=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=dw3g/y1wKzvjDDPYzvUaGLJ2SHEPIfykPjn0gnOwwERko63SNIya/yy4xAOl/hxgi
	 2+vtrAKp5kWOI69FiMHh7XApp/P+DKyM5lUqoMTFTBaaVabuTMUuOowzNP8YDa8NXe
	 nl6S5oMZfcV058t640RWWhk0UonDjErZEXb0QFqQQXw3AcsPMMMz4rwL9vOvXqDcXm
	 ie2xpHas2ye3dvDIjMO2KPJfRHG53KYFtE5vHgvVn6ghHg07jmfpBq+vfDG6H0sgi5
	 AMYZ7ir6qst0KHqhDWB5m4UXrJKbCnFs5Mo5MurBDLaUBYWQq39/UJ4+c8U+b6lWw/
	 MptrATWB1hajA==
Message-ID: <db757c9e494d919b4f73f1167571e67a6a94e93f.camel@kernel.org>
Subject: Re: [MPTCP next v3 11/12] mptcp: prevernt __mptcp_move_skbs()
 interfering with the fastpath
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Date: Sun, 21 Sep 2025 08:27:51 +0800
In-Reply-To: <3ee365d367054da93f2532a1727dde3224aa147f.1758296923.git.pabeni@redhat.com>
References: <cover.1758296923.git.pabeni@redhat.com>
	 <3ee365d367054da93f2532a1727dde3224aa147f.1758296923.git.pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2025-09-19 at 17:53 +0200, Paolo Abeni wrote:
> skbs will be left waiting in the subflow only in exceptional cases,
> we want to avoid messing with the fast path by unintentionally
> processing in __mptcp_move_skbs() packets landed into the subflows
> after the last check.
> 
> Use a separate flag to mark delayed skbs and only process subflow
> with such flag set. Also add new mibs to track the exceptional
> events.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

LGTM!

Reviewed-by: Geliang Tang <geliang@kernel.org>
Tested-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> ---
> v1 -> v2:
>   - rebased
> ---
>  net/mptcp/mib.c      |  2 ++
>  net/mptcp/mib.h      |  4 ++++
>  net/mptcp/protocol.c | 40 ++++++++++++----------------------------
>  net/mptcp/protocol.h |  1 +
>  4 files changed, 19 insertions(+), 28 deletions(-)
> 
> diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
> index 6003e47c770a7..ac5ccf81159de 100644
> --- a/net/mptcp/mib.c
> +++ b/net/mptcp/mib.c
> @@ -85,6 +85,8 @@ static const struct snmp_mib mptcp_snmp_list[] = {
>  	SNMP_MIB_ITEM("DssFallback", MPTCP_MIB_DSSFALLBACK),
>  	SNMP_MIB_ITEM("SimultConnectFallback",
> MPTCP_MIB_SIMULTCONNFALLBACK),
>  	SNMP_MIB_ITEM("FallbackFailed", MPTCP_MIB_FALLBACKFAILED),
> +	SNMP_MIB_ITEM("RcvDelayed", MPTCP_MIB_RCVDELAYED),
> +	SNMP_MIB_ITEM("DelayedProcess", MPTCP_MIB_DELAYED_PROCESS),
>  };
>  
>  /* mptcp_mib_alloc - allocate percpu mib counters
> diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
> index 309bac6fea325..f6d0eaea463e5 100644
> --- a/net/mptcp/mib.h
> +++ b/net/mptcp/mib.h
> @@ -88,6 +88,10 @@ enum linux_mptcp_mib_field {
>  	MPTCP_MIB_DSSFALLBACK,		/* Bad or missing DSS */
>  	MPTCP_MIB_SIMULTCONNFALLBACK,	/* Simultaneous connect */
>  	MPTCP_MIB_FALLBACKFAILED,	/* Can't fallback due to msk
> status */
> +	MPTCP_MIB_RCVDELAYED,		/* Data move from subflow is
> delayed due to msk
> +					 * receive buffer full
> +					 */
> +	MPTCP_MIB_DELAYED_PROCESS,	/* Delayed data moved in
> slowpath */
>  	__MPTCP_MIB_MAX
>  };
>  
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 201e6ac5fe631..2a025c0c4ca0c 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -681,13 +681,17 @@ static bool
> __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
>  	tp = tcp_sk(ssk);
>  	do {
>  		int mem = own_msk ? sk_rmem_alloc_get(sk) : sk-
> >sk_backlog.len;
> +		bool over_limit = mem > READ_ONCE(sk->sk_rcvbuf);
>  		u32 map_remaining, offset;
>  		u32 seq = tp->copied_seq;
>  		struct sk_buff *skb;
>  		bool fin;
>  
> -		if (mem > READ_ONCE(sk->sk_rcvbuf))
> +		WRITE_ONCE(subflow->data_delayed, over_limit);
> +		if (subflow->data_delayed) {
> +			MPTCP_INC_STATS(sock_net(sk),
> MPTCP_MIB_RCVDELAYED);
>  			break;
> +		}
>  
>  		/* try to move as much data as available */
>  		map_remaining = subflow->map_data_len -
> @@ -2113,32 +2117,13 @@ static void mptcp_rcv_space_adjust(struct
> mptcp_sock *msk, int copied)
>  	msk->rcvq_space.time = mstamp;
>  }
>  
> -static struct mptcp_subflow_context *
> -__mptcp_first_ready_from(struct mptcp_sock *msk,
> -			 struct mptcp_subflow_context *subflow)
> -{
> -	struct mptcp_subflow_context *start_subflow = subflow;
> -
> -	while (!READ_ONCE(subflow->data_avail)) {
> -		subflow = mptcp_next_subflow(msk, subflow);
> -		if (subflow == start_subflow)
> -			return NULL;
> -	}
> -	return subflow;
> -}
> -
>  static bool __mptcp_move_skbs(struct sock *sk)
>  {
>  	struct mptcp_subflow_context *subflow;
>  	struct mptcp_sock *msk = mptcp_sk(sk);
>  	bool ret = false;
>  
> -	if (list_empty(&msk->conn_list))
> -		return false;
> -
> -	subflow = list_first_entry(&msk->conn_list,
> -				   struct mptcp_subflow_context,
> node);
> -	for (;;) {
> +	mptcp_for_each_subflow(msk, subflow) {
>  		struct sock *ssk;
>  		bool slowpath;
>  
> @@ -2149,23 +2134,22 @@ static bool __mptcp_move_skbs(struct sock
> *sk)
>  		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
>  			break;
>  
> -		subflow = __mptcp_first_ready_from(msk, subflow);
> -		if (!subflow)
> -			break;
> +		if (!subflow->data_delayed)
> +			continue;
>  
>  		ssk = mptcp_subflow_tcp_sock(subflow);
>  		slowpath = lock_sock_fast(ssk);
> -		ret = __mptcp_move_skbs_from_subflow(msk, ssk, true)
> || ret;
> +		ret |= __mptcp_move_skbs_from_subflow(msk, ssk,
> true);
>  		if (unlikely(ssk->sk_err))
>  			__mptcp_error_report(sk);
>  		unlock_sock_fast(ssk, slowpath);
> -
> -		subflow = mptcp_next_subflow(msk, subflow);
>  	}
>  
>  	__mptcp_ofo_queue(msk);
> -	if (ret)
> +	if (ret) {
> +		MPTCP_INC_STATS(sock_net(sk),
> MPTCP_MIB_DELAYED_PROCESS);
>  		mptcp_check_data_fin((struct sock *)msk);
> +	}
>  	return ret;
>  }
>  
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 7bfd4e0d21a8a..a295ce11774ea 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -560,6 +560,7 @@ struct mptcp_subflow_context {
>  	u8	reset_transient:1;
>  	u8	reset_reason:4;
>  	u8	stale_count;
> +	bool	data_delayed;
>  
>  	u32	subflow_id;
>  
