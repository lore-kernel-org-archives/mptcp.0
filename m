Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793372556;
	b=d92VIMB/fR6gN6zbzw6Mxgq3v5MmpxquGq4JM9o9LnAccx8NasfnGod4eXROg2oSOnC9
	 XF9X6bUEMswRT7otQ44j4BlwVN88citcwh/btyd+ISGcsr+OQvdBusChGnwKjbFS9I1LT
	 dDRLR3WNnCZVthzEwn7AQe4C+CGguqwMXXmNWFVWm3SyDpvHO1hdoT4OG+ObjHshTSHgq
	 Pdn/2sSwtH/S4xF+103NolMlFqPIgnWXKuvJNERSFPlGSIioc2S693W9hPS0Uj9soJa1q
	 56ZVnV/mwPZDNDHnmLQJsENWLl/b6tomkZJBcUCX74PyVhhcjd33LzTBCxDC+dmmekw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793372556;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=f9ihZf6UqF+2d1Fz4DVdyw0ufLhdjjD5UhKkL6DYQ14=;
	b=v9K4r4+o4kGMzcLZRa/PI1he8Jyx1Osq2tM7gxl159JPdBHSxUH7nhi/KdLKf7D7j368
	 H0oNmVqoRLVFG6SSMqTIld7Pg7+0A8WDhsf2o8oEZhXKlMz6kMYmAohrOuDjJ6/YPYy5+
	 TlmcrJF0oJlo6ZniLguuWztNzBCLdfYaRJXtmdQAwhkMSmw4W+pFZRfKXBAcPznBxZcuP
	 vPSu//KGbD8piNwU+RGdkCP3dil/qa1efU0qURteclNpoelpeFUP2Fze3E/ZtdbZ+GH2f
	 sESrrsJAGJk7R2cMDIe9A1DYi5OdoM+SYEH/GRWpVU8/Xoo1SExjoBQd0UhU+TllcnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gJgdTTh7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83920606A32D;
	Fri, 30 Oct 2026 15:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gJgdTTh7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE061F00A20;
	Fri, 30 Oct 2026 15:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793372556;
	bh=f9ihZf6UqF+2d1Fz4DVdyw0ufLhdjjD5UhKkL6DYQ14=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gJgdTTh7pmXUoTSGljkSP+sJ2OO2Dq/e+TiR2NJ56BmjrofA40JFsd/HQi8zS+BnT
	 Hn1FshCe+bvumRGfgHVYLDlO9Eek52MIStST+rdACC/7u8rCN2veib1OFQgCUkl2YJ
	 dVn0c0bj3UD/WBHJEaRY1ohuKdJuj2TQh2Kr95yj/kJCQJvTudRTMdZgWhtatJncJk
	 SC4SILVQTAnJaSIsJudhcvOm6vzlyQ0+o7nPjAhbfBrG4mdyE2XYke+JDYgUaurFK1
	 MMFrPRl9v8sj3aQz2L8crLUR7ExurH99LY2pZv3tUcLv6QHL1TVVZFvwyTM57sJKf6
	 SDZn3e+ZVp+8g==
Subject:
 Re: [PATCH net v2] mptcp: protect listener backlog reads in diagnostics
From: netdev-bot+sashiko@kernel.org
To: zzzccc427@gmail.com
Cc: matttbe@kernel.org, martineau@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, geliang@kernel.org,
 horms@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, jjzuming@gmail.com
Date: Fri, 30 Oct 2026 15:02:34 +0000
Message-ID: <179337255481.3134.11373670095456215150@kernel.org>
In-Reply-To:
 <pm-mptcp-objects-candidate-0066-v5-4d1b83d62fcde2d57e8d@gmail.com>
References:
 <pm-mptcp-objects-candidate-0066-v5-4d1b83d62fcde2d57e8d@gmail.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch turns msk->first into an RCU-protected pointer for
  diag readers, but the code that frees the first subflow still frees it…

--

mptcp: protect listener backlog reads in diagnostics

