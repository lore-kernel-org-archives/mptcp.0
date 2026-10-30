Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793363503;
	b=xELGeHYtlaPemYHnTErfedE8gg6x5cStJlf8LFdeX2Mo3+YViZCzc83uJRPiA3tKgWyi
	 iCfxiJgXI+BJSJpEFzkUN6fD0uPom573MAYj7/sRaGCOa9mFqQfUhBpHChGgTj2JQY7T3
	 52dPu+F1MWJGIfDrnVUYET6SdZjH3wjthrjUFp7fQKhejzSKPcmQv3q+dDv7DM47gv2sG
	 Cxly+Abed4R115McUSwZ0J0XKfmEVhL8bn5c+UXDNWNGLhKd7YJ7hNjxHyHvcjqpFAKOx
	 MuMlV5kFId2XrbXwp5PvutAj6mxXWDhfCoudIbJ5uokwEzLt7kKwle0OmwtslFKCHKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793363503;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=UDoy5Y6pyUGkFvr6CnxyA/cvulZjeL9SSvBftaqkDcU=;
	b=Cjly4DXfgd+lkv0jH5oTOiN02TEm6IlEL+N5nQwYJMJYsmMAXo7gxSG4xh6xoMK3WbDg
	 HD7ZxwQrVRcTgAIeJgMa4fi6tZxcdrijPjqkYv8EoujLMZ7D0fwOWYT0Vs2CGPQqzUVqK
	 WXQUOJYzLFkKg5DMLcXDhB2iJL2/j7BBGTjQ99B6+9Ccf60FLeNhVbVCsWCcljFS1AMnv
	 LuhDoVvEWu40jmk5vW+LOd5StULEziSMYWea8syFDTm3ZMR3Hw5bqsPoU83gANoADdbEA
	 cDLICAhDODe4ADL4QuhytgqGJp8gI/9crlNL4UZtuyRw8o9LhBCEV9szEyoo4x5PbJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gOiUAzAg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C5C606A31A;
	Fri, 30 Oct 2026 12:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gOiUAzAg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212521F000C1;
	Fri, 30 Oct 2026 12:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793363502;
	bh=UDoy5Y6pyUGkFvr6CnxyA/cvulZjeL9SSvBftaqkDcU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gOiUAzAgalNmuspXqWNxd0/bC1ZC138HacRukovaykxAkYsZHWblCZ0FrGRo73d2U
	 vU0uvwUNuLgfU49FnqhePn1b9FgSzI3Y2EAUx75qRSpMGMhR1GIi/WlK44GoHMp/Ft
	 tyqySIhIIKeY2VasPDAZloVXXk9ZBwXy/pjOg+T0s3Fb4Q9ZopQvh43JW2FMW5x359
	 brAasqxL3ZrqWf6Kjxa/IsXeGaezv4RimpHLjjCbyvPwRZohqUOOn4uUCt6JYTd0CN
	 WwoHTMa0T3ZJSTLa3O0qtOkD/xuDp3Tu5q49j3ULyyOmfyUSehIKwKen5Wwu5o6G7q
	 7HgFMPntQFuhQ==
Subject: Re: [PATCH net] mptcp: protect listener backlog reads in diagnostics
From: netdev-bot+sashiko@kernel.org
To: zzzccc427@gmail.com
Cc: matttbe@kernel.org, martineau@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, geliang@kernel.org,
 horms@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, jjzuming@gmail.com
Date: Fri, 30 Oct 2026 12:31:41 +0000
Message-ID: <179336350162.3134.14466007220476234920@kernel.org>
In-Reply-To:
 <pm-mptcp-objects-candidate-0066-v3-73df72b7a543d4cada0e@gmail.com>
References:
 <pm-mptcp-objects-candidate-0066-v3-73df72b7a543d4cada0e@gmail.com>
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

