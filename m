Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792512441;
	b=aB/MGoOFj7n2s2NKWU0IbvBmhDxO8E3JB4zurYDRUe2BD6P1Vrs4fvz0bNNcFIT2s1+P
	 iYzjz0Rdjwo6lisjdsfjczqbpAYascg5JNjwhnDAsJ7vtf1GGDOC2SYO/CDWAXWjLwCkY
	 O57leNIa4OGcGU4dLDSTQhfFaHnve+OJQVOBL4350ZN2RWE0P5w+aCYkif6F0dTubvUYs
	 cfkukAO+fJzMuD3bxGH2Q+YuS5D03HRerWCX9Ou2BM2H2kPiPzLXxhgjwfOpq10eulVPG
	 yMEiOJcxZ7yqBfGXJGE9B++dOcwDPoB48IjtUcryOF9XH+TcTExKzWjDUbU6M2XVs3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792512441;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=VQx2a/dS4Gb1kXbZNild2IxqxxbbMst8sQabNMkEt44=;
	b=nlfuCgYK/AxFu0Bz7FQj278W8dZ4kHmfRb04tmHeoM6TANFb+76RXdWA/O/nMS1YqSDP
	 CDwazkg3h9njCFykoVDzD6dJj9CPyYtuKMav8PLiUk5kdCPjL2xwzTbkgYal43HFV5+et
	 vhC1B9uLomGA9raW4TQlN/sRhW7w+UtkPmGQjkysuGnYh08ZUO+EYEee2WtzIvbxMKnGF
	 9usNhipZOAGf+OQqliAK7xCkbhwFJsVLVSvB6W0NJIx0szDnTHZKLRSkBJ0zEmMMVPoKr
	 PItQ7W6SN7CnL+2BlRdLNfq8CYQ3653IswzcRC8X4Jj8PLXF7OCClQZMK1+aKC/ApDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LkFav1X3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F404606A31A
	for <mptcp@lists.linux.dev>; Tue, 20 Oct 2026 16:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LkFav1X3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE6F1F000C4;
	Tue, 20 Oct 2026 16:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792512441;
	bh=VQx2a/dS4Gb1kXbZNild2IxqxxbbMst8sQabNMkEt44=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LkFav1X3mB2+Vj8h9r6mOXOF6z6jrjgsZzuyGO2a1JsGOsTkauWTjyWkLrfdbjkuv
	 mf3tTuV88KFs88sAvAh0BYkS9J3jPfAnRHa9n/RjVsN0jWCrSXAGyfsei2CuDMiJnH
	 80KayEkGdg6Aje0ox6kxtkRTul952esWx17HcrM4HBll2cVLRpM25TzRJ6ss//HDAK
	 B/ZfNqVaXNfduXnVC4Yt/qnPirdQeqAp/yFoqwRSMCwptLEbLCFOrIht1DgxKLfN8t
	 bY7NRs5U8MaebOOvR8u3+SDnl6Z4fPjcEvvvLVQU/vJP/PEsKUtds4jrqKDMAVbOn1
	 nYOygTPdbDiAA==
Subject: Re: [PATCH mptcp-next v3 2/2] mptcp: kunit: add sockopt test
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, kuba@kernel.org
Date: Tue, 20 Oct 2026 16:06:56 +0000
Message-ID: <179251241642.3133.7263923768840837613@kernel.org>
In-Reply-To: =?utf-8?q?=3C398dbbf2562050831dae08e0a9058df6b91e575e=2E1792378?=
 =?utf-8?q?794=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3C398dbbf2562050831dae08e0a9058df6b91e575e=2E17923787?=
 =?utf-8?q?94=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] mptcp_sockopt_test() in net/mptcp/sockopt_test.c binds to
  127.0.0.1 or ::1 in init_net (lines 31-61).
- [Medium] Under CONFIG_PROVE_LOCKING, mptcp_sockopt_test() passes
  accepted_sock->sk to mptcp_check_lockdep_class() (sockopt_test.c:109).
- [Low] The MPTCP_KUNIT_TEST help text in net/mptcp/Kconfig (line 31) was
  changed to "Currently covers the MPTCP crypto and token helpers, and…
- [Low] mptcp_sockopt_test() releases server_sock, client_sock and
  accepted_sock only at the end of the function (sockopt_test.c:112-114).

--

mptcp: kunit: add sockopt test

This adds a KUnit suite that creates kernel MPTCP sockets in init_net,
sets SO_REUSEADDR, connects over loopback and transfers data. With
CONFIG_PROVE_LOCKING it also checks that the client and accepted MPTCP
sockets use a different lockdep key than their first subflow. Both IPv4
and IPv6 are covered.

> diff --git a/net/mptcp/Kconfig b/net/mptcp/Kconfig
> index a9f58edc354c..cdae7be802fb 100644
> --- a/net/mptcp/Kconfig
> +++ b/net/mptcp/Kconfig
> @@ -28,7 +28,7 @@ config MPTCP_KUNIT_TEST
>  	depends on KUNIT
>  	default KUNIT_ALL_TESTS
>  	help
> -	  Currently covers the MPTCP crypto and token helpers.
> +	  Currently covers the MPTCP crypto and token helpers, and sockopt tests
>  	  Only useful for kernel devs running KUnit test harness and are not
>  	  for inclusion into a production build.

[Severity: Low]
This isn't a bug, but the new help line has lost its trailing period, so
it runs into the "Only useful for kernel devs ..." sentence after it.

[ ... ]

