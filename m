Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793562692;
	b=Q/ON6r/JlmD77s3IBT76NSxQfMpXw33OuszcugY1pCS+/ZRWBKUKOhRHRUkosRfrpp9S
	 Jn2ZlmMkEyUc2nT++i4yeWRLjWzh8fJVQt532u2LzTF3PI3I3iFr3wwqeqpDcgBYLEpHR
	 iwTmWZP6qILjiaz0PsxDJk7zQrqKYAdgb/Q/o91SkMKYE3TM0MagyZnrWSbKhizmYD+JH
	 ogYMy7Rc/8oN/jV6hPq49kZbY5tqx5xMgwiF6hJ9i4kgkjU7PJrf/rpj/AynAiwTTdiMF
	 +eYjStfPPJvshXJv5G6y7aP+yQwr/T+dKGzqFh7TM9e7GIRdmjWMOPDyEjkQiiOBIsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793562692;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Wd6vdJoJoTdbsx9YgvO2Dw0fkTJlHg8nzwaqaLBiMuc=;
	b=CKkTgnzl/r8pRY3vL2HXeIj8hcUtA1Yq1HqY+1TyYzpwFmJcWlzyA3E5+yylZYPfecy9
	 FlNXIsHQU9NAdIRX1C87eftMEp7N/+Sl1jUpv7ABGk/N7DwgCvZelBX0wYG2bWIhO38+P
	 z3iOHFnlBp7uDjyya3l5efnPhHokKxoTPCfzoo5nwkUu6PYkXeF/5Nat+BlAKFY6tXHsZ
	 Z+wHnPazfdsrcVBzEIPOmCfiMX0pMLOIEOgj1Ku2RGKpDi0O7GeQaABkPQu04Gwtx5jVC
	 kxJq34FRf4sOLbQJnh0N+ZPqIiWKhzF4OOxZAe7PT6GpMXQgJlULcHw3ZgRFjn+L4MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vj3KiK4a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A146606A329;
	Sun,  1 Nov 2026 19:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vj3KiK4a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F521F000C1;
	Sun,  1 Nov 2026 19:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793562692;
	bh=Wd6vdJoJoTdbsx9YgvO2Dw0fkTJlHg8nzwaqaLBiMuc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vj3KiK4aVkIT+1M/IqUJ7SR+olwBs07b3DA3Mi/gFKi0ED1rFyJ+TFL2O6+7F1+Yz
	 SGJUQe9hRai+X1yYZeBNl6FUlGfJSgn6/MWM+gLjJdHi8B6hJ0JlfWBjS2OqCzwk52
	 OOReFjrHKoWbLH/+ryfvDrVhVGB6gNZBMhcgNVTxJFLDzdZyV0oWKioCpUtFWm9q1C
	 sbakRwife1BwiRAGpO3D+GxhNJzCbLxj3C7cX4kHtqsM+BQKPdTofQTTIDJKlmNkxR
	 w9JyAKOU+Z1iqFzjCr8MJQejnbYt6EHS7y/yKH61hlo9qLo5FnmGQuoovCXPLz+RQV
	 eSeuMyk+RqSMg==
Message-ID: <sashiko-outbox-192637@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 06/15] bpf, sockmap: Give no progs to a TCP listener
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: mptcp@lists.linux.dev
In-Reply-To: <20261101192057.2296489-7-alexei.starovoitov@gmail.com>
References: <20261101192057.2296489-1-alexei.starovoitov@gmail.com>
 <20261101192057.2296489-7-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 19:51:31 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] bpf, sockmap: race in tcp_bpf_clone() skips resetting psock ca=
llbacks
- [High] bpf, sockmap: listener keeps psock sk_data_ready after tcp_disconn=
ect()
- [High] bpf, sockmap: sock_map_del_link() stops active progs after goto no=
_progs
- [Medium] bpf, sockmap: TOCTOU race on sk->sk_state in sock_map_link()
--

