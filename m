Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795162974;
	b=Hq7dwwPQCeB17Lfl995ciwembS3KcqX/gRxAlz/ewfoHY5vSuOLovC4Lh2V2qr2voQZH
	 ZReKmvtubIrPyEljeXSD9hllQmIOwIBDBd4g3cOFgFyArccPqj+9OlAwyq04Ig5XJeccI
	 AwsFP5ExmwsvO0OME1HjMV4Azx83xeYhWS7u00KXbuQmbmlrgZwjoZfCRpj0yZ3SfdGkO
	 vE5CYfiKixKvHEjxqYaj8j51+JUUKgMZf5peP0iXCis06m/41e2sy9g6H878cNRtUSFdV
	 aTl6bIwW6jz+GdPf3TUgJGOZGJJpNSIjIOYK041DCMYIipjjhfzTH8GPsFUeMU9UfSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795162974;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=itdZZyugtbVor8Nz/NNjMIX62HxSZgWL08Ie13eHCus=;
	b=ZZFZmmtJrzSbgE/KqZlO+uygdyYhC+pgpePazEnC5yFG7HLQR8sRKS3NrVNAd/CGwJC5
	 OtsLfDBiJrF2SPGEmTcu7S9UbrXjqobXK5IUly7TwdRd0QK7s1uW9aBqUeID6aUeaGuDn
	 GJHU5oPHViCO+iTcjiTreGmeaBREcod/VgPdWZtkNqX9ji5JSKu+g5L6SqBqxQio1Tcmm
	 qGTdqgUAlW+KSbzr+SSGlL9obcViKMGQ+AktsRj1v82XqYDtp/JwCiIQqbNLx4BslHZhH
	 KCXkBweFzRDMolnsewZskF/Qzo4DQyyhZPQKEE80TCsx2bICHk8+0QZvfed0ntrHMRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TlMA85qa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCAF606A320;
	Fri, 20 Nov 2026 08:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TlMA85qa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAEAD1F000D0;
	Fri, 20 Nov 2026 08:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795162974;
	bh=itdZZyugtbVor8Nz/NNjMIX62HxSZgWL08Ie13eHCus=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TlMA85qaAe4MKlEjA4cKr5y1JYj05gDsPx1RbWLjNxH0Yi+62GbkiE7Qius+r6vgt
	 bnBwERT3ORIRJjpRQth4ufKSimQJcCjSIoemtL5rP0PDzPW+M5RjwMO4udwoWWjcA+
	 utESPVAxl2QTQxUEIFedL+tki0Feo3X2imv/rC0smS3Ja+tjkUjIKRMBCaM+aBznMm
	 I5jFm1OqPgemZxT7wBCEFVLySo+s5xDHK30MAEMkBEHWBtboi6w9zN819hbypkqrRG
	 wpggX254ubRDrCb3OhzdRgaGYTAlFKKsWUZzaHwde0YqLo8GAdTwrTilNNhTh77qxy
	 2fGjYjR+9OnKw==
Subject:
 Re: [PATCH net 2/3] net: bound receive window predictions before narrowing
From: netdev-bot+sashiko@kernel.org
To: llleigoing@outlook.com
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, edumazet@kernel.org,
 ncardwell@google.com, kuniyu@google.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, matttbe@kernel.org, martineau@kernel.org,
 geliang@kernel.org
Date: Fri, 20 Nov 2026 08:22:53 +0000
Message-ID: <179516297347.3136.13553293180683672285@kernel.org>
In-Reply-To: <20261117052200.1507847-3-llleigoing@outlook.com>
References: <20261117052200.1507847-3-llleigoing@outlook.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In tcp_rcvbuf_grow() (net/ipv4/tcp_input.c), the slow-start
  growth term multiplies by `(newval - oldval)`.
- [Low] The From:/Signed-off-by: names do not match.

--

net: bound receive window predictions before narrowing

This patch changes rcvwin in tcp_rcvbuf_grow() and mptcp_rcvbuf_grow()
from u32 to u64, so the predicted receive window no longer wraps before it
is converted to a memory budget. The prediction is then clamped at INT_MAX
before it is passed to tcp_space_from_win() or mptcp_space_from_win().

