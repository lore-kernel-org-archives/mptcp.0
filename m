Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795735798;
	b=D/MJP4hpvCzBQmiHmvwU8RG1004k/5HGRwWvlQwf9OcSsnaHPkLZQ/+pGPE8yNs08ptL
	 JA+b6i4eml0Bu0VwM8s3hgHU+IlGe+XwJIs+oJdW48klTjOkNmJ6uidI1SVGsa33tKWA/
	 nhg11/b7NVjPHP9fgd0ifSpYAHbBQQAuM80W1AK2/sj7MEDLXMYgZ/3cl3zfCzGs7p5G8
	 sKHgPelQ4Mz3WMlk30ZyS1xWLu4kcaxxH18vm2wAmR+ohYpkJYC9tAVnfJctpDNK1lbFg
	 TPj3wFKGw7AkgRx8BTfRhLX6a8UgutYFPjsALUiZvNYqO4Or6RKW9qFpf/DsBwKJwxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795735798;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=P7VYUqRvbKp9sW1toZ3pyyDLcBpc3ajBVuccrGOr91c=;
	b=zs5aiZshW8DAnlov39ubiCSQCWdX9T+SnpC41s/sDQUuBEsrdv597KwTysziitKvTE3Z
	 e3snqwYXbrKS3cJhLqAXofWcIVnXiJES0/5fRscFUygzt4I8rDGjb8L8RgHoLFiVnfi5d
	 S4Z1DIcDHKqsHH6QfMuBB55pDbJ/81pUhUzKSOoHhQjJh+QjFy88RKervJicLAI+KQDEK
	 eCQKbDF53GQXsN0ZOOEzecGy6VclAJIBF4foMrG6xjHk1CSNW0HeuImwyK3Iwob9H2zW9
	 cAGfk8NwiZU/OVOo246a2S07nQrg0aVYaFZRpPUYHA7Lljt4W+lmXgIf+SETb51R7rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="R+tZl5/f";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9DC606A31E
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 23:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R+tZl5/f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BFF91F0089C;
	Thu, 26 Nov 2026 23:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795735798;
	bh=P7VYUqRvbKp9sW1toZ3pyyDLcBpc3ajBVuccrGOr91c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=R+tZl5/f9rhb+wtYOIJmEIjwqrApdRyOiWcyIVCrwy0S1msbDeZ5bRfiHg46Kn9Hh
	 RtdZ8lxMfGOY6gL1GBeqsYcPIOYyTMNgwOHZFSO4VsdtY11mFONugj5S0b1dpg8x1K
	 FjmSr9JpNosk8gMjcbM/teZKkhP/bURWiwUKknUUlqWqYbfOvKJ2+ig28u0RKUHZlR
	 JfEpT/8qtlm9FjQOSvlYrUx213sOP0vozRjPY9o5YoR8MS++gxulpFBalH/ynUUA+D
	 W+ie+Gqgaqzy3VUbeBV9+SgYgGB/UKSNi/VpzIwRJWWnHZ0oDSvlia72PS600nociv
	 T0fuveNXPhpdg==
Subject: Re: [PATCH mptcp-net v3 46/50] Squash to "bpf: Export mptcp packet
 scheduler helpers"
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Thu, 26 Nov 2026 23:29:57 +0000
Message-ID: <179573579795.3133.13591447919440768699@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-46-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-46-416c0920c73f@kernel.org>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] mptcp: mptcp_sched_get_send() skips mptcp_set_timeout() on
  scheduled subflow

--

> diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> --- a/net/mptcp/sched.c
> +++ b/net/mptcp/sched.c
> @@ -182,6 +182,10 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
>  		return -EINVAL;
>  	}
>  
> +	/* as the default scheduler: the rtx timer needs an interval */
> +	if (msk->sched && msk->sched != &mptcp_sched_default)
> +		mptcp_set_timeout((struct sock *)msk);
> +
>  	mptcp_for_each_subflow(msk, subflow) {
>  		if (READ_ONCE(subflow->scheduled))
>  			return 0;

[Severity: Medium]
The v3 change covers the already-scheduled case for BPF schedulers
only, but the same early return is taken with the default scheduler
too. In that case mptcp_sched_default_get_send() is not called, so
mptcp_subflow_get_send() does not run. Neither msk->timer_ival nor
msk->snd_burst is refreshed.

Can a subflow keep subflow->scheduled set after all data has been
acked, with msk->timer_ival reset to 0 by mptcp_stop_rtx_timer()? It
looks possible. In ack_update_msk(), __mptcp_check_push() runs before
__mptcp_data_acked(). During recovery, the default scheduler can then
mark and delegate another subflow. Right after that,
__mptcp_clean_una() clears msk->first_pending and stops the timer.

When the delegated action later runs
__mptcp_subflow_push_pending(sk, ssk, true), mptcp_send_head() is
NULL. The loop is skipped, and the scheduled flag is never cleared.

On the next push, mptcp_sched_get_send() then returns 0 with
msk->timer_ival == 0. __subflow_push_pending() can bail out before
its own mptcp_set_timeout() call. That happens if mptcp_sendmsg_frag()
fails, or if msk->snd_burst is <= 0 after the first fragment. In that
case mptcp_reset_rtx_timer() arms the rtx timer with a 0 interval, and
it fires every jiffy. This is the same issue this patch is trying to
fix, only with the default scheduler.

Would it make sense to call mptcp_set_timeout() unconditionally
before the scheduled loop, whatever the scheduler? Or is the stale
scheduled flag the real bug, to be cleared elsewhere?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261124-mptcp-cmason-fixes-v3-0-416c0920c73f%40kernel.org