commit 839857a435a21d698e4cce3b7a94e6c18f688106
Author: Chris Mason <mason@kernel.org>

bpf, sockmap: Give no progs to a TCP listener

This commit skips attaching sockmap BPF programs to TCP sockets in the
TCP_LISTEN state during sock_map_link() so listeners keep their default
callbacks, and resets sk_data_ready and sk_write_space on cloned child
sockets in tcp_bpf_clone().

> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index efe49551caba9..282c6a4b2b05f 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -228,6 +228,14 @@ static int sock_map_link(struct bpf_map *map, struct=
 sock *sk)
>  	struct sk_psock *psock;
>  	int ret;
> =20
> +	/*
> +	 * A listener receives no data. With the callbacks of a verdict program
> +	 * or a parser it would no longer wake accept(), and its children would
> +	 * copy them.
> +	 */
> +	if (sk_is_tcp(sk) && sk->sk_state =3D=3D TCP_LISTEN)
> +		goto no_progs;

[Severity: High]
What happens in sock_map_del_link() when a socket linked into a map via
this no_progs path is later removed from that map while also present in
another map that did attach programs?

Because goto no_progs leaves stream_verdict, stream_parser, skb_verdict,
and msg_parser NULL, sock_map_link() skips the -EBUSY conflict check and
still adds a link to the map on psock->link. If a socket inherits active
programs from Map A while in TCP_ESTABLISHED and is also linked into Map B
(which has its own programs) while in TCP_LISTEN, deleting the socket from
Map B calls sock_map_unref() -> sock_map_del_link():

net/core/sock_map.c:sock_map_del_link() {
    ...
			if (progs->stream_parser)
				strp_stop =3D true;
			if (progs->stream_verdict)
				verdict_stop =3D true;
			if (progs->skb_verdict)
				verdict_stop =3D true;
    ...
		if (strp_stop)
			sk_psock_stop_strp(sk, psock);
		if (verdict_stop)
			sk_psock_stop_verdict(sk, psock);
    ...
}

Because sock_map_del_link() checks the unlinked map's progs rather than
whether that map actually installed programs on psock, won't removing the
socket from Map B stop Map A's active verdict or parser callbacks (and
potentially call sk_psock_stop_strp() on an uninitialized strparser if
Map B had a stream_parser while Map A only had a verdict program)?

[Severity: Medium]
Could sk->sk_state change between sock_map_sk_state_allowed() and this
check in sock_map_link()?

In sock_map_update_elem() (reachable from BPF iterator, reuseport, and
sk_lookup programs), only bh_lock_sock(sk) is held without checking
sock_owned_by_user(sk):

net/core/sock_map.c:sock_map_update_elem() {
    ...
	bh_lock_sock(sk);
	if (!sock_map_sk_state_allowed(sk))
		ret =3D -EOPNOTSUPP;
	else if (map->map_type =3D=3D BPF_MAP_TYPE_SOCKMAP)
		ret =3D sock_map_update_common(map, *(u32 *)key, sk, flags);
    ...
}

If a process-context caller holds lock_sock(sk) (where sk->sk_lock.owned
is set and sk->sk_lock.slock is released), sk->sk_state can be observed as
TCP_LISTEN by sock_map_sk_state_allowed() and then transition to TCP_CLOSE
via tcp_disconnect() or the error rollback in inet_csk_listen_start()
before sock_map_link() tests sk->sk_state =3D=3D TCP_LISTEN.