> Fixes: aa251c84636c ("tcp: fix too slow tcp_rcvbuf_grow() action")
> Signed-off-by: lllei <llleigoing@outlook.com>

[Severity: Low]
The Author line is "lei lei <llleigoing@outlook.com>", but the sign-off
is "lllei <llleigoing@outlook.com>". The email addresses match and the
names don't. Could the names be made consistent? checkpatch will flag
the mismatch. The other patches in the series have the same mismatch.

> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index a2074a1af4222..6d5950dbe6638 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c

[ ... ]

> @@ -961,10 +961,10 @@ void tcp_rcvbuf_grow(struct sock *sk, u32 newval)
>  		 * It might take few additional ms to reach 'line rate',
>  		 * but will avoid sk_rcvbuf inflation and poor cache use.
>  		 */
> -		grow = div_u64((u64)rcvwin * rtt_us, rtt_threshold);
> +		grow = div_u64(rcvwin * rtt_us, rtt_threshold);
>  	} else {
>  		/* slow start: allow the sender to double its rate. */
> -		grow = div_u64(((u64)rcvwin << 1) * (newval - oldval), oldval);
> +		grow = div_u64((rcvwin << 1) * (newval - oldval), oldval);
>  	}
>  	rcvwin += grow;
>  
> @@ -973,6 +973,7 @@ void tcp_rcvbuf_grow(struct sock *sk, u32 newval)
>  
>  	cap = READ_ONCE(net->ipv4.sysctl_tcp_rmem[2]);
>  
> +	rcvwin = min_t(u64, rcvwin, INT_MAX);
>  	rcvbuf = min_t(u32, tcp_space_from_win(sk, rcvwin), cap);
>  	if (rcvbuf > sk->sk_rcvbuf) {
>  		WRITE_ONCE(sk->sk_rcvbuf, rcvbuf);

[Severity: Medium]
Can this clamp turn an underflowed prediction into a fully saturated
subflow receive buffer?

The slow-start branch above computes (newval - oldval) in u32, and
tcp_rcvbuf_grow() never checks that newval > oldval. For MPTCP subflows,
mptcp_rcv_space_adjust() only compares copied against the msk-level space.
It then calls tcp_rcvbuf_grow() on every subflow:

net/mptcp/protocol.c:mptcp_rcv_space_adjust() {
    ...
	if (copied <= msk->rcvq_space.space)
		goto new_measure;
    ...
	if (mptcp_rcvbuf_grow(sk, copied)) {
		...
		mptcp_for_each_subflow(msk, subflow) {
			...
			if (tcp_sk(ssk)->rcvq_space.space)
				tcp_rcvbuf_grow(ssk, copied);
    ...
}

The msk space comes from a single subflow. mptcp_rcv_space_init() sets it
to min(rcv_wnd, TCP_INIT_CWND * advmss) of msk->first or the accepted ssk.
A join subflow sets its own space in tcp_init_buffer_space(), from its own
advmss and window.

For example, a first subflow with advmss 1460 gives an msk space of 14600.
A join subflow on a 9000 MTU path starts at around 62720. Both values only
grow after that, so the gap stays.

Suppose copied lands between those two values, e.g. copied=30000. That
already gives an msk prediction of about 186 KB, above the default
128 KiB sk_rcvbuf, so mptcp_rcvbuf_grow() returns true. For the join
subflow, newval - oldval then wraps to about 2^32. If that subflow's
rtt_us >> 3 is at least tcp_rcvbuf_low_rtt, the slow-start grow term is
around 1e10.

Before this patch, the u32 truncation gave an arbitrary result. With
newval == oldval / 2 the sum was exactly 2^33, so nothing changed.

Now that rcvwin is u64 and clamped at INT_MAX, every such underflow sets
sk_rcvbuf to tcp_rmem[2] on that subflow. window_clamp then becomes
tcp_win_from_space(sk, tcp_rmem[2]).

The commit message says:

    Predictions above INT_MAX therefore already require a saturated
    receive budget.

That assumes the prediction is meaningful, which isn't true when
newval < oldval.

The subtraction was already there before this patch. Would it make sense
to skip the slow-start growth when newval <= oldval?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261117052200.1507847-1-llleigoing%40outlook.com
