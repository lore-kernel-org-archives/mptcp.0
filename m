Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793488220;
	b=wYEg6UPnWXlENg5ipXJ6gqxs8OncekKkn7+I+Io4VyVu0zIHg75Wbxlo+6X5JnhcbBZi
	 RqIBRPTUtdQYNvxRcWv51PthsaTYVPGgxYsv7DostSVwTDP1SQI6h88ZDmuxNydgxWDDI
	 kj5+tnpXFHV+UjQYWvuq5jIhFmNrY7bYcN2wm+chQWJXxAi57Gd1KUYmHBDsFp+xKIv0N
	 rd17TJlS9luXUtX4mx/v8JgBEDxET0h+PHoOXjx8CCuIlFEZxcajaSdZDYcjETSj6yOt1
	 zF73q75QpKBNPdJ7pRtZQmVC8PhZFPsa/l2cIgDqxstN3K3iSduZgm+NIJC2M8OsSAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793488220;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iXhC5kk5eUmbIZX7/k/LDvvrotaBrYEBlwK5GlCmqyc=;
	b=FLEQ9kZfG9BVypgMz8G5dEF/BuuuLplDOHlolGHLKARg6rEUavQsxNmp9auoXdtY0iSX
	 sZwfcVI2q2l8wlRzAGI26pHAuDdUBZzMb5W+ct9sUlAMm2xMJsvZ0JGgiQ4maeURt46f/
	 DIwoh+FOPoykeGAWRzJnEFoQlgAD93KY1a3fk4hR0O8Pl4pyr8uxH+ULmqmSNFyGj8oyj
	 +2DxlFek3PUPSS82+wvXHcdurlH36k7WdDAWIIasuDEKykNTR6cg0eDxfWPN8w75kC3A3
	 Q+aSfIAk9qYno3dyMYaVP3q12NCy5+sjzs1Twbs7kf43bO8zEM5XqoITRlKxGpYF0KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VUyt4SzA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2512606A31C
	for <mptcp@lists.linux.dev>; Sat, 31 Oct 2026 23:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VUyt4SzA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A421F000C1;
	Sat, 31 Oct 2026 23:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793488219;
	bh=iXhC5kk5eUmbIZX7/k/LDvvrotaBrYEBlwK5GlCmqyc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=VUyt4SzA+MHheJ+M6r6kTufZ49+t5RpFo2w7IBJ+86LsBbQL+px/05IdwIUW/SVOL
	 C1qjbAW4U1NMLOIlBn0qGmcFUs1by7wqZ4KJ30N6oorB36oyKSs3gNbaiZyQI5sJoX
	 vNpxNUbse8C8qz0TaD0Zr5vlH9ptama6beDMjNXQjL5efo/lJ6KFDGAx43qJ2i2WY6
	 gFYkXvOXNhY+m0qnQZBrOHvex+LfscR1D4u0sGNGlqX5sa2WJ8lTfk+lm8cfuIuVC7
	 E4CVyVLazAPtM2bYnYOOm8AmIHYfJyuULgMbhDAQzilZzqJ43djDLYNpWXp1Ne7ywA
	 36tyIFaNDXlig==
Message-ID: <sashiko-outbox-192217@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v2 5/8] mptcp: sched: reinject on an idle
 subflow with the default scheduler
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>, "MPTCP
 Linux" <mptcp@lists.linux.dev>
In-Reply-To: <20261031-mptcp-sched-opp-retrans-v2-5-e9c4a30f6841@kernel.org>
References: <20261031-mptcp-sched-opp-retrans-v2-0-e9c4a30f6841@kernel.org>
 <20261031-mptcp-sched-opp-retrans-v2-5-e9c4a30f6841@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 23:10:18 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] mptcp: sched: u32 overflow and underflow in mptcp_sched_oppr_gai=
n()
- [Medium] mptcp: sched: false MPTCP_OPPR_GONE in mptcp_sched_oppr_gain()
--

commit dddb76c1077214e20753883f9b0151980b6f6ff0
Author: Abdul Wasey <w453y.me@gmail.com>

mptcp: sched: reinject on an idle subflow with the default scheduler

This commit enables opportunistic reinjection on an idle subflow in the
default MPTCP scheduler when another subflow is gone or slow enough that a
copy would arrive at least one RTT of the idle subflow earlier, up to a
256 KB budget.

> diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> index 087b36381e7a4..b70e4a6908177 100644
> --- a/net/mptcp/sched.c
> +++ b/net/mptcp/sched.c
> @@ -28,6 +28,9 @@ static int mptcp_sched_default_get_send(struct mptcp_so=
ck *msk)
>  	return 0;
>  }
> =20
> +#define MPTCP_OPPR_BUDGET	(256 * 1024)
> +#define MPTCP_OPPR_GONE		U32_MAX
> +
>  /* the active subflow with nothing to send or retransmit and the lowest =
RTT */
>  static struct sock *mptcp_sched_oppr_idle_ssk(struct mptcp_sock *msk)
>  {
> @@ -53,11 +56,98 @@ static struct sock *mptcp_sched_oppr_idle_ssk(struct =
mptcp_sock *msk)
>  	return pick;
>  }
> =20
> +/* How much earlier, in us, a copy sent now on @idle would reach the peer
> + * than the data held by @subflow: about half an RTT of each, the curren=
t one
> + * of @subflow and the base one of @idle, whose queue is empty. 0 if @su=
bflow
> + * holds nothing, is not slower than @idle, or if the copy would not sav=
e at
> + * least one RTT of @idle: with a smaller gain, the copies cost more tha=
n they
> + * save. MPTCP_OPPR_GONE if @subflow is gone.
> + */
> +static u32 mptcp_sched_oppr_gain(struct mptcp_subflow_context *subflow,
> +				 const struct sock *idle)
> +{
> +	struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> +	u32 srtt, min_rtt;
> +
> +	/* racy on a DATA_ACK, only a hint: the worker checks again */
> +	if (ssk =3D=3D idle || data_race(tcp_rtx_and_write_queues_empty(ssk)))
> +		return 0;
> +
> +	/* A joining subflow only holds its SYN, and a closed one nothing, even
> +	 * if its queues look used: tcp_disconnect() moves the write_seq.
> +	 */
> +	if ((1 << inet_sk_state_load(ssk)) &
> +	    (TCPF_SYN_SENT | TCPF_SYN_RECV | TCPF_CLOSE))
> +		return 0;
> +
> +	if (!__mptcp_subflow_active(subflow))
> +		return MPTCP_OPPR_GONE;

[Severity: Medium]
Can mptcp_sched_oppr_gain() return a false MPTCP_OPPR_GONE for a subflow
that holds no MPTCP data?

When the initial subflow msk->first is closed while the MPTCP connection
stays open on other subflows (for example via mptcp_pm_rm_addr_or_subflow(),
mptcp_nl_cmd_sf_destroy(), or __mptcp_close_subflow() on a peer FIN),
__mptcp_close_ssk() leaves msk->first in msk->conn_list when
!msk->free_first and calls __mptcp_subflow_disconnect(). If msk->first is
in TCP_ESTABLISHED or TCP_CLOSE_WAIT, __mptcp_subflow_disconnect() calls
tcp_shutdown(ssk, SEND_SHUTDOWN), moving ssk to TCP_FIN_WAIT1 or
TCP_LAST_ACK and queuing a TCP FIN skb on ssk->tcp_rtx_queue.

Even when msk->first holds only that unacknowledged TCP FIN and no MPTCP
data, tcp_rtx_and_write_queues_empty(ssk) is false, its state is not in
TCPF_SYN_SENT | TCPF_SYN_RECV | TCPF_CLOSE, and __mptcp_subflow_active()
is false. Similarly, on the lockless DATA_ACK path in
mptcp_sched_oppr_check(), an outgoing MP_JOIN subflow whose SYN was in
tcp_rtx_queue when tcp_rtx_and_write_queues_empty(ssk) ran can transition
to TCP_ESTABLISHED before inet_sk_state_load(ssk) while
__mptcp_subflow_active(subflow) is still false waiting for the 4th ACK.

When another active subflow has data in flight alongside an idle subflow,
wouldn't this cause mptcp_sched_oppr_max_gain() to return MPTCP_OPPR_GONE,
waking mptcp_worker on every DATA_ACK in mptcp_sched_oppr_check() and
forcing reinject_limit to the full MPTCP_OPPR_BUDGET in
mptcp_sched_oppr_default()?

> +
> +	/* A retransmission timeout without progress since: the subflow may
> +	 * be broken, which the stale detection handles (it needs the
> +	 * MPTCP-level timeouts that copies would avoid).
> +	 */
> +	if (READ_ONCE(inet_csk(ssk)->icsk_retransmits))
> +		return 0;
> +
> +	srtt =3D READ_ONCE(tcp_sk(ssk)->srtt_us) >> 3;
> +	/* same here, @idle is not locked */
> +	min_rtt =3D data_race(tcp_min_rtt(tcp_sk(idle)));
> +	if (READ_ONCE(ssk->sk_pacing_rate) >=3D READ_ONCE(idle->sk_pacing_rate)=
 ||
> +	    min_rtt =3D=3D ~0U || srtt <=3D 3 * min_rtt)
> +		return 0;
> +	return (srtt - min_rtt) / 2;
> +}

[Severity: Medium]
Can 3 * min_rtt overflow u32 and cause (srtt - min_rtt) / 2 to underflow
in mptcp_sched_oppr_gain()?

In net/ipv4/tcp_input.c, tcp_ack_update_rtt() -> tcp_rtt_tsopt_us()
accepts TCP Timestamp deltas up to INT_MAX / (USEC_PER_SEC / TCP_TS_HZ)
(or INT_MAX us with microsecond timestamps), and tcp_update_rtt_min()
stores the sample in tp->rtt_min without capping it to TCP_RTO_MAX.

If idle's min_rtt is in [0x55555556, 0x5fffffff], 3 * min_rtt wraps around
in 32-bit unsigned arithmetic to a small value. Any ssk whose srtt is
larger than that wrapped value but smaller than min_rtt will bypass the
srtt <=3D 3 * min_rtt check, and (srtt - min_rtt) / 2 will underflow u32
into ~1.43 billion microseconds, saturating reinject_limit to
MPTCP_OPPR_BUDGET in mptcp_sched_oppr_default().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031-mptcp-sche=
d-opp-retrans-v2-0-e9c4a30f6841@kernel.org?part=3D5
