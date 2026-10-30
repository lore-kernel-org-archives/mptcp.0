Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793324268;
	b=I5tac5d7870xWfbke7j5jNy2D0u8VYWeWjtcUysWT7ax8Gv3QDa5p9Cs1Q00U4Qc+Og8
	 FEpWeThFWSenA94EXU9rwsLy4XEtCegKPK8veDST9Z+IIBaq1Z2JU0eAqLjZ+Q52up3or
	 ApJ82Tu+A6rXZOF8Z3YSZC1oPa4X1PERPJTM0SDIgRLn42FNJpWRYagfRm1PaNi5RqVMM
	 hz/kKFYOHg0HDAfXbIyZXHatDe/5c91HqnpMg0eSMcRjqFDiyJ4xh7FxDHajZ9QgEP9k+
	 45GrWiTcW3997oZXuTUawIH96yO3lc72SkTB0DyS5Kw81wws4Q4vJ0JcXBIRs0xC+kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793324268;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=9vnq8f4TI//I+l5dvZR0UGr7LdO7s9eGZCCWOaZhDdQ=;
	b=XILJiWcRD9JRJzH3A07TMWkHj4u6gYzJ3pgaFR6Ss+cQQR0cjhxECmwnNrl2I5OCYKFh
	 lLuL9qFU16VzMNT+i6NQZj0wJzzyuUeaBAzpMTFzOLv9N7AIXgO9R+Gs0JuQlKdGAmklQ
	 UZ2jy4Sf0gW1PjcLiNuAag//mgDakVjlgfFGbuxGztqHIK/4iK6m8zzyYsWmayAj8H45C
	 sscdmqZYavmEAmpJhzehlmCcMXyryw4vtSVIufWd4hzX65KZFSWh57sjHmOLI8FoynmNI
	 cH87lcBrsvCCuKnAM2zS0Dk7baUVX1Gm6jowyPWuysS7iofjSHq/UbgdTd6cM2RMaXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=al0UWonc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1FD606A31A
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 01:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=al0UWonc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5B71F000C1;
	Fri, 30 Oct 2026 01:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793324267;
	bh=9vnq8f4TI//I+l5dvZR0UGr7LdO7s9eGZCCWOaZhDdQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=al0UWonc++21bu4sI1Sbyj2oJBqLg6vWdN7Dtim+8AeuGOj7e/9SsfAdJIpQCFfgj
	 pHcdKUe5iCxeUouzJE8Pd4QOiPop8rNQlyXMs3L6y+EM0vIWgjRRM80BLt0AWjPv/f
	 lPyxcniy8XvtCAqtVFabcx0qJ2hE/mLsq4ZTi1GQruh0oRVO8oaBOgznJhMszDb0IR
	 Rmwciwfvoyvb34W7bIKXDUwqPDhPpqlTea3Nl7Cge32QMsgAaVl+tn1nNhJHum+34g
	 o20YXajenr0XXVlYKLp/oBvVhMEAW+KnD5DRprCLg5sJNPOz2hPkZ7o1FjX6uYhB21
	 GDNW4zLPkmPxA==
Subject: Re: [PATCH mptcp-next v5 1/4] mptcp: sched: avoid truncating the
 pacing rate in the scheduler
From: netdev-bot+sashiko@kernel.org
To: shardul.b@mpiricsoftware.com
Cc: mptcp@lists.linux.dev, matttbe@kernel.org, janak@mpiric.us,
 kalpan.jani@mpiricsoftware.com, shardulsb08@gmail.com, w453y.me@gmail.com,
 kuba@kernel.org
Date: Fri, 30 Oct 2026 01:37:46 +0000
Message-ID: <179332426628.3132.5889522664662315602@kernel.org>
In-Reply-To:
 <20261028-mptcp_penalise_send_v2-v5-1-32fb379ce117@mpiricsoftware.com>
References:
 <20261028-mptcp_penalise_send_v2-v5-1-32fb379ce117@mpiricsoftware.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] On 64-bit kernels, keeping the full-width pace makes
  linger_time zero for every possible queue size when the pacing rate is…
- [Low] The patch fixes the default scheduler mptcp_subflow_get_send()
  (net/mptcp/protocol.c) but not its BPF port, bpf_burst_get_send() in…
- [Low] TRACE_EVENT(mptcp_subflow_get_send) in
  include/trace/events/mptcp.h fires on every loop iteration of…

--

mptcp: sched: avoid truncating the pacing rate in the scheduler

This commit changes the local pace variable in mptcp_subflow_get_send()
from u32 to unsigned long, and computes the linger time with div64_u64().
It also computes the running avg_pacing_rate average with
mul_u64_u64_div_u64(), so the rate * bytes products no longer wrap.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 02a4f479d9d8c..886f00ee2a4d4 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1633,7 +1633,8 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
>  	struct subflow_send_info send_info[SSK_MODE_MAX];
>  	struct mptcp_subflow_context *subflow;
>  	struct sock *sk = (struct sock *)msk;
> -	u32 pace, burst, wmem;
> +	unsigned long pace;
> +	u32 burst, wmem;

[Severity: Low]
Should the mptcp_subflow_get_send tracepoint get the same change?

trace_mptcp_subflow_get_send() runs for every subflow in this loop.
However, TRACE_EVENT(mptcp_subflow_get_send) in
include/trace/events/mptcp.h still stores the rate in a u32 and computes
the ratio with the old formula:

