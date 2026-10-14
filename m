Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D854E50C6
	for <mptcp@lists.linux.dev>; Wed, 14 Oct 2026 09:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791970939; cv=none; b=iQPYwA59np01psPc39fuSZi9Y6grCity2zOBQPfqW1N0shozmKA+6YaycWx4lZLXVF79vO03C72NkZC4tiETdpw3xEn8WQpNjTH4dacR+2SQ47rtTxLV/GGtfov4FWvu5KzChZAM8R1DHo8j0LLNoJvMIzA9Wdc9iax/HgziaSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791970939; c=relaxed/simple;
	bh=/Oz1rsphHz4ewBvUsT8kT3GRrOA8sx6hjpdz1E72Nio=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=G15Z5pWVwAr3q3ERF89eXVWu+LErqyoIN3UWmqwnvEcdWqiAboM1iKn5qwueVjiCKYuA6AXxh1KxAJs6VU2tIqimNjJ5fXfsNXPXFr3le4gde5vh3X0MtaRdPSM0VTXAWeV/28VVYjwfn+kbEUrgX+yjvZu3yBEaQ1EVxXTaPJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpR7AFzO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpR7AFzO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B61E1F0089F;
	Wed, 14 Oct 2026 09:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791970938;
	bh=xu3GgfrZK7fw9QVOk4Wc0Ep4/h7Fbdx46Dkrb4gVkPs=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=kpR7AFzOQmOKvtY26PH03lnn5UeXx1/NZYkmd3oOG6DvlAA5RX8J8kv0idiksb4H2
	 vk7np1//l6cVRlRKnRPTwDOC6BL+9KN5W30KE1pHeH7+0+7VpdYJH/hkqRmcXt7pZt
	 rg/2wSvaPy3OtHaVfJSF4SAlfB3yBgVPoENJhZLgu9s8llhRHDP9rji0+NNzEa+1B8
	 IXZfZLJJgsIy1LygpwH/BCnehTizOwwmwfhVrdbrvhBxZzBh7nclgwaLHF8w+OXEGx
	 W/SAM26vAKpaYhub2CoibnYFtycSGRlx0h43RDONE7hfXwrqYT6J0IgxYSdhHXIr8h
	 sZIWUseQ6fSog==
Message-ID: <sashiko-outbox-171084@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next 1/2] tls: implement tls_disconnect
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <6ffac9e36dab9b4f5fdb6e55a744b35f0d51ffb4.1791967771.git.tanggeliang@kylinos.cn>
References: <cover.1791967771.git.tanggeliang@kylinos.cn>
 <6ffac9e36dab9b4f5fdb6e55a744b35f0d51ffb4.1791967771.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 09:42:17 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] net/tls: double free of tls_context on concurrent connect(AF_UNSPE=
C)
- [High] net/tls: memory leak of TLS_HW contexts due to unconditional sk_de=
struct overwrite
- [High] net/tls: NULL pointer dereference in lockless socket ops on concur=
rent disconnect
- [High] tls: UAF in recvmsg/sendmsg due to concurrent tls_disconnect
- [High] tls: memory leak of HW offload context due to unconditional sk_des=
truct restore
--

commit c85d98242c0f64ea4b94701ff52f11b27b61f2a3
Author: Geliang Tang <geliang@kernel.org>

tls: implement tls_disconnect

Implement disconnect support for TLS sockets via connect(AF_UNSPEC).
The handler invokes the underlying disconnect() first, then on success
cancels TX work (for TLS_SW), calls tls_sk_proto_free() to restore
original protocol operations and clear TLS state, cleans up RX context
and frees the TLS context.

> diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> index 8bdb78718a8d4..d00e56af628a0 100644
> --- a/net/tls/tls_main.c
> +++ b/net/tls/tls_main.c

[ ... ]

