Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0847E4EB865
	for <mptcp@lists.linux.dev>; Wed, 14 Oct 2026 18:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792001622; cv=none; b=aXs8KWAb09QtHj+Vq05DsJ+j5gTSRfKcal03eWjFr+bDgyFtF0Yw6OLRQgXWgV32dXV17t63GzgC9cVCPvYiGHRTPfon8aoUUUFB2RGuJEZ/Q83WYdBLjKhTlHDnrGUThf0YoBTJaJ51t/o0KVEOaqRZugaXjllWuYgg3NYfQLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792001622; c=relaxed/simple;
	bh=e7Mmtj71a3m61SGF9rW5RImwANW2Z0HDyt5Cewu/Q7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sETj2QrFF5JKKgZJZwTzvjcD4h25JFLWobsAHNGeppb8k+AY3AhpQNJbzld2ZoO65CKQ+2UuxdcMtIIq1LKq1IYrHN/836vfyQzc0sjNYJePBvMu8CJSrGuz5CeBwdptIfKPCUJ+uWk7nvvJjEtPU+e5TrtHBg33z4E7Yg2+WME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/TfgMUv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/TfgMUv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284A11F000C4;
	Wed, 14 Oct 2026 18:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792001620;
	bh=QdiZ/qIYSVvsEdZWpBXnmy29eWrQyLsz7+9F244+gS8=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=Q/TfgMUvtL8lO1iJuQBb27Xd+sqsx6vvVlv1c4GYEfEYYfoSEDk3sCiFE69FpmpwP
	 E/bU8U6KbPvpJBMs9Wmzh4wXniRn39GedPGpn+CmJh1HE3t2/Re2G/wrFJXt6hNVzD
	 ymhYw/EurGiztt5bF9UWR3lnftreRQGn0FVB7OFFxMfPuFQ2yv2zbESjUxVyYzC4pz
	 VcaooX8nlhh1bTg7Clg+a/Qr2KPmV8fwDzuDO0wjs0nkDR1IDV45AQnJVGeBoMrpE4
	 szQvif+EuxkOStvpZguwGFXhNLZrk2Ke7B7VUFkUrApBR06BoZb9hBg27HubF31+E5
	 K2LmAi5saL/7w==
Message-ID: <b150dde6-05f1-4e7b-9440-360b7ce17eff@kernel.org>
Date: Wed, 14 Oct 2026 20:13:38 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH mptcp-next v3 2/3] mptcp: pm: kernel: retry subflows
 closed after an error
Content-Language: fr
To: Anil Kaushik <anilkaushikwireless@gmail.com>, mptcp@lists.linux.dev
References: <20261014143349.768138-1-anilkaushikwireless@gmail.com>
 <20261014143349.768138-3-anilkaushikwireless@gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20261014143349.768138-3-anilkaushikwireless@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Anil,

Thank you for the new version. Here is a very quick other review, mostly
questions.

Also, please wait for the netdev Sashiko review (24 to 48h) before
sending a new version. You can remove the RFC tag. Ideally, include a
changelog per patch.

On 14/10/2026 16:33, Anil Kaushik wrote:
> With the in-kernel PM, a subflow closed after an error, e.g. a timeout
> when a path silently drops packets, is never re-created, even once the
> path works again. For example, with a main link and a backup link,
> connections move to the backup after an outage but never come back.
> 
> Add an opt-in sysctl, net.mptcp.subflow_retries (0 by default): the

I confirm that it would be better to avoid the sysctl for this in-kernel
PM specific setting. Instead, please add another limit that can be
configured via netlink. Add a sensible default value (what do you
recommend?), but on by default.

By default, I think the kernel tries to establish a connection for 67
seconds.

A (maybe bad?) idea: I wonder if we shouldn't modify icsk_syn_retries
instead: by doing that, we would do only one retry, but with a long
exponential backoff timeout. The config would set this value directly,
with 0 meaning disabled (and not "no retransmission after the retry"). WDYT?

