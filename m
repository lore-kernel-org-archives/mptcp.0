Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795560304;
	b=t7NSWPqd2IDE4yHsvk9B9nnX0Xb3vkGRUAkDnxGeowYRwpxT3A+1V1JYt5CRY4uRlN5C
	 8LQfFO8peemnSJo3f1I+7emxrSs5VVUwknXakj62T0sDqyMAy0ruqvEBy3+n7TTbkNRl2
	 tl+SN3DMjSH3dWSddeiP39j0DaYbO0qleCCPa7y9KQInFfCcU/GPlUXJTTVlMd1V0grcj
	 sTYOSo6hJ+hBkA4SksHpcN817kxtHloQLlam/BIdPjm9/Y0DUBW+mZYOKu1R/SzoLj+yG
	 5dsR6oU1uzdzZ0MxFeJ/sVmSV96debxbeVlhduD+yzfgZnzijgtSWPvLQgAhuaAyVag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795560304;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gc+cfHpg14mWCZQ/0GqHFvz/YVfwMgpgRPdz9z7pT4I=;
	b=ywGrd3hgxzWfnKJKHtyB9nnkTaD0nfxG6jf4IwLX54mRZWXzs674IwhuNXCyW/IfpE5A
	 HsYsKKBVy+zroS7g2iPm4IO2FQruDzgMlGIFl1zFNeSjhRn9DQU3hfQCUPXseKyUUpbka
	 +4EeISS2oAScNa17I1Y5l1CJrL3m+J5eFhm91CHA8QKP20hZNfPtFZZR06xGnG3YgST72
	 zbON0BJQEh6g3H4j3Iqk5rk2Jn2X32CFOpAlxo0T7JIxUYHmD2ftieqcn22pZJdSelSty
	 n6+3NSi6MJoPGYMdWC8wXSIxoCFm1Sd0iF6sWybb5TZh5s2LFcL7Lwdlr6Gy+02Fdug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f6EPCCpB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE62606A327
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f6EPCCpB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 750801F000C0;
	Tue, 24 Nov 2026 22:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795560304;
	bh=gc+cfHpg14mWCZQ/0GqHFvz/YVfwMgpgRPdz9z7pT4I=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=f6EPCCpBGCf8N04ons6/IvIwzMQIW6vGZlDej9ANv0VtovBNUqjm5hT1o9zIeDQrx
	 HdA0FSeB/6E73hBWVuR9v6bCE98x2Y3ca0fMxwct5Bcx60kV+NbBmr1ToMqLDAQ7Lx
	 y3nsY+XHAKsyUOstkq0YWGHYHeJhCZuBzLhpRWYYtxEqhHGx9Wf2lcbTdfSqF4YnxD
	 qg9MXtpD8LTQNV72gPYzBf5FH88dL/s1tc9sN1RplDBmx5/2L7HMf0tt660MDakb64
	 b+3c4743CqdGv6QE8Y+yi8WlbeazpiZekwA3lzljPTghwVI6ESEfH2r1PFA/8ZALY6
	 tHOGtk7xehyeg==
Message-ID: <sashiko-outbox-232153@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net v3 46/50] Squash to "bpf: Export mptcp packet
 scheduler helpers"
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>, "MPTCP
 Linux" <mptcp@lists.linux.dev>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-46-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
 <20261124-mptcp-cmason-fixes-v3-46-416c0920c73f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 22:45:04 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] mptcp: mptcp_sched_get_send() skips mptcp_set_timeout() on
  scheduled subflow
--

commit a82acd8ca33d023de6cf973e96c25c49bb5f9fc5
Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Squash to "bpf: Export mptcp packet scheduler helpers"

This commit calls mptcp_set_timeout() in mptcp_sched_get_send() when a
non-default scheduler is configured so that msk->timer_ival is initialized
even if a subflow is already scheduled or the BPF scheduler does not set
the timeout itself.

> diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> index 1e59072d478c9..01500f9f9f8a6 100644
> --- a/net/mptcp/sched.c
> +++ b/net/mptcp/sched.c
> @@ -182,6 +182,10 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
>  		return -EINVAL;
>  	}
> =20
> +	/* as the default scheduler: the rtx timer needs an interval */
> +	if (msk->sched && msk->sched !=3D &mptcp_sched_default)
> +		mptcp_set_timeout((struct sock *)msk);
> +
>  	mptcp_for_each_subflow(msk, subflow) {
>  		if (READ_ONCE(subflow->scheduled))
>  			return 0;
> @@ -189,6 +193,7 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
> =20
>  	if (msk->sched =3D=3D &mptcp_sched_default || !msk->sched)
>  		return mptcp_sched_default_get_send(msk);
> +
>  	return msk->sched->get_send(msk);
>  }

[Severity: Medium]
Does guarding mptcp_set_timeout() with msk->sched !=3D &mptcp_sched_default
still leave msk->timer_ival at 0 when a subflow is already scheduled under
the default scheduler?

With the default scheduler, mptcp_set_timeout() is normally called inside
mptcp_sched_default_get_send() -> mptcp_subflow_get_send().  However, a
subflow can retain subflow->scheduled =3D=3D true after all pending data is
acknowledged and mptcp_stop_rtx_timer() resets msk->timer_ival to 0.  For
example, in ack_update_msk() during recovery, __mptcp_check_push() runs
before __mptcp_data_acked() -> __mptcp_clean_una(): the push can schedule a
second subflow and delegate MPTCP_DELEGATE_SEND right before
__mptcp_clean_una() clears msk->first_pending and stops the rtx timer.
When __mptcp_subflow_push_pending() later runs on that delegated subflow,
mptcp_send_head(sk) is NULL, so the push loop is not entered and
subflow->scheduled is never cleared.

On the next send, mptcp_sched_get_send() skips mptcp_set_timeout() above,
sees READ_ONCE(subflow->scheduled), and returns 0 without calling
mptcp_sched_default_get_send().  If __subflow_push_pending() then exits
before its own mptcp_set_timeout() call (because mptcp_sendmsg_frag() fails
or msk->snd_burst <=3D 0 after the first fragment), mptcp_reset_rtx_timer()
arms the retransmit timer with msk->timer_ival =3D=3D 0, causing it to fire
every jiffy.

Calling mptcp_set_timeout() unconditionally here (or in the early return
when subflow->scheduled is set) would cover the default scheduler as well.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-mptcp-cmas=
on-fixes-v3-0-416c0920c73f@kernel.org?part=3D46
