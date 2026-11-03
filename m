Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741880;
	b=rK4omgWAIdX2BHzhJ2+4eF7HO6mDyjQTj7gA2Wa1/wmtCGyxIm7EjesDin+TeF8O6g0K
	 3Mi9C5Z+cscYj1iqIWhd7QWvHdWZ5QlaS67dlKEcdG1lmGYPWnohSCf4r9J4uSLOwVsXD
	 yInA5i2HYSPmwxvP6su8OBj9WLiKuZ3IOjC0YFQtxvc8W15DTzmoT61SdP0yDdM5WPx5O
	 r6eW9meX9lracRuOEc/c6gcwUZlJbByVuXX045+FXdOBkpwKuKtGck88RHdq97fxjBCNR
	 tcJ3W9baS5AKBTGhaELRiXNK+RIQg2er+1nFq9iLbq1wIn1ElU/W/DFKW1mnx1XxBYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741880;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=gtM1vVlA4eUdy9KzKaA5nW7tGQMPQv+qiqwZbi8D3kk=;
	b=4CW/rbOOaTqSmPlTSuJmunNEItLRRpUgB05X7i1x2M5onZmNAKoVBoYfdPK347uzK/h9
	 J5vmcSqBZNyorZ0Aa5YJc+3kWSROXWKkK/mCAaERoLndIPpF6hTnR6RaJvwIGIOnhrkJp
	 kOfGPov4LfHts6i/u5Bjl9WvNe+Fm6toZWxa/ziIAsgcInDZN1JLiB76et7/3LrwPGFnj
	 UFFaiV5x/KzJpNbFewJmMRYgEz9Saoz2pkT1S7Tqa7YYhV8Knxsp0v9rKTlslHIBt0Ifs
	 Prhs8+H2H0OX3dUpUUEL1ioYKO9Mf8Vs55tCyLhw+e4bkPFn0HZfoGDvhMp4aWiJgQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="A0Df5/Up";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900C2606A328;
	Tue,  3 Nov 2026 21:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A0Df5/Up
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA381F000C1;
	Tue,  3 Nov 2026 21:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793741880;
	bh=gtM1vVlA4eUdy9KzKaA5nW7tGQMPQv+qiqwZbi8D3kk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=A0Df5/UpYAIhUerMAqadTJO1erLorsRlwoMpmlwFh/dw4vvvNrTF14QjnNU31JFua
	 /0GwJjKEopVIXqYQqFViTcGWokqDwpUVxjgVUUiGAVOrTmgh1TAREoGLfj9k+c3phx
	 qwXfc3vViktZos6fsJ8cTD7k6vlwSyLE+Qn65Yx9dCkpaeumVoAVi0hCZUjhX/8rlE
	 vC0fzecyADEgl+O6iWBBBM9+2oRCOXoZI73VF1T4thLbdlC5OVx2l3z2VWomwAIfNc
	 4WwGiPtwhJXLUybmDTLdWp+2KxtKqDnVnwFRLoGl5fUX16yDU1xs3xG8FIyz2/ZT49
	 KleAX8yiGIa5g==
Subject:
 Re: [PATCH bpf v2 06/15] bpf, sockmap: Give no progs to a TCP listener
From: netdev-bot+sashiko@kernel.org
To: alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 john.fastabend@gmail.com, jakub@cloudflare.com, jiayuan.chen@linux.dev,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, kuniyu@google.com, willemb@google.com, matttbe@kernel.org,
 mptcp@lists.linux.dev, mason@kernel.org, josef@toxicpanda.com
Date: Tue, 03 Nov 2026 21:37:58 +0000
Message-ID: <179374187870.488855.7800063583184291863@kernel.org>
In-Reply-To: <20261102072112.4160195-7-alexei.starovoitov@gmail.com>
References: <20261102072112.4160195-7-alexei.starovoitov@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 0 · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch does not fix the listener-side bug that its commit
  message names first: a TCP listener carrying the psock's sk_data_ready…
- [High] tcp_bpf_clone() decides whether to reset the child's callbacks
  only by checking whether the copied sk_prot is a tcp_bpf proto…
- [Low] The helper descriptions still promise that every inserted socket
  inherits the map's programs, which contradicts the new TCP-listener…

Pre-existing issues:
- [Low] This problem wasn't introduced by this patch, but the
  sockmap_listen child-clone tests do not test what their comments…

--

bpf, sockmap: Give no progs to a TCP listener

