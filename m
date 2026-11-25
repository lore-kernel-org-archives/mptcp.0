Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795569583;
	b=IzxbXmc9hthxk7JoeMjXcRsMAqFdmrhsm9KBGvBqI/mdzGZ/ZG6ibdHMOyxCKTlLK8JK
	 apP6LGCZ9DEoBjFP+u+V5Tg6FkxjTUsmUwjOJoVPXRJrK2oUDl7sRvgP3PIe8CAhe9JaP
	 RbJ/cb5kFCpZ4Q8MRH9aFr4P9L2dshQULuw001go62QOiWAyLcre9t0KPa7yjFlWjIjv5
	 qO3NPRKfHURMpqkn0zxE0OWVJbWHcSuJvWZHOEhLtfXm+Pq4hpWjdMqXQCd+xrJoHQE8X
	 XaYQu8cfVWxuMDaiQsg6bp6pshZa0hy1hiIidTME0vNsDGo3cmfGhOiufaF3IeLHRHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795569583;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=cO0gq1divFpBoIZSpdvR5/SVI9qDnGq/ykzG8Zd7MRU=;
	b=OEHi+fX5zgSTeJ5f74W7mIj7leWDA8tloMvV0Md9VkuP9bTlss2UW1VkY0zdPBQ2Nx83
	 WvuWc3Hqu72la2OMs9IZkXLLNBOCcAifZiQ5IQUv+KOk+McpbU8Zn+a0gwevRm7YCxV3I
	 OnrE/Z2bp5jz9ZBBaJMtzkEAIxtcn11URnuD+Fh/7D5o3hR7ZKzEY8+oEP3ROrLBT/nxV
	 L7Q7VB+JRGQE2ZyWNriWDIlVbYjMCGaTlNQNmd/DcEavAn6pk9dALet2ylJQ0Lm5O7Cn3
	 O0dMJWNer2NespSVJ2Up34CDDmWWKaxsfGwxc0HDumVV7h+wsqeeOVhuRH854qHyp5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fzAMs8UJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16D4606A31E
	for <mptcp@lists.linux.dev>; Wed, 25 Nov 2026 01:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fzAMs8UJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A926C1F000C4;
	Wed, 25 Nov 2026 01:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795569583;
	bh=cO0gq1divFpBoIZSpdvR5/SVI9qDnGq/ykzG8Zd7MRU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=fzAMs8UJ64yMO4vFhCvh7T+qVSKWXlFXWctSsbnb+VVYBUGAZPHp4ZDLmIZ9085fR
	 FF2WWEVVjsxqGeO0/ZlnylPQNkQuP9roMwpfO21vBXXhXEaGKohciB1jCfptfRGgfe
	 rJynwTg384FsZE/6ieUOKcXiM0GJlXy29pJbxnAgA97Yq9qghrOd+C9A4ZAMFfWVfy
	 Fkj9pT08lbmFhgjlTOmeVEDfb0EVCcpaPgceSguGLDeXy02bH/nqlnTIUI2zeuf30f
	 Bxg9N+Prhdd/N9LYkAWqv2Ah35Bz57rAnMV+e4SyYkQYrQFSYNbIp317lg3Q8Kq8+z
	 cOAZptMizf1zw==
Date: Tue, 24 Nov 2026 17:19:43 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: MPTCP Linux <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-net v3 02/50] mptcp: limit an orphan probing a zero
 window
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-2-416c0920c73f@kernel.org>
Message-ID: <0be81ccc-8d01-19d7-53af-6538924a05bc@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org> <20261124-mptcp-cmason-fixes-v3-2-416c0920c73f@kernel.org>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 24 Nov 2026, Matthieu Baerts (NGI0) wrote:

> Since the previous commit, an orphan with data to send is kept while
> the peer acks something, at least the window probes: a peer keeping its
> window closed, e.g. not reading, could then keep the orphan forever.
>
> TCP limits this for its orphans: tcp_probe_timer() aborts them instead
> of probing again after the max interval. The subflows of an MPTCP orphan
> are not orphaned: they probe again then, and back off once more, up to
> tcp_retries2. So check if TCP would have aborted them, when the close
> timeout expires. Same with data in flight, when the peer has shrunk its
> window to zero: tcp_retransmit_timer() only aborts orphans then.
>
> Two corner cases needing non-default settings are not covered, which is
> fine: an idle subflow refreshed by keepalives still keeps the orphan
> when the stale detection is disabled, and tcp_orphan_retries is ignored.
>
> This was found by an AI code review agent, while reviewing the previous
> commit. With its reproducer and a long pause, the orphan was kept until
> the end of the pause. It is now reset as TCP does, respecting
> tcp_retries2.
>
> Note for the backports: this patch is needed with the previous one, and
> before v6.15, tcp_rto_max() can be replaced by TCP_RTO_MAX.
>
> Fixes: e16163b6e2b7 ("mptcp: refactor shutdown and close")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Mat Martineau <martineau@kernel.org>

> ---
> v2: new, to limit the orphans kept by the previous patch, with the same
>    Fixes tag to backport them together.
>
> Note (Clashiko on v2): a peer acking the data at the TCP level only
> keeps the orphan, but this is bounded by tcp_max_orphans and tcp_mem
> since the next patch. With the stale detection, the probing subflow is
> marked as stale, and its data is moved to the idle one.
> ---
> net/mptcp/protocol.c | 29 ++++++++++++++++++++++++++++-
> 1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 944c9d11d211..ff71f1954077 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2871,6 +2871,32 @@ static bool mptcp_close_tout_expired(const struct sock *sk)
> 		  inet_csk(sk)->icsk_mtup.probe_timestamp + mptcp_close_timeout(sk));
> }
>
> +/* Would TCP abort this subflow if it were an orphan probing a zero window? */
> +static bool mptcp_subflow_probe_timed_out(struct sock *ssk)
> +{
> +	u8 retries2 = READ_ONCE(sock_net(ssk)->ipv4.sysctl_tcp_retries2);
> +	struct inet_connection_sock *icsk = inet_csk(ssk);
> +	const struct tcp_sock *tp = tcp_sk(ssk);
> +	unsigned long limit;
> +	bool slow, ret;
> +	u64 when;
> +
> +	slow = lock_sock_fast_nested(ssk);
> +	limit = tcp_rto_max(ssk);
> +	if (tp->packets_out) {
> +		ret = !tp->snd_wnd && icsk->icsk_rto >= limit;
> +	} else {
> +		if (icsk->icsk_backoff < retries2)
> +			limit *= 2;
> +		/* a shift of 32 already exceeds the limit */
> +		when = (u64)icsk->icsk_rto << min_t(u8, icsk->icsk_backoff, 32);
> +		ret = tcp_send_head(ssk) && when >= limit;
> +	}
> +	unlock_sock_fast(ssk, slow);
> +
> +	return ret;
> +}
> +
> /* Before its DATA_FIN, keep an orphan while a subflow can send its data */
> static bool mptcp_orphan_keep(struct sock *sk)
> {
> @@ -2886,7 +2912,8 @@ static bool mptcp_orphan_keep(struct sock *sk)
> 		/* a live peer acks at least the probes, every TCP_RTO_MAX */
> 		if (__mptcp_subflow_active(subflow) &&
> 		    tcp_jiffies32 - READ_ONCE(tcp_sk(ssk)->rcv_tstamp) <
> -		    2 * TCP_RTO_MAX)
> +		    2 * TCP_RTO_MAX &&
> +		    !mptcp_subflow_probe_timed_out(ssk))
> 			return true;
> 	}
>
>
> -- 
> 2.55.0
>
>
>
