Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794963947;
	b=nY/vzvth6V7HUnIt37dHCEb2u4fnuGTA/E+SJKWHun4O4XcqxEq9c4mnCnvlQoQh/XG8
	 hqJTs18s1taO2aHxgeqlgKdBY/E5K/z0JqP6tTyDiYDN457o+I6B2R2Rv4WiB4bMV+jLW
	 c9wsfiO26F4F792QwOsDXfznOr8x96G5p+vZnCQn63GI9ugA8xU77TI5fUeRRRdcmm4z+
	 2+kfE4wtvYsuDY2vd4+E86GzU9dWJsGocMUxizUKl/NBkRmYuNBVY/WfItmRarkRw9TwT
	 nm8E9EnFEG1oYMHilkaFJ7gvyk3D8eRsps55M62Qd8BBBH6bUD2+gwBKomsHjJ2K8nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794963947;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=bCuZddctHOM/V8gM3ibzvbVJWPKAcoK8Qz6+5a3iibw=;
	b=JIf3uCOiknyuvHmKv0Jb5d/hzEsus0CfS6QZ4AwEiMlv1SSOJywi0U8GAYQpUHR29cEZ
	 nqaS1vQam4ZosVEIk/U3Iv9SDIu/5A9otlepBc9HA+DaYGB5m3XAHaIJHbEIE4uDXF/f1
	 6Zr2iKVq6APPfojq9my0rdONNSYmWcgIBIBWyXjc54lWvfie7NQ8ErF8LHaOpw4vd/N0L
	 J1wH+v5UTnX/WKMqofnSRV2OgY+udzkZ1K03S8THDEvo37jEnuZ83nsavUm86//YMeZoW
	 tShDYwvxoyMPqbSzYnfcv4Inurk7ZgQK8xvbBD3bYX1E2XcE6PbKvPq85fOH9EHgPgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cPm/pkK0";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9D2606A31C
	for <mptcp@lists.linux.dev>; Wed, 18 Nov 2026 01:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cPm/pkK0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8121F000C7;
	Wed, 18 Nov 2026 01:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794963947;
	bh=bCuZddctHOM/V8gM3ibzvbVJWPKAcoK8Qz6+5a3iibw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cPm/pkK0LA5ZQCvcSirASzYF1QUnBNMvgCyB3ozUpNz0Bv1hfzRBxmkk6v3gQsNc0
	 1tj0vXZq4T0KGyg7Gh15hTbKof1UyBXqurPa7V+J4bmGbQnH0czFKWK2LzvK2Gt4pV
	 RZKPPAsSq/GwbWCILROScCYajzLtDCRz9gw0cLJIq7FCpeiK95iXUli1LWN5yGt+cA
	 q03BQfkbH6B1iDswCR8l+P8/fqLJmshyDe8NhjOVy6KcjKcVB1GPRrE+WeQr22VZCu
	 w9FNeAiI+M1/uw7K5rdSMqo5Rm0jNL0VcbuF8TW9ZNBb4J+Yo1zP5Q67AVu7MJaHdW
	 YuMZ+b2JLGgyg==
Subject:
 Re: [PATCH mptcp-next v8 5/7] mptcp: track app-limited state in mptcp_sendmsg
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Wed, 18 Nov 2026 01:05:47 +0000
Message-ID: <179496394705.3133.17806116170570871608@kernel.org>
In-Reply-To: <f23d8a957314196249b5ca0e3b36be8bb0a755e2.1794826541.git.geliang@kernel.org>
References: <f23d8a957314196249b5ca0e3b36be8bb0a755e2.1794826541.git.geliang@kernel.org>
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

- [Low] mptcp_rate_check_app_limited() (net/mptcp/protocol.c:2042-2064)
  runs unconditionally from mptcp_sendmsg_locked() (line 2097).

--

mptcp: track app-limited state in mptcp_sendmsg

This commit adds mptcp_rate_check_app_limited(). It walks every subflow
and calls tcp_rate_check_app_limited() under each subflow's socket lock,
unless the MPTCP level still has unsent data or a retransmission pending.
It is called from mptcp_sendmsg_locked() so that BBR and similar
congestion controllers can ignore rate samples taken while the
connection is application-limited.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 83abdf39c4e54..b9d080121f782 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2039,6 +2039,30 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
>  	}
>  }
>  
> +static void mptcp_rate_check_app_limited(struct sock *sk)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct mptcp_subflow_context *subflow;
> +	unsigned long flags, cb_flags;
> +
> +	flags = READ_ONCE(msk->flags);
> +	cb_flags = READ_ONCE(msk->cb_flags);
> +
> +	if (msk->write_seq != msk->snd_nxt || mptcp_send_head(sk) ||
> +	    test_bit(MPTCP_WORK_RTX, &flags) ||
> +	    test_bit(MPTCP_RETRANSMIT, &cb_flags))
> +		return;
> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +		bool slow;
> +
> +		slow = lock_sock_fast_nested(ssk);
> +		tcp_rate_check_app_limited(ssk);
> +		unlock_sock_fast(ssk, slow);
> +	}
> +}

[Severity: Low]
Is this loop acceptable on the sendmsg() fast path?

The early return only happens while MPTCP-level data is still pending.
For request/response, interactive or paced senders, __mptcp_push_pending()
has usually pushed out the previous write by the time the next one
arrives. So write_seq equals snd_nxt, first_pending is NULL and no RTX
flag is set. In that steady state the walk runs on every call.

Each sendmsg() then takes the socket lock of every subflow on conn_list.
That includes backup, stale or idle subflows the scheduler will not use.
This comes on top of the subflow locking that __mptcp_push_pending()
already does for the subflows it schedules.

The other subflow walk on the same path is gated, so it costs nothing
when it is not needed:

net/mptcp/protocol.c:mptcp_rps_record_subflows() {
	if (!rfs_is_needed())
		return;
    ...
}

The new call in mptcp_sendmsg_locked() has no gate:

	/* is sending application-limited? */
	mptcp_rate_check_app_limited(sk);

Could this be gated in a similar way? Other options would be to do the
check in the push path, where the subflow lock is already held, or to
skip subflows that cannot send.

The commit message says:

    The per-subflow locking only occurs
    when the MPTCP send queue is empty, which is the correct scenario to
    mark the connection as application-limited.

For the workloads this patch targets, an empty send queue is the normal
state. Are there any measurements of the added overhead, or of the BBR
benefit?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794826541.git.geliang%40kernel.org
