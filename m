Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795735785;
	b=djLU+gflbqk/2+/bzgX92ohg+azuQRKuwq+fPCCH2tDKWsg9FoXYpmL7R2Ny2B9L8/wn
	 tlLKhFgpsfU7g+TWVrbuzzUerIl9MuD2qWDhSApQdhyv3Dds5P7hnXZ4uwrZJh5B+6h5H
	 7sQF5d/1ZX6+myBEEzJ9xKE0zI3nqrW6OJoits8rL7YcYaIu3YTGCmJ+7E6EqeqJhxQvt
	 LPEuL6ipOEHvbb/MJOUrvQcBzz9jXx0+weOeYgaZZtBql5BqeSRjhd5xErQsgXJ14ENOX
	 Ucyrf9vKiA2s8Lb51x0rKsZjWRk3XwXRJIed0FzWNHAATOYi41Vjkb4riTTHc8ul+og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795735785;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=M454SzpApG9TLTWpCi1sF+bd3P07CiUOQaLnIW4tPUU=;
	b=LMi+ra3PWjRY9QPSrMvyHGSQAbFoZwl5EZWQFFlfphHGXEQvxUssp2JOz99CwcRMY/Dp
	 CpL0ImZmEnQp0BycmtBfm1dDW8hdCpZsl+1tz6nEA1I1DGfU6/f3TAKH2FowgSlvNUMIN
	 FsSJSKxS2rQipesQ/tS2+Hpqdo19T7c041OXvjTecn6vw4C/2GveWrLqx9iBYmih7hVg3
	 ZbHzeatf4Mcffc0IrEaOzYNEaAUJlFfFl2SimVrbdq5jW3kx/cPyyQ+8YKnH4TzjyYirh
	 GpCfOLzEkRdYteVhqGz/AfU/CS0KWwja0JlbZpyJpPqOkW8FjKrVJuqQUkNfLwad9Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="IqyH/AWv";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4D1606A31C
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 23:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IqyH/AWv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A341F00893;
	Thu, 26 Nov 2026 23:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795735784;
	bh=M454SzpApG9TLTWpCi1sF+bd3P07CiUOQaLnIW4tPUU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IqyH/AWvdjzJNCocenjuh3HjUUGA+pfNbsO26WpYztmNxKIjOWJlzNxAZIyY+k2T8
	 8yLwHe5j36mRc3msnGY1riMu1fkWwluotv2bO7LdNLTcjuEbJe7ksHIiSMgO4deuhD
	 1d+SeZZOEjqR9ZDbAuTjlSLBWc3aUEnh7GRfE5AT2TcU2QqwDbfTFRA0TCoM9Vt8fI
	 DfTfA8YnjAxvm73GvCwM4nMJpkbTqPtNZEAQiBoSq4TLGWFVdUPFw239bWGSw0MFZB
	 x1XTp8UUWtHY8cIe3tv8yWa4vqhzjzOycgPLohx7dpl9s0pAnYvALQXPdB+zZUbAkc
	 i43r3u6fIIqiQ==
Subject: Re: [PATCH mptcp-net v3 01/50] mptcp: keep an orphan while it can
 send its data
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Thu, 26 Nov 2026 23:29:44 +0000
Message-ID: <179573578410.3133.3353992866154574326@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-1-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-1-416c0920c73f@kernel.org>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] In mptcp_check_send_data_fin() (net/mptcp/protocol.c), this patch
  adds a restart of the close timeout for every orphan when the DATA_FIN…

--

mptcp: keep an orphan while it can send its data

With this patch, an orphaned MPTCP socket is no longer reset when its close
timeout expires while a subflow can still send pending data. The close
timeout is restarted when the DATA_FIN is sent. On expiry, it is also
restarted as long as an active subflow has recently received an ack from
the peer.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/647

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index d64e04245963c..944c9d11d2116 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -3449,6 +3476,10 @@ static void mptcp_check_send_data_fin(struct sock *sk)
>  
>  	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
>  
> +	/* an orphan's close timeout is for the DATA_FIN exchange */
> +	if (sock_flag(sk, SOCK_DEAD))
> +		mptcp_start_tout_timer(sk);
> +

[Severity: Low]
Can this restart cancel the forced expiry that __mptcp_close_ssk() sets when
an orphan's last subflow reaches TCP_CLOSE?

net/mptcp/protocol.c:__mptcp_close_ssk() {
    ...
	if (list_is_singular(&msk->conn_list) && msk->first &&
	    inet_sk_state_load(msk->first) == TCP_CLOSE) {
		if (sock_flag(sk, SOCK_DEAD)) {
			/* let the worker close and destroy the orphan */
			mptcp_set_close_tout(sk, tcp_jiffies32 -
					     (mptcp_close_timeout(sk) + 1));
			mptcp_schedule_work(sk);
    ...
}

mptcp_worker() calls mptcp_pm_worker() and then mptcp_check_send_data_fin()
before any of the mptcp_close_tout_expired() checks.

Take an orphan whose last data was pushed from BH by
__mptcp_subflow_push_pending(). That function only schedules the worker for
the DATA_FIN. Suppose all the data is then acked, and the last subflow is
closed before mptcp_check_send_data_fin() runs, for example:

mptcp_worker()
  mptcp_pm_worker()
    mptcp_pm_rm_addr_or_subflow()  (peer RM_ADDR or local endpoint removal)
      mptcp_close_ssk()
        __mptcp_close_ssk()        <- sets the expired marker
  mptcp_check_send_data_fin()
    mptcp_start_tout_timer()       <- probe_timestamp reset to now

A netlink subflow_destroy or endpoint removal under the msk lock, before
the worker runs, leads to the same result.

In both cases mptcp_close_tout_expired() then returns false. The state is
still FIN_WAIT1 or LAST_ACK rather than TCP_CLOSE, so __mptcp_destroy_sock()
is skipped.

Does the orphan then stay alive with no usable subflow until the close timer
fires, about TCP_TIMEWAIT_LEN later? Before this patch it was destroyed in
the same worker run.

Subflows closed by a peer RST go through __mptcp_close_subflow(). That runs
after mptcp_check_send_data_fin() in the worker, so they don't seem to be
affected.

The note below the --- line mentions this one-time delay. It rejects not
restarting an already expired timeout, because that would reset an orphan
sending its DATA_FIN after a long probing.

Could the timeout be restarted here only when some subflow can still send
(__mptcp_subflow_active()), and the expired marker kept otherwise? In the
long probing case an active subflow exists, so that case would not be
affected.

The new comment ("an orphan's close timeout is for the DATA_FIN exchange")
also doesn't fit this case, because no subflow is left to carry the
DATA_FIN.

The comments in __mptcp_close_ssk() ("let the worker close and destroy the
orphan") also no longer match what happens on this path.

>  	mptcp_for_each_subflow(msk, subflow) {
>  		struct sock *tcp_sk = mptcp_subflow_tcp_sock(subflow);
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261124-mptcp-cmason-fixes-v3-0-416c0920c73f%40kernel.org
