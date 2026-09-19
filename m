Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00AC33F8B4
	for <mptcp@lists.linux.dev>; Sat, 19 Sep 2026 20:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789849406; cv=none; b=bb8hz25cje+qtcyRjoVYj76oWRefJfCeWlscz9sf1A+DcIu870xycCUMJ9uASut8mnOnGWn9oUTHf2LTB+3M5CWY5QfqG/pSfr2KU9QmnLl5+INZ+vopf/cylswxpY8zfnh7flP+KKQa6rmRRTHea9Mw2dvwAeaUm1HfWzHlVl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789849406; c=relaxed/simple;
	bh=V3wKO5FtLiYdr5sCWaUNjCUTO78IOzieI3u/5/K7RFE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=joZh/tYtBeer01ZFMqjrHHS9sG0nM3vl8GEDfbHaQ0OmMMh/3giZCHzWtFnhS4oePN1KIBPIlfnOeIEuI//7himvMzLzLURiapqTa6jvYJU5bemJON/5T+Yj8cvznQ1k65MMc1T4WLlQ2H0YnoHc2p+mKdQkQJnme542MuA6CN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCtsBRzW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCtsBRzW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50DC81F000FF;
	Sat, 19 Sep 2026 20:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789849404;
	bh=o/d5rNInUzDZKFRQbK91Qz00TpPJwuBPjadnRZr9bH8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hCtsBRzWx0nGMppxsK7WriDHQjUu7awyUkr6WnJMlMcrBxqGgbKiWyyMUglRKH480
	 3Ek3QvuwFcoTv7ByvqWiBZHqwWML1zoKKbuV3MTx4aYLUqgppwqgr+qGqrjdaanMaK
	 pKSQp9NM23hWzFR2UVFeBSxH/WohNZfhJw6vw5q9wmOYsjTnTlexbnS06ljwUddLv4
	 6Ic784xi/0gMDNuFeg+FyUgy5IngVPdt1G8ofaG5vhAWu/xP9p4QWNcIJGml8Ea2JU
	 6lOh3q+nv+RoOS5xXmHZV0U1PE5hUXop+72RFq8ndVNJGtEUVT5jIBEo2bWbiAXeOG
	 eb+BrBnHLsqbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.1.y 1/3] mptcp: consolidate subflow cleanup
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260919201252.2025112-6-matttbe@kernel.org>
References: <20260919201252.2025112-5-matttbe@kernel.org>
 <20260919201252.2025112-6-matttbe@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 20:23:23 +0000
Message-Id: <20260919202324.50DC81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mptcp: socket hang in fallback teardown due to restrictive state c=
hecks
--

commit 56f82de860d8f3b2e8b76eca945e8a61ec848e3a
Author: Paolo Abeni <pabeni@redhat.com>

mptcp: consolidate subflow cleanup

This commit consolidates subflow cleanup actions requiring the worker into a
single helper. It ensures the dummy data FIN creation for fallback sockets =
is
performed only when the TCP receive queue is empty.

Link: https://patch.msgid.link/20250218-net-next-mptcp-rx-path-refactor-v1-=
1-4a47d90d7998@kernel.org

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index d9734bfb7283b..9bbeed6290d7a 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c

[ ... ]

> @@ -1169,8 +1174,18 @@ static void subflow_sched_work_if_closed(struct mp=
tcp_sock *msk, struct sock *ss
>  		    inet_sk_state_load(sk) !=3D TCP_ESTABLISHED)))
>  		return;
> =20
> -	if (skb_queue_empty(&ssk->sk_receive_queue) &&
> -	    !test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
> +	if (!skb_queue_empty(&ssk->sk_receive_queue))
> +		return;
> +
> +	if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
> +		mptcp_schedule_work(sk);
> +
> +	/* when the fallback subflow closes the rx side, trigger a 'dummy'
> +	 * ingress data fin, so that the msk state will follow along
> +	 */
> +	if (__mptcp_check_fallback(msk) && subflow_is_done(ssk) &&
> +	    msk->first =3D=3D ssk &&
> +	    mptcp_update_rcv_data_fin(msk, READ_ONCE(msk->ack_seq), true))
>  		mptcp_schedule_work(sk);
>  }

[Severity: High]
Does this new placement of the fallback dummy FIN logic cause a socket hang
during connection teardown?

In the previous implementation, the dummy FIN injection was executed in
subflow_state_change() regardless of the early returns in
subflow_sched_work_if_closed().

By moving it inside subflow_sched_work_if_closed(), it is now gated by the
restrictive state checks at the top of the function:

	if (likely(ssk->sk_state !=3D TCP_CLOSE &&
		   (ssk->sk_state !=3D TCP_CLOSE_WAIT ||
		    inet_sk_state_load(sk) !=3D TCP_ESTABLISHED)))
		return;

When a local application closes a fallback connection, the msk transitions
to TCP_FIN_WAIT1 or TCP_FIN_WAIT2. If the remote peer then sends a FIN, the
underlying TCP subflow (ssk) transitions to TCP_CLOSING or TCP_TIME_WAIT.
Since the ssk is neither in TCP_CLOSE nor TCP_CLOSE_WAIT, the function
returns early.

Will this skip the fallback dummy FIN injection entirely, leaving the msk
state machine stuck without mptcp_update_rcv_data_fin() and causing
fallback MPTCP sockets to hang indefinitely?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919201252.2025=
112-5-matttbe@kernel.org?part=3D1