> maximum number of attempts to re-create such a subflow. When TCP closes
> a subflow created by this side after an error, the PM creates a new one
> with the same addresses right away. Its SYN retransmissions space out
> the attempts, so no extra state or timer is needed. If it cannot
> connect, the same socket is used for the next attempt. The number of
> attempts is kept in the subflow context, and counted from scratch once
> a re-created subflow stayed established for a minute. Re-creating the
> initial subflow uses one of the additional subflows allowed by the
> limits.
> 
> Subflows refused by the peer, reset by the peer without the transient
> flag (RFC 8684 section 3.6), aborted locally, or using a removed address
> are not retried.
> 
> A new counter, SubflowRetry, counts the attempts.

I'm not a fan of a MIB counter only for the in-kernel PM. Do we have
other similar ones? We already expose some diag counters per subflow (ss
-Mte), would that work?

> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index d7c5b50b34cc..b3f7f7b2ef84 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -794,6 +794,14 @@ static void mptcp_pm_rm_addr_or_subflow(struct mptcp_sock *msk,
>  			int how = RCV_SHUTDOWN | SEND_SHUTDOWN;
>  			u8 id = subflow_get_local_id(subflow);
>  
> +			/* a dead subflow still waiting to be closed must not
> +			 * be re-created on a removed address
> +			 */
> +			if ((rm_type == MPTCP_MIB_RMADDR &&
> +			     remote_id == rm_id) ||
> +			    (rm_type == MPTCP_MIB_RMSUBFLOW && id == rm_id))
> +				subflow->retries = MPTCP_SUBFLOW_NO_RETRY;

Is it specific for your case?

BTW, it would be interesting to test cases where the right actions are
taken when a subflow is disconnected or it is trying to reconnect, e.g.
closing the socket, etc. Maybe easier with Packetdrill to get the right
timing? (or extend the existing test to end with a drop, then close the
connetion

Also we should (manually?) check the right netlink events are being
sent, e.g. not having a "closed subflow" event if the subflow wasn't
established before (but we are probably already doing the right thing
there, just to be sure, I didn't check). I guess your current test can
also check the netlink events.

>  			if ((1 << inet_sk_state_load(ssk)) &
>  			    (TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 | TCPF_CLOSING | TCPF_CLOSE))
>  				continue;
> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index d3014bf57bf3..d020e5f69c01 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -1591,6 +1591,151 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
>  	return true;
>  }
>  
> +/* a re-created subflow reset sooner counts as a failed attempt */
> +#define MPTCP_PM_RETRY_STABLE	(60 * HZ)

That feels "fragile" (e.g. with net.ipv4.tcp_syn_retries=0): can we not
check why it failed instead?

> +static bool mptcp_pm_retry_path_error(int err)
> +{
> +	switch (err) {
> +	case ETIMEDOUT:
> +	case EHOSTUNREACH:
> +	case ENETUNREACH:
> +	case EHOSTDOWN:
> +	case ENETDOWN:

Out-of-curiosity: what error do you get when the issue is detected via
TCP Keeplive?

> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +/* A subflow initiated by this side and closed by TCP after an error can be
> + * re-created with the same addresses, see the 'subflow_retries' sysctl. The
> + * SYN retransmissions of the new subflow space out the attempts. Called with
> + * the msk socket lock held, before the subflow is closed.
> + */

(probably only the last sentence is useful)

> +bool mptcp_pm_kernel_retry_check(struct mptcp_sock *msk,
> +				 const struct mptcp_subflow_context *subflow,
> +				 struct mptcp_pm_retry *retry)
> +{
> +	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +	bool established = READ_ONCE(subflow->fully_established);
> +	struct sock *sk = (struct sock *)msk;
> +	int err = READ_ONCE(ssk->sk_err);
> +
> +	if (!mptcp_pm_is_kernel(msk) || !err ||
> +	    sk->sk_state != TCP_ESTABLISHED || __mptcp_check_fallback(msk))
> +		return false;
> +
> +	/* mptcp_close_ssk() will not handle it again, e.g. the initial
> +	 * subflow, kept in the list once closed
> +	 */
> +	if (subflow->close_event_done || READ_ONCE(subflow->local_id) < 0)
> +		return false;
> +
> +	/* removed address, see mptcp_pm_rm_addr_or_subflow() */
> +	if (subflow->retries == MPTCP_SUBFLOW_NO_RETRY)
> +		return false;
> +
> +	/* The peer asked not to use this path again (MP_RST without the T
> +	 * flag), the subflow has been aborted locally, or it hit an MPTCP
> +	 * protocol error.
> +	 */
> +	if ((subflow->reset_seen && !subflow->reset_transient) ||
> +	    err == ECONNABORTED || err == EBADMSG)
> +		return false;
> +
> +	/* A subflow that never got established is retried only after network
> +	 * errors: if the peer rejected it, trying again will not help.
> +	 */
> +	if (!established && !mptcp_pm_retry_path_error(err))
> +		return false;
> +
> +	/* Only re-create subflows initiated by this side: MP_JOIN ones, or the
> +	 * initial one on the client side.
> +	 */
> +	if (!subflow->request_join &&
> +	    (subflow->mp_join || READ_ONCE(msk->pm.server_side)))
> +		return false;
> +
> +	/* Count the attempts from scratch only if the path worked for a
> +	 * while: a re-created subflow reset soon after its creation counts
> +	 * as a failed attempt.
> +	 */
> +	retry->retries = subflow->retries;
> +	if (established &&
> +	    (!subflow->retries ||
> +	     (u32)(tcp_jiffies32 - subflow->retry_stamp) >=
> +	     MPTCP_PM_RETRY_STABLE))
> +		retry->retries = 0;
> +	/* a failed attempt is retried with the same socket */
> +	retry->reuse = !established && subflow->retries;

Why can we not always re-used?

If we cannot always do that, maybe we should always re-create one? It
might be better to avoid having multiple paths for that in the code.

> +	if (retry->retries >= mptcp_subflow_retries(sock_net(sk)))
> +		return false;
> +
> +	mptcp_remote_address((struct sock_common *)ssk, &retry->remote);
> +	retry->remote.id = READ_ONCE(subflow->remote_id);
> +	if (!retry->remote.id && READ_ONCE(msk->pm.remote_deny_join_id0))
> +		return false;
> +
> +	mptcp_local_address((struct sock_common *)ssk, &retry->local.addr);
> +	retry->local.addr.port = 0;
> +	retry->local.addr.id = subflow_get_local_id(subflow);
> +	retry->local.flags = subflow->request_bkup ?
> +			     MPTCP_PM_ADDR_FLAG_BACKUP : 0;
> +	retry->local.ifindex = ssk->sk_bound_dev_if;
> +
> +	return true;
> +}
> +
> +/* Called with the msk socket lock held, instead of closing the subflow */
> +bool mptcp_pm_kernel_retry_reconnect(struct mptcp_sock *msk, struct sock *ssk,
> +				     const struct mptcp_pm_retry *retry)
> +{
> +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> +	struct sock *sk = (struct sock *)msk;
> +
> +	/* like mptcp_close_ssk() does for the failed attempt */
> +	mptcp_event(MPTCP_EVENT_SUB_CLOSED, msk, ssk, GFP_KERNEL);
> +
> +	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_SUBFLOWRETRY);
> +	if (mptcp_subflow_reconnect(sk, ssk, &retry->local, &retry->remote))
> +		return false;
> +
> +	/* the reset cleared them */
> +	subflow->retries = retry->retries + 1;
> +	subflow->retry_stamp = tcp_jiffies32;
> +	return true;
> +}
> +
> +/* Called with the msk socket lock held, after the subflow has been closed */
> +void mptcp_pm_kernel_retry(struct mptcp_sock *msk,
> +			   const struct mptcp_pm_retry *retry)

Yes, probably better to avoid having both retry_reconnect and retry.

> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct sock *sk = (struct sock *)msk;
> +	bool allowed;
> +
> +	spin_lock_bh(&msk->pm.lock);
> +	allowed = msk->pm.extra_subflows <
> +		  mptcp_pm_get_limit_extra_subflows(msk);
> +	if (allowed)
> +		msk->pm.extra_subflows++;
> +	spin_unlock_bh(&msk->pm.lock);
> +
> +	if (!allowed)
> +		return;
> +
> +	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_SUBFLOWRETRY);
> +	if (__mptcp_subflow_connect(sk, &retry->local, &retry->remote))
> +		return;
> +
> +	/* the new subflow is the last one: it carries the number of attempts */
> +	subflow = list_last_entry(&msk->conn_list, struct mptcp_subflow_context,
> +				  node);
> +	subflow->retries = retry->retries + 1;
> +	subflow->retry_stamp = tcp_jiffies32;
> +}
> +
>  /* Called under PM lock */
>  void __mptcp_pm_kernel_worker(struct mptcp_sock *msk)
>  {
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 60cbd91be632..f29cfd2ad69b 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2816,6 +2816,8 @@ static void __mptcp_close_subflow(struct sock *sk)
>  	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
>  		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
>  		int ssk_state = inet_sk_state_load(ssk);
> +		struct mptcp_pm_retry retry;
> +		bool do_retry;
>  
>  		if (ssk_state != TCP_CLOSE &&
>  		    (ssk_state != TCP_CLOSE_WAIT ||
> @@ -2827,7 +2829,14 @@ static void __mptcp_close_subflow(struct sock *sk)
>  		if (!skb_queue_empty_lockless(&ssk->sk_receive_queue))
>  			continue;
>  
> +		do_retry = mptcp_pm_kernel_retry_check(msk, subflow, &retry);
> +		if (do_retry && retry.reuse &&
> +		    mptcp_pm_kernel_retry_reconnect(msk, ssk, &retry))
> +			continue;
> +
>  		mptcp_close_ssk(sk, ssk, subflow);
> +		if (do_retry && !retry.reuse)
> +			mptcp_pm_kernel_retry(msk, &retry);

Avoid calling in-kernel specific functions directly: it should be done
via the PM "interface". IOW, call something in pm.c, which would call
the in-kernel function if this pm is being used.

(later, we should do that via a pm ops, but we are not there yet --
still best to avoid calling pm kernel functions directly here in all
conditions)


>  	}
>  
>  }
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index ed2f363bb915..1aa92c9614cd 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -622,6 +622,8 @@ struct mptcp_subflow_context {
>  	u8	reset_transient:1;
>  	u8	reset_reason:4;
>  	u8	stale_count;	    /* Protected by the msk socket lock */
> +	u8	retries;	    /* re-creation attempts, msk socket lock */
> +	u32	retry_stamp;	    /* creation of a re-created subflow */

Probably best not to add that between stale_count and stale + avoid
creating new "holes" in structures (I didn't check with pahole, but I
guess that's the case)

>  	u8	stale;		    /* Protected by the msk socket lock,
>  				     * if set the subflow is unable to snd/rcv
>  				     * data, the schedule should skip it
> @@ -818,6 +820,7 @@ int mptcp_is_checksum_enabled(const struct net *net);
>  int mptcp_allow_join_id0(const struct net *net);
>  unsigned int mptcp_stale_loss_cnt(const struct net *net);
>  unsigned int mptcp_close_timeout(const struct sock *sk);
> +u8 mptcp_subflow_retries(const struct net *net);
>  int mptcp_get_pm_type(const struct net *net);
>  const char *mptcp_get_path_manager(const struct net *net);
>  const char *mptcp_get_scheduler(const struct net *net);
> @@ -859,6 +862,9 @@ void mptcp_remote_address(const struct sock_common *skc,
>  			  struct mptcp_addr_info *addr);
>  
>  /* called with sk socket lock held */
> +int mptcp_subflow_reconnect(struct sock *sk, struct sock *ssk,
> +			    const struct mptcp_pm_local *local,
> +			    const struct mptcp_addr_info *remote);
>  int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_local *local,
>  			    const struct mptcp_addr_info *remote);
>  int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
> @@ -1258,6 +1264,24 @@ void __init mptcp_pm_userspace_register(void);
>  void __init mptcp_pm_nl_init(void);
>  void mptcp_pm_worker(struct mptcp_sock *msk);
>  void __mptcp_pm_kernel_worker(struct mptcp_sock *msk);
> +
> +/* subflow->retries value preventing any re-creation */
> +#define MPTCP_SUBFLOW_NO_RETRY	U8_MAX
> +
> +struct mptcp_pm_retry {
> +	struct mptcp_pm_local	local;
> +	struct mptcp_addr_info	remote;
> +	u8			retries;
> +	bool			reuse;	/* failed attempt: same socket */
> +};
> +
> +bool mptcp_pm_kernel_retry_check(struct mptcp_sock *msk,
> +				 const struct mptcp_subflow_context *subflow,
> +				 struct mptcp_pm_retry *retry);
> +void mptcp_pm_kernel_retry(struct mptcp_sock *msk,
> +			   const struct mptcp_pm_retry *retry);
> +bool mptcp_pm_kernel_retry_reconnect(struct mptcp_sock *msk, struct sock *ssk,
> +				     const struct mptcp_pm_retry *retry);
>  u8 mptcp_pm_get_endp_signal_max(const struct mptcp_sock *msk);
>  u8 mptcp_pm_get_endp_subflow_max(const struct mptcp_sock *msk);
>  u8 mptcp_pm_get_endp_laminar_max(const struct mptcp_sock *msk);
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 78e886b20258..0cdeae4b45fa 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1766,6 +1766,69 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_local *local,
>  	return err;
>  }
>  
> +/* Connect again an MPJ subflow that failed to connect, with the same socket.
> + * The subflow never carried data: like for the initial subflow in
> + * __mptcp_subflow_disconnect(), resetting the TCP and the subflow states is
> + * enough. Called with the msk socket lock held.
> + */
> +int mptcp_subflow_reconnect(struct sock *sk, struct sock *ssk,
> +			    const struct mptcp_pm_local *local,
> +			    const struct mptcp_addr_info *remote)
> +{
> +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> +	struct sockaddr_unsized *uaddr;
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct sockaddr_storage addr;
> +	u32 remote_token;
> +	int addrlen;
> +	int err;
> +
> +	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
> +	err = tcp_disconnect(ssk, 0);
> +	if (err)
> +		goto out;
> +
> +	mptcp_subflow_ctx_reset(subflow);
> +	subflow->request_mptcp = 0;
> +	do {
> +		subflow->local_nonce = get_random_u32();
> +	} while (!subflow->local_nonce);
> +	subflow_set_local_id(subflow, local->addr.id);
> +	subflow->remote_key_valid = 1;
> +	subflow->remote_key = READ_ONCE(msk->remote_key);
> +	subflow->local_key = READ_ONCE(msk->local_key);
> +	subflow->token = msk->token;
> +	mptcp_crypto_key_sha(subflow->remote_key, &remote_token, NULL);
> +	subflow->remote_token = remote_token;
> +	WRITE_ONCE(subflow->remote_id, remote->id);
> +	subflow->request_join = 1;
> +	subflow->request_bkup = !!(local->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
> +	subflow->subflow_id = msk->subflow_id++;
> +
> +	mptcp_info2sockaddr(remote, &addr, ssk->sk_family);
> +	addrlen = sizeof(struct sockaddr_in);
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +	if (addr.ss_family == AF_INET6)
> +		addrlen = sizeof(struct sockaddr_in6);
> +#endif
> +	uaddr = (struct sockaddr_unsized *)&addr;
> +
> +	/* like __inet_stream_connect() for __mptcp_subflow_connect() */
> +	if (BPF_CGROUP_PRE_CONNECT_ENABLED(ssk)) {
> +		err = ssk->sk_prot->pre_connect(ssk, uaddr, addrlen);
> +		if (err)
> +			goto out;
> +	}
> +
> +	err = ssk->sk_prot->connect(ssk, uaddr, addrlen);
> +
> +out:
> +	release_sock(ssk);
> +	MPTCP_INC_STATS(sock_net(sk), err ? MPTCP_MIB_JOINSYNTXCONNECTERR :
> +					    MPTCP_MIB_JOINSYNTX);
> +	return err;
> +}

This might not be used if we always call close_subflow then connect, but
in general: avoid this bunch of duplicated code. Here you could extract
code from the normal connect case and call that from here instead of
re-written with a different way (i.e. not calling kernel_connect()).

> +
>  void __mptcp_inherit_memcg(struct sock *sk, struct sock *ssk, gfp_t gfp)
>  {
>  	/* Only if the msk has been accepted already (and not orphaned).*/

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