- [Medium] In net/mptcp/mptcp_diag.c, mptcp_diag_get_info() now only
  applies the listener override when the socket is not owned: `if…

--

mptcp: protect listener backlog reads in diagnostics

This commit takes the MPTCP data lock in mptcp_diag_get_info() around the
listener state check and the backlog reads. The override from msk->first
is now applied only when no process owns the socket. The goal is to fix a
use-after-free on the token based diag paths, which can race with a
disconnect, re-listen and close of the same socket.

> diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
> index 136c2d05c0eeb..a71bcaee15c8d 100644
> --- a/net/mptcp/mptcp_diag.c
> +++ b/net/mptcp/mptcp_diag.c
> @@ -199,7 +199,12 @@ static void mptcp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
>  			  READ_ONCE(mptcp_sk(sk)->backlog_len);
>  	r->idiag_wqueue = sk_wmem_alloc_get(sk);
>  
> -	if (inet_sk_state_load(sk) == TCP_LISTEN) {
> +	/* The listener walk holds the listen hash lock: do not wait for a
> +	 * socket owner that could be unhashing the first subflow.
> +	 */
> +	mptcp_data_lock(sk);
> +	if (!sock_owned_by_user(sk) &&
> +	    inet_sk_state_load(sk) == TCP_LISTEN) {
>  		struct sock *lsk = READ_ONCE(msk->first);
>  
>  		if (lsk) {

[Severity: Medium]
mptcp_diag_get_info() is the shared idiag_get_info callback, so this new
sock_owned_by_user() check also applies to mptcp_diag_dump_listeners().

mptcp_listen() never inserts the msk into the token table. Isn't the
listener walk then the main way a listening MPTCP socket gets reported?

While a task holds lock_sock() on the listening msk, the override is
skipped. That covers listen(), most mptcp_setsockopt() and
mptcp_getsockopt() calls, shutdown and close, and the worker. In that
case only the fallback values are reported:

	r->idiag_rqueue = sk_rmem_alloc_get(sk) +
			  READ_ONCE(mptcp_sk(sk)->backlog_len);
	r->idiag_wqueue = sk_wmem_alloc_get(sk);

For a listener these are normally 0/0, not the accept queue length and
the max backlog. Could this make ss -Ml and accept queue monitoring show
occasional 0/0 readings for MPTCP listeners?

For comparison, tcp_diag_get_info() always reports sk_ack_backlog and
sk_max_ack_backlog for TCP_LISTEN, with no ownership check:

net/ipv4/tcp_diag.c:tcp_diag_get_info() {
	if (inet_sk_state_load(sk) == TCP_LISTEN) {
		r->idiag_rqueue = READ_ONCE(sk->sk_ack_backlog);
		r->idiag_wqueue = READ_ONCE(sk->sk_max_ack_backlog);
	...
}

The listener walk also looks like it was already memory safe before this
patch:

net/mptcp/mptcp_diag.c:mptcp_diag_dump_listeners() {
	...
		rcu_read_lock();
		spin_lock(&ilb->lock);
		sk_nulls_for_each(sk, node, &ilb->nulls_head) {
			...
			ret = sk_diag_dump(sk, skb, cb, r, net_admin);
	...
}

Releasing the hashed listener subflow goes through
tcp_set_state(TCP_CLOSE)->inet_unhash(), which takes the same ilb->lock.
Hashed listeners are also SOCK_RCU_FREE.

The use-after-free described in the commit message seems reachable only
from the token based paths: the token iteration in mptcp_diag_dump() and
mptcp_diag_dump_one(). On those paths TCP_LISTEN shows up only in the
disconnect and re-listen race.

The commit message accepts the tradeoff:

  While a process owns the socket, the dump reports the MPTCP socket's
  own queue values instead.

It doesn't explain why the listener walk needs the check, though. Is the
ownership check needed on the mptcp_diag_dump_listeners() path, or could
it be limited to the token based callers?

With this change, the existing comment inside the if (lsk) block, "so
Send-Q will show accept queue", only holds while the socket is not owned.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/pm-mptcp-objects-candidate-0066-v3-73df72b7a543d4cada0e%40gmail.com