> diff --git a/net/mptcp/sockopt_test.c b/net/mptcp/sockopt_test.c
> new file mode 100644
> index 000000000000..b4b9c40be92f
> --- /dev/null
> +++ b/net/mptcp/sockopt_test.c
> @@ -0,0 +1,145 @@

[ ... ]

> +#ifdef CONFIG_PROVE_LOCKING
> +static void mptcp_check_lockdep_class(struct kunit *test, struct sock *sk)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct sock *ssk = msk->first;
> +
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ssk);
> +	KUNIT_EXPECT_PTR_NE(test,
> +			    sk->sk_lock.dep_map.key,
> +			    ssk->sk_lock.dep_map.key);
> +}
> +#endif

[Severity: Medium]
What happens here if the accepted socket fell back to plain TCP?

mptcp_sockopt_test() passes accepted_sock->sk to this helper. The helper
casts it with mptcp_sk() and reads msk->first, and it never checks
sk_is_mptcp() or sk->sk_protocol first.

On passive fallback, mptcp_stream_accept() grafts the plain TCP subflow
onto the new socket:

net/mptcp/protocol.c:mptcp_stream_accept() {
    ...
tcpfallback:
		newsk->sk_kern_sock = arg->kern;
		lock_sock(newsk);
		__inet_accept(sock, newsock, newsk);
    ...
}

When that happens, accepted_sock->sk is a struct tcp_sock. msk->first then
reads unrelated tcp_sock bytes, and the resulting pointer is dereferenced
for ssk->sk_lock.dep_map.key. KUNIT_ASSERT_NOT_ERR_OR_NULL() only catches
NULL and ERR_PTR values.

Passive fallback does not need malformed input. Some examples:

- The client is in the active-disable window, so mptcp_connect() calls
  mptcp_early_fallback(..., MPTCP_MIB_MPCAPABLEACTIVEDISABLED) and sends
  a plain SYN.
- Token allocation fails in mptcp_connect().
- mptcp_sk_clone_init() fails in subflow_syn_recv_sock(), which then
  sets fallback = true.
- Another local process connects with plain TCP to the ephemeral
  listening port in init_net before the test client does.
  kernel_accept() takes whichever connection is queued first.

Send and recv still work over TCP in each of these cases, so the test
gets as far as this cast. The test also never checks that MPTCP was
actually negotiated.

Could the test confirm that accepted_sock->sk really is an MPTCP socket
before it dereferences msk->first?

[ ... ]

> +	err = kernel_bind(server_sock, (struct sockaddr_unsized *)&addr,
> +			  addrlen);
> +	KUNIT_ASSERT_EQ(test, err, 0);

[Severity: Medium]
Can this bind succeed when the suite is built in?

The test binds to 127.0.0.1 or ::1 in init_net but never brings lo up.
The kernel does not set IFF_UP on lo by itself. The only in-kernel path
that opens it is ic_open_devs(), and ip_auto_config() skips that unless
ip= is on the command line:

net/ipv4/ipconfig.c:ip_auto_config() {
    ...
	if (!ic_enable)
		return 0;
    ...
}

The loopback addresses are only installed after lo gets NETDEV_UP. Until
then, __inet_bind() fails here:

net/ipv4/af_inet.c:__inet_bind() {
    ...
	err = -EADDRNOTAVAIL;
	if (!inet_addr_valid_or_nonlocal(net, inet, addr->sin_addr.s_addr,
	                                 chk_addr_ret))
		goto out;
    ...
}

The IPv6 bind fails the same way.

Built-in suites run from kernel_init_freeable() through
kunit_run_all_tests(), right after do_basic_setup(). That is before
userspace has a chance to run "ip link set lo up".

MPTCP_KUNIT_TEST defaults to KUNIT_ALL_TESTS. Won't both the v4 and v6
cases fail in a normal kunit.py or KUNIT_ALL_TESTS run, before the
lockdep check is reached?

Until now MPTCP_KUNIT_TEST only covered pure unit tests (crypto and
token). Neither the commit message nor the Kconfig help says this test
has to run as a module after lo is up.

Other KUnit tests that need a live netdev open it themselves. For
example, net/mctp/test/utils.c calls dev_open(ndev, NULL).

[ ... ]

> +#ifdef CONFIG_PROVE_LOCKING
> +	mptcp_check_lockdep_class(test, client_sock->sk);
> +	mptcp_check_lockdep_class(test, accepted_sock->sk);
> +#endif
> +
> +	sock_release(accepted_sock);
> +	sock_release(client_sock);
> +	sock_release(server_sock);
> +}

[Severity: Low]
Does a failed assertion leak server_sock, client_sock and accepted_sock?

These sock_release() calls are the only cleanup in the test. Between
sock_create_kern() and here there are many KUNIT_ASSERT_*() checks,
including the one in mptcp_check_lockdep_class().

A failed assertion ends the test thread through kunit_try_catch_throw():

lib/kunit/try-catch.c:kunit_try_catch_throw() {
    ...
	try_catch->try_result = -EFAULT;
	kthread_exit(0);
}

That skips these releases. No cleanup is registered either, for example
through kunit_add_action_or_reset().

A failure after the server socket is created leaks that MPTCP socket and
its subflow. A later failure also leaks the client and accepted sockets,
plus the established loopback connection in init_net.

In a built-in run with lo down, the kernel_bind() assertion above already
fails, so server_sock leaks in both the v4 and v6 cases.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1792378794.git.tanggeliang%40kylinos.cn