include/trace/events/mptcp.h:
		__field(u32, pace)
	...
			__entry->pace = READ_ONCE(ssk->sk_pacing_rate);
	...
		if (ssk && sk_fullsock(ssk) && __entry->pace)
			__entry->ratio = div_u64((u64)ssk->sk_wmem_queued << 32, __entry->pace);
	...
	TP_printk("active=%d free=%d snd_wnd=%u pace=%u backup=%u ratio=%llu",

Take a 64-bit kernel with a subflow above 4 GB/s. The trace records a
wrapped pace and a ratio that is too large, while the scheduler now uses
the full-width rate. A fast subflow can look slow in the trace. If the low
32 bits of the rate are zero, the trace shows pace=0 ratio=0.

A later patch in this series, "mptcp: sched: add penalise counters and
tracepoint", adds a mptcp_subflow_penalise event with u64 pace fields.
The mptcp_subflow_get_send event still has the u32 field at the end of
the series. The event also reports sk_pacing_rate rather than
avg_pacing_rate, but that predates this patch.

>  	int i, nr_active = 0;
>  	struct sock *ssk;
>  	u64 linger_time;
> @@ -1664,7 +1665,7 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
>  				continue;
>  		}
>  
> -		linger_time = div_u64((u64)READ_ONCE(ssk->sk_wmem_queued) << 32, pace);
> +		linger_time = div64_u64((u64)READ_ONCE(ssk->sk_wmem_queued) << 32, pace);
>  		if (linger_time < send_info[backup].linger_time) {
>  			send_info[backup].ssk = ssk;
>  			send_info[backup].linger_time = linger_time;

[Severity: Medium]
On 64-bit kernels, what happens here when the pacing rate is effectively
unlimited?

Sockets start with an unlimited rate:

net/core/sock.c:sock_init_data_uid() {
    ...
	sk->sk_pacing_rate = ~0UL;
    ...
}

TCP only replaces this value in tcp_update_pacing_rate(), which is
skipped when the congestion control provides cong_control:

net/ipv4/tcp_input.c:tcp_cong_control() {
    ...
	if (icsk->icsk_ca_ops->cong_control) {
		icsk->icsk_ca_ops->cong_control(sk, ack, flag, rs);
		return;
	}
    ...
}

tcp_rcv_state_process() also skips the update in this case. In-tree BBR
and ROCCET set sk_pacing_rate themselves. A BPF struct_ops congestion
control that implements cong_control but never writes sk_pacing_rate
leaves it at ULONG_MAX. avg_pacing_rate starts from that value, and the
new mul_u64_u64_div_u64() average keeps it within one or two of
ULONG_MAX.

sk_wmem_queued is an int, so (u64)sk_wmem_queued << 32 is below 2^63.
Dividing that by a pace near ULONG_MAX gives a linger_time of 0 for every
queue size. Because the comparison above is strict, the first subflow in
conn_list always wins the tie, even when its queue is full.

If that subflow is not writable, the check further down returns NULL
without looking at the other, empty subflow:

	ssk = send_info[SSK_MODE_ACTIVE].ssk;
	if (!ssk || !sk_stream_memory_free(ssk))
		return NULL;

mptcp_sched_default_get_send() turns the NULL into -EINVAL, and the push
stops until the first subflow drains. When both subflows are writable,
the first one still always wins, so traffic stays on a single path.

Before this patch, pace was truncated to at most U32_MAX. That made
(wmem << 32) / pace at least wmem, so a nonempty queue always got a
positive linger_time.

With this configuration, can a full subflow now be chosen over an empty
subflow that is writable?

> @@ -1697,9 +1698,12 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
>  		return ssk;
>  
>  	subflow = mptcp_subflow_ctx(ssk);
> -	subflow->avg_pacing_rate = div_u64((u64)subflow->avg_pacing_rate * wmem +
> -					   READ_ONCE(ssk->sk_pacing_rate) * burst,
> -					   burst + wmem);
> +	/* 64-bit arithmetic overflows at high rate with a large queue */
> +	subflow->avg_pacing_rate =
> +		mul_u64_u64_div_u64(subflow->avg_pacing_rate, wmem,
> +				    burst + wmem) +
> +		mul_u64_u64_div_u64(READ_ONCE(ssk->sk_pacing_rate), burst,
> +				    burst + wmem);
>  	msk->snd_burst = burst;
>  	return ssk;
>  }

[Severity: Low]
Does the BPF port of this scheduler need the same fix?

bpf_burst_get_send() in tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
copies mptcp_subflow_get_send(), but it still has the code this patch
removes:

static __always_inline __u64 div_u64(__u64 dividend, __u32 divisor)
...
	__u32 pace, burst, wmem;
	...
		pace = subflow->avg_pacing_rate;
	...
		linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
	...
	subflow->avg_pacing_rate = div_u64((__u64)subflow->avg_pacing_rate * wmem +
					   ssk->sk_pacing_rate * burst,
					   burst + wmem);

In this port:

  - pace still truncates avg_pacing_rate to 32 bits.
  - The local div_u64() helper only takes a 32-bit divisor.
  - avg_pacing_rate * wmem can still wrap.

If a nonzero avg_pacing_rate has zero low 32 bits, the !pace check also
resets the average from sk_pacing_rate. If that value also truncates to
0, the subflow is skipped.

test_burst() in tools/testing/selftests/bpf/prog_tests/mptcp.c loads this
program through test_bpf_sched(). No patch in this series touches
tools/testing/selftests/bpf/, so after this patch the port no longer
matches the scheduler it copies.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028-mptcp_penalise_send_v2-v5-0-32fb379ce117%40mpiricsoftware.com