This patch makes sock_map_link() skip program inheritance for TCP sockets
in TCP_LISTEN. Such a listener gets a psock but keeps its own
sk_data_ready and sk_write_space. It also makes tcp_bpf_clone() reset the
child's sk_data_ready and sk_write_space to the TCP defaults, and it
documents the listener exception in map_sockmap.rst.

> diff --git a/Documentation/bpf/map_sockmap.rst b/Documentation/bpf/map_sockmap.rst
> index 2d630686a00ba..eb466b86df170 100644
> --- a/Documentation/bpf/map_sockmap.rst
> +++ b/Documentation/bpf/map_sockmap.rst
> @@ -33,7 +33,9 @@ of ``__SK_DROP``, ``__SK_PASS``, or ``__SK_REDIRECT``.
>  
>  When a socket is inserted into one of these maps, its socket callbacks are
>  replaced and a ``struct sk_psock`` is attached to it. Additionally, this
> -``sk_psock`` inherits the programs that are attached to the map.
> +``sk_psock`` inherits the programs that are attached to the map. A TCP listener
> +is an exception. It gets a ``struct sk_psock``, but it keeps its callbacks and
> +inherits no programs.

[Severity: Low]

This isn't a bug, but a few other places still describe inheritance as
unconditional. bpf_sock_map_update() and bpf_sock_hash_update() in
include/uapi/linux/bpf.h still say:

 *		If the *map* has eBPF programs (parser and verdict), those will
 *		be inherited by the socket being added. If the socket is
 *		already attached to eBPF programs, this results in an error.

The bpf_sock_map_update() and bpf_sock_hash_update() helper sections
further down in map_sockmap.rst say the same thing.

After this patch, a TCP_LISTEN socket inherits no programs and no longer
gets -EBUSY. Should these descriptions, and the bpf-helpers man page that
is generated from the UAPI header, mention the listener exception too?

> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index efe49551caba9..282c6a4b2b05f 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -228,6 +228,14 @@ static int sock_map_link(struct bpf_map *map, struct sock *sk)
>  	struct sk_psock *psock;
>  	int ret;
>  
> +	/*
> +	 * A listener receives no data. With the callbacks of a verdict program
> +	 * or a parser it would no longer wake accept(), and its children would
> +	 * copy them.
> +	 */
> +	if (sk_is_tcp(sk) && sk->sk_state == TCP_LISTEN)
> +		goto no_progs;

[Severity: High]

This only checks sk_state at insert time. Can a socket that was inserted
while ESTABLISHED still become a listener that carries the psock's
sk_data_ready?

sock_map_sk_state_allowed() accepts an ESTABLISHED TCP socket. In that
case sock_map_link() gives it the map's programs, and
sk_psock_start_verdict() or sk_psock_start_strp() replaces sk_data_ready.
tcp_bpf_prots override neither disconnect nor unhash, so the psock
survives this sequence:

  connect(AF_UNSPEC)
    __inet_stream_connect()
      err = sk->sk_prot->disconnect(sk, flags);
      sock->state = err ? SS_DISCONNECTING : SS_UNCONNECTED;
  listen()
    __inet_listen_sk()    /* TCP_CLOSE is accepted */

When a handshake completes, parent->sk_data_ready() is
sk_psock_verdict_data_ready():

net/core/skmsg.c:sk_psock_verdict_data_ready() {
    ...
	copied = ops->read_skb(sk, sk_psock_verdict_recv);
	if (copied >= 0) {
		...
			sk_psock_data_ready(sk, psock);
		...
	}
}

On a listener, tcp_read_skb() always fails:

net/ipv4/tcp.c:tcp_read_skb() {
    ...
	if (sk->sk_state == TCP_LISTEN)
		return -ENOTCONN;
    ...
}

As a result the saved sock_def_readable never runs. Wouldn't a blocking
accept(), or poll/epoll on the listener, then never be woken? The
strparser variant looks the same, because tcp_read_sock_noack() also
returns -ENOTCONN on TCP_LISTEN.

The new comment in tcp_bpf_clone() describes exactly this socket, but
only newsk gets repaired. The commit message names "does not wake
accept()" as the bug and tags b8b8315e39ff for the listen-later case.

Would the listener's callbacks need to be restored or stripped when it
moves to TCP_LISTEN, or that transition be refused?

For this socket, the new map_sockmap.rst sentence "it keeps its callbacks
and inherits no programs" also doesn't hold.