Wouldn't sock_map_link() then see TCP_CLOSE instead of TCP_LISTEN, skip
the goto no_progs branch, and attach the map's programs and callbacks to a
socket that can subsequently re-enter TCP_LISTEN?

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index b9761af139892..aa904ded816f8 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -777,7 +777,18 @@ void tcp_bpf_clone(const struct sock *sk, struct soc=
k *newsk)
>  {
>  	struct proto *prot =3D newsk->sk_prot;
> =20
> -	if (is_insidevar(prot, tcp_bpf_prots))
> -		newsk->sk_prot =3D sk->sk_prot_creator;
> +	if (!is_insidevar(prot, tcp_bpf_prots))
> +		return;

[Severity: Critical]
Is gating the callback reset on is_insidevar(prot, tcp_bpf_prots) safe
against a concurrent sk_psock_drop() on the listening socket?

When an incoming connection clones the listener via
tcp_create_openreq_child() -> inet_csk_clone_lock() -> sk_clone_lock() ->
sock_copy(), neither the listener's socket lock nor sk_callback_lock is
held. In sock_copy(), sk_prot (before sk_dontcopy_begin) is copied in the
first memcpy(), while sk_data_ready and sk_write_space (after
sk_dontcopy_end) are copied in the second memcpy():

net/core/sock.c:sock_copy() {
    ...
	memcpy(nsk, osk, offsetof(struct sock, sk_dontcopy_begin));

	unsafe_memcpy(&nsk->sk_dontcopy_end, &osk->sk_dontcopy_end,
		      prot->obj_size - offsetof(struct sock, sk_dontcopy_end),
		      /* alloc is larger than struct, see sk_prot_alloc() */);
    ...
}

Concurrently, if the listener is removed from the sockmap, sk_psock_drop()
restores sk->sk_prot before restoring sk->sk_data_ready and
sk->sk_write_space:

net/core/skmsg.c:sk_psock_drop() {
    ...
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

If sock_copy() copies the already-restored sk_prot alongside the
not-yet-restored sk_data_ready or sk_write_space, won't
is_insidevar(prot, tcp_bpf_prots) evaluate to false in tcp_bpf_clone(),
leaving the child socket with the psock callbacks and allowing the same
unbounded self-recursion if the child is later added to a sockmap?

> +
> +	newsk->sk_prot =3D sk->sk_prot_creator;
> +	/*
> +	 * sock_map_link() gives a listener no programs, but a socket which got
> +	 * them in another state and listens now has the psock's sk_data_ready
> +	 * and sk_write_space, and sock_copy() has copied them.
> +	 * sk_psock_init() refuses a socket that has sk_user_data or a ULP, so
> +	 * what the psock replaced were the defaults of a TCP socket.
> +	 */
> +	newsk->sk_data_ready =3D sock_def_readable;
> +	newsk->sk_write_space =3D sk_stream_write_space;

[Severity: High]
In the scenario described by this comment=E2=80=94where a socket got psock
programs and callbacks in TCP_ESTABLISHED, disconnected via
tcp_disconnect(), and then entered TCP_LISTEN via inet_listen()=E2=80=94doe=
sn't
the listening socket itself still have sk_psock_verdict_data_ready or
sk_psock_strp_data_ready installed as sk->sk_data_ready?

While tcp_bpf_clone() restores the callbacks on newsk, the parent listener
sk retains the psock sk_data_ready callback. When a child connection
completes the handshake in tcp_child_process(), the stack notifies the
parent listener without holding the parent's socket lock:

net/ipv4/tcp_minisocks.c:tcp_child_process() {
    ...
		/* Wakeup parent, send SIGIO */
		if (state =3D=3D TCP_SYN_RECV && child->sk_state !=3D state)
			READ_ONCE(parent->sk_data_ready)(parent);
    ...
}

If parent->sk_data_ready is sk_psock_verdict_data_ready(), tcp_read_skb()
sees TCP_LISTEN and returns -ENOTCONN without calling
psock->saved_data_ready, so accept() is never woken. If
parent->sk_data_ready is sk_psock_strp_data_ready(), it also fails to wake
accept() and calls strp_data_ready(&psock->strp) without holding parent's
socket lock, violating sk_psock_strp_data_ready()'s locking requirement.

How does a socket that transitions from TCP_ESTABLISHED to TCP_LISTEN while
remaining in a sockmap wake up accept() when new connections arrive?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101192057.2296=
489-1-alexei.starovoitov@gmail.com?part=3D6