This patch puts the msk->first load and the listener backlog reads in
mptcp_diag_get_info() under rcu_read_lock(). The goal is to fix a KASAN
slab-use-after-free that happens when a token dump or
mptcp_diag_dump_one() races with close() on an MPTCP socket that was
put back into listen after connect(AF_UNSPEC). The fix depends on
SOCK_RCU_FREE and the SLAB_TYPESAFE_BY_RCU TCP slab caches to keep the
first subflow readable.

> diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
> index 136c2d05c0ee..28a42eee6651 100644
> --- a/net/mptcp/mptcp_diag.c
> +++ b/net/mptcp/mptcp_diag.c
> @@ -200,8 +200,10 @@ static void mptcp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
>  	r->idiag_wqueue = sk_wmem_alloc_get(sk);
>  
>  	if (inet_sk_state_load(sk) == TCP_LISTEN) {
> -		struct sock *lsk = READ_ONCE(msk->first);
> +		struct sock *lsk;
>  
> +		rcu_read_lock();
> +		lsk = READ_ONCE(msk->first);

[Severity: High]
Is rcu_read_lock() here enough by itself? The writer in
__mptcp_close_ssk() frees the subflow first and only then clears
msk->first:

net/mptcp/protocol.c:__mptcp_close_ssk() {
    ...
	release_sock(ssk);

	sock_put(ssk);

	if (ssk == msk->first)
		WRITE_ONCE(msk->first, NULL);
    ...
}

On the path close() -> __mptcp_close() -> __mptcp_destroy_sock() ->
mptcp_destroy() -> mptcp_destroy_common(), with free_first set, this
sock_put() drops the last reference. The KASAN trace in the changelog
shows exactly that. For a SOCK_RCU_FREE listener, sk_destruct() then
queues call_rcu(__sk_destruct). msk->first is still published until the
WRITE_ONCE() that follows.

A grace period only covers readers that were already inside a read-side
section when call_rcu() was called. The closer runs in sleepable process
context, outside RCU. On a PREEMPT_RCU kernel, could it be preempted
between sock_put() and WRITE_ONCE() long enough for both the
__sk_destruct grace period and the later SLAB_TYPESAFE_BY_RCU (or
SLUB_RCU_DEBUG) grace period to finish?

The reader side has a matching gap. The TCP_LISTEN check above runs
outside RCU, and both mptcp_diag_dump() and mptcp_diag_dump_one() can
sleep. A reader could see TCP_LISTEN, get preempted, and enter
rcu_read_lock() only after those grace periods. It would then load the
stale msk->first and read sk_ack_backlog and sk_max_ack_backlog from
freed or reused memory into idiag_rqueue/idiag_wqueue.

Wouldn't that be the same slab-use-after-free shown in the KASAN report?

There also seems to be a second path through mptcp_listen():

	mptcp_set_state(sk, TCP_LISTEN);
	sock_set_flag(sk, SOCK_RCU_FREE);

	lock_sock(ssk);
	err = __inet_listen_sk(ssk, backlog);

The msk becomes TCP_LISTEN before the first subflow is hashed. The
subflow only gets SOCK_RCU_FREE in __inet_hash(), after hashing
succeeds. If listen fails, the subflow is later freed synchronously
through __sk_destruct(), and again msk->first is cleared only after
that.

The changelog says SOCK_RCU_FREE plus the typesafe slab make this read
safe. Doesn't that hold only if msk->first is unpublished before
reclamation starts? mptcp_sk_clone_init() already uses that order:

	list_del_init(&subflow->node);
	WRITE_ONCE(msk->first, NULL);
	sock_put(ssk);

Would it close the remaining window to clear msk->first in
__mptcp_close_ssk() before the final sock_put(ssk), and keep the
rcu_read_lock() added here?

>  		if (lsk) {
>  			/* override with settings from tcp listener,
>  			 * so Send-Q will show accept queue.
> @@ -209,6 +211,7 @@ static void mptcp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
>  			r->idiag_rqueue = READ_ONCE(lsk->sk_ack_backlog);
>  			r->idiag_wqueue = READ_ONCE(lsk->sk_max_ack_backlog);
>  		}
> +		rcu_read_unlock();
>  	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/pm-mptcp-objects-candidate-0066-v5-4d1b83d62fcde2d57e8d%40gmail.com