[ ... ]

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index 36d1bf46353a9..fd443350f9b81 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -785,7 +785,18 @@ void tcp_bpf_clone(const struct sock *sk, struct sock *newsk)
>  {
>  	struct proto *prot = newsk->sk_prot;
>  
> -	if (is_insidevar(prot, tcp_bpf_prots))
> -		newsk->sk_prot = sk->sk_prot_creator;
> +	if (!is_insidevar(prot, tcp_bpf_prots))
> +		return;

[Severity: High]

The callback reset only happens when the copied sk_prot is a tcp_bpf
proto. Can a child copy the restored sk_prot together with a stale psock
sk_data_ready?

sk_psock_drop() restores sk_prot before it restores sk_data_ready:

net/core/skmsg.c:sk_psock_drop() {
	write_lock_bh(&sk->sk_callback_lock);
	sk_psock_restore_proto(sk, psock);
	rcu_assign_sk_user_data(sk, NULL);
	if (psock->progs.stream_parser)
		sk_psock_stop_strp(sk, psock);
	else if (psock->progs.stream_verdict || psock->progs.skb_verdict)
		sk_psock_stop_verdict(sk, psock);
	write_unlock_bh(&sk->sk_callback_lock);
	...
}

sk_psock_restore_proto()->tcp_bpf_update_proto(restore=true) publishes
the original proto with sock_replace_proto(). Only later does
sk_psock_stop_verdict() write back saved_data_ready.

The clone side takes neither sk_callback_lock nor the listener's lock:

tcp_v4_rcv()    /* TCP_NEW_SYN_RECV */
  tcp_check_req()
    syn_recv_sock()
      tcp_create_openreq_child()
        sk_clone()
          sock_copy()    /* skc_prot and sk_data_ready copied locklessly */

A child cloned between those two steps would get sk_prot == tcp_prot and
sk_data_ready == sk_psock_verdict_data_ready (or
sk_psock_strp_data_ready). tcp_bpf_clone() then returns early here and
the stale callback stays. sk_user_data is not copied, so the child has
no psock.

The precondition is a listener that still has psock callbacks, such as
the listen-later socket described above. The window opens in
sk_psock_drop() when sock_map_del_link() did not stop the verdict first.
That happens if the map's programs were detached before the socket was
deleted or closed:

net/core/sock_map.c:sock_map_del_link() {
    ...
	if (!strp_stop && !verdict_stop)
		return;
    ...
}

After accept(), sk_psock_verdict_recv() on the child finds no psock. It
drops the received data and the reader is never woken. If the child is
later added to a sockmap, sk_psock_start_verdict() does:

	psock->saved_data_ready = sk->sk_data_ready;
	WRITE_ONCE(sk->sk_data_ready, sk_psock_verdict_data_ready);

That saves sk_psock_verdict_data_ready as its own saved_data_ready, so
sk_psock_data_ready() would recurse until the stack overflows. This is
the case the commit message says it closes.

Would it be more robust to check for the psock callbacks themselves
(sk_psock_verdict_data_ready, sk_psock_strp_data_ready,
sk_psock_write_space) instead of sk_prot? Or to order the teardown so a
lockless clone cannot see a mismatched pair?

> +
> +	newsk->sk_prot = sk->sk_prot_creator;
> +	/*
> +	 * sock_map_link() gives a listener no programs, but a socket which got
> +	 * them in another state and listens now has the psock's sk_data_ready
> +	 * and sk_write_space, and sock_copy() has copied them.
> +	 * sk_psock_init() refuses a socket that has sk_user_data or a ULP, so
> +	 * what the psock replaced were the defaults of a TCP socket.
> +	 */
> +	newsk->sk_data_ready = sock_def_readable;
> +	newsk->sk_write_space = sk_stream_write_space;

[Severity: Low]

This is a pre-existing issue, not one introduced by this patch, but does
any test exercise this reset?

test_accept_after_delete() and test_accept_before_delete() in
tools/testing/selftests/bpf/prog_tests/sockmap_listen.c say the child is
"cloned without parent psock state or callbacks". However, test_ops()
runs them with:

	t->fn(skel, family, sotype, map_fd);

No verdict or parser program is attached, so the listener's sk_data_ready
and sk_write_space are never replaced. Those tests would still pass if
the new resets in tcp_bpf_clone() were removed.

>  }
>  #endif /* CONFIG_BPF_SYSCALL */

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102072112.4160195-1-alexei.starovoitov%40gmail.com