> -static void tls_sk_proto_close(struct sock *sk, long timeout)
> +static void tls_sk_proto_free(struct sock *sk,
> +			      struct tls_context *ctx,
> +			      bool free_ctx)
>  {
>  	struct inet_connection_sock *icsk =3D inet_csk(sk);
> -	struct tls_context *ctx =3D tls_get_ctx(sk);
>  	long timeo =3D sock_sndtimeo(sk, 0);
> -	bool free_ctx;
> -
> -	if (ctx->tx_conf =3D=3D TLS_SW)
> -		tls_sw_cancel_work_tx(ctx);
> -
> -	lock_sock(sk);
> -	free_ctx =3D ctx->tx_conf !=3D TLS_HW && ctx->rx_conf !=3D TLS_HW;
> =20
>  	if (ctx->tx_conf !=3D TLS_BASE || ctx->rx_conf !=3D TLS_BASE)
>  		tls_sk_proto_cleanup(sk, ctx, timeo);
> =20
>  	write_lock_bh(&sk->sk_callback_lock);
> -	if (free_ctx)
> -		rcu_assign_pointer(icsk->icsk_ulp_data, NULL);
>  	WRITE_ONCE(sk->sk_prot, ctx->sk_proto);
> +	if (sk->sk_socket)
> +		WRITE_ONCE(sk->sk_socket->ops, ctx->sk_proto_ops);
>  	if (sk->sk_write_space =3D=3D tls_write_space)
>  		sk->sk_write_space =3D ctx->sk_write_space;
> +	if (sk->sk_destruct =3D=3D tls_device_sk_destruct)
> +		sk->sk_destruct =3D ctx->sk_destruct;

[Severity: High]
For hardware-offloaded TLS sockets (TLS_HW), free_ctx evaluates to false. T=
his
means tls_ctx_free() is intentionally skipped so the context can be cleaned=
 up
asynchronously later.

However, this code unconditionally unhooks tls_device_sk_destruct and resto=
res
the original socket destructor. Does this completely bypass the hardware
offload cleanup and permanently leak the tls_context and associated NIC
hardware state when the socket is ultimately destroyed?

> +	if (free_ctx) {
> +		rcu_assign_pointer(icsk->icsk_ulp_data, NULL);

[Severity: High]
When tls_disconnect() is called, it can run concurrently with lockless
operations like setsockopt() or poll() on the same file descriptor.

If tls_disconnect() sets icsk_ulp_data to NULL here while tls_setsockopt() =
or
tls_sk_poll() are fetching it locklessly via tls_get_ctx(), won't those
functions dereference a NULL pointer since they don't validate the pointer
before dereferencing ctx?

> +		if (icsk->icsk_ulp_ops) {
> +			/* Balance try_module_get in __tcp_ulp_find_autoload */
> +			module_put(icsk->icsk_ulp_ops->owner);
> +			icsk->icsk_ulp_ops =3D NULL;
> +		}
> +	}
>  	write_unlock_bh(&sk->sk_callback_lock);
> -	release_sock(sk);
>  	if (ctx->tx_conf =3D=3D TLS_SW)
>  		tls_sw_free_ctx_tx(ctx);
> +}

[ ... ]

> @@ -904,7 +943,52 @@ static int tls_setsockopt(struct sock *sk, int level=
, int optname,
> =20
>  static int tls_disconnect(struct sock *sk, int flags)
>  {
> -	return -EOPNOTSUPP;
> +	struct tls_context *ctx;
> +	bool free_ctx;
> +	int rc;
> +
> +	ctx =3D tls_get_ctx(sk);
> +	if (!ctx)
> +		return 0;
> +
> +	if (!ctx->sk_proto->disconnect)
> +		return -EOPNOTSUPP;
> +
> +	set_bit(TLS_DISCONNECTING, &ctx->flags);

[Severity: High]
Two threads can concurrently call connect() with AF_UNSPEC on the same sock=
et
file descriptor.

If thread 1 enters tls_disconnect(), sets the TLS_DISCONNECTING bit, and
temporarily drops the socket lock to wait for disable_delayed_work_sync(),
thread 2 can acquire the lock and enter tls_disconnect() as well.

Since set_bit() is used instead of test_and_set_bit() to abort, thread 2 wi=
ll
resolve the same ctx pointer and proceed. Will this result in both threads
sequentially executing tls_sk_proto_free() and tls_ctx_free(), causing a
double free of the contexts?

> +
> +	rc =3D ctx->sk_proto->disconnect(sk, flags);
> +	if (rc) {
> +		clear_bit(TLS_DISCONNECTING, &ctx->flags);
> +		return rc;
> +	}

[ ... ]

> +	if (ctx->rx_conf =3D=3D TLS_SW) {
> +		struct tls_sw_context_rx *sw_ctx =3D tls_sw_ctx_rx(ctx);
> +
> +		release_sock(sk);
> +		tls_strp_done(&sw_ctx->strp);
> +		tls_sw_free_ctx_rx(ctx);
> +		lock_sock(sk);
> +	}
> +
> +	if (free_ctx)
> +		tls_ctx_free(sk, ctx);

[Severity: High]
Threads calling tls_sw_recvmsg() or tls_sw_sendmsg() cache pointers to the
RX/TX contexts and then temporarily drop the socket lock to wait for data or
memory via sk_wait_event() or sk_stream_wait_memory().

If a concurrent disconnect triggers tls_disconnect(), it acquires the
socket lock and synchronously frees the RX and TX contexts here.

When the waiting recvmsg or sendmsg thread wakes up, won't it re-acquire the
socket lock and use its locally cached context pointer, leading to a
use-after-free read or write?

> +
> +	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791967771.gi=
t.tanggeliang@kylinos.cn?part=3D1
