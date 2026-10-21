Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792605322;
	b=ZwEk/Iw26F6JoYmmPtna6iQCodx+BGBF09nzhAJq/Oyy2nUPtz0+GwnE0xAe0ksYgyOe
	 PtqxyA8dXZaXHkPgZWGYj8ZVZc8rcdAjHxqL0x5Xo2MW5gqFJAXTffUaZaJ6JldUxwOUc
	 pcTFq+vSRt27rgz1wD6p8mYkpxbV3o19/uv5rH/u85mc0yf/AZM+bGvzJiMBU8Zoe7Nxj
	 gTXcRzoW8cyiKVViWbolrDtA31tUc6JkmdqzK8xDbuElggnn2AewQAvM3CtpflotAZ6x/
	 fB2zhilCDkjVfCGMYIj2gGBCXRzHvwdqpvvkfGfNSPffTteOlpheHVe1VGp0vtHb5gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605322;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=FpxRjj1VyN+423FgxmSQ4tVEn+shJ+ws34AzMeIbNlE=;
	b=r0MyV0bbbxTODdvnkh6PJ5lPzrxwBSUy7tIWUFsaKcMGod+gYJ7RHEUIUE1hyKutPeTP
	 D4RMVhgJDjNG/Hj1Q3Jo18T41ghNtBW0R7WC0F7xDa8TU6LTTwWRPhYg8k6crkkVy03qJ
	 Cjuz0j5qxfQkL+NP7UOmYFslubMtyOefhi2AjyO4FoI0AyLPvAcChJzQriAEZmpjpHJpP
	 LB7J7QeTJwCAEAEKYFCoZoY0gInyBk+i4IsAUEFg3SyV5izyleKdb2Qf0/McpQTyFMRnc
	 WkHdKsaG6hAkYZxUfBvtOtobMlPNz/hj1SRIzhlU0Mj6Sv1gU9Ah+iLwDYs/BYiYAPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PFPIdSvR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B99A606A31A
	for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 17:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PFPIdSvR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B5C1F000C2;
	Wed, 21 Oct 2026 17:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792605322;
	bh=FpxRjj1VyN+423FgxmSQ4tVEn+shJ+ws34AzMeIbNlE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PFPIdSvR/m7STCzJIY5U1xsNWGI1AgflrfL1cDm9nkH/vsXZSU91wuiaskLz0bMSu
	 W7l53WipmMCeMP8aH15xVe5taWmS75AFYZlX65Iy+k3TyXv3D68MjSbViDzgAm3zLH
	 Rj8IKfpt6+FaPIr6kTEA6HtMpeMOP7O3I3L3rqEKZ9Pp0qaheGReOEt6MNWfqxZeEO
	 /mpwgnEBp0o6KPiRz67D/B7Gw/6ReGPLFOyrLj+3+nQ1ixd9hq5CtFkjCyZpTgl+gs
	 gc9e4bgPC7Ar5em0FCyi/CYqFCRKZzDT2Hjj15ymUj5/HJHa1ATsqSu1iTNKlGyZhY
	 4cvD8Cm65jAJw==
Subject: Re: [PATCH mptcp-next v4 3/3] mptcp: kunit: add sockopt test
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, kuba@kernel.org
Date: Wed, 21 Oct 2026 17:55:21 +0000
Message-ID: <179260532129.3133.10682938300935459058@kernel.org>
In-Reply-To: =?utf-8?q?=3Cfdd33ceda25e9c54bf9c38c999034af7d6a6f08e=2E1792470?=
 =?utf-8?q?313=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3Cfdd33ceda25e9c54bf9c38c999034af7d6a6f08e=2E17924703?=
 =?utf-8?q?13=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
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

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] When the suite is built in, mptcp_sockopt_test() fails every
  time for both mptcp_sockopt_test_v4 and mptcp_sockopt_test_v6, because…
- [Medium] mptcp_sockopt_test() passes accepted_sock->sk to
  mptcp_check_lockdep_class() without checking that it is an MPTCP…
- [Low] Concern: the sockopt assertions…

--

mptcp: kunit: add sockopt test

This commit adds a KUnit suite that creates kernel MPTCP sockets in
init_net and sets SO_REUSEADDR, SO_BINDTODEVICE and SO_BINDTOIFINDEX on
them. It then connects a client to a listener and transfers data. With
CONFIG_PROVE_LOCKING it also checks that the MPTCP sockets and their first
subflows have distinct lockdep keys, for both IPv4 and IPv6.

> diff --git a/net/mptcp/sockopt_test.c b/net/mptcp/sockopt_test.c
> new file mode 100644
> index 0000000000000..f8ce69911cafd
> --- /dev/null
> +++ b/net/mptcp/sockopt_test.c
> @@ -0,0 +1,184 @@

[ ... ]

> +static void mptcp_test_reuseaddr(struct kunit *test, struct socket *sock)
> +{
> +	int reuse = 1;
> +	int err;
> +
> +	err = sock_common_setsockopt(sock, SOL_SOCKET, SO_REUSEADDR,
> +				     KERNEL_SOCKPTR(&reuse), sizeof(reuse));
> +	KUNIT_EXPECT_EQ(test, err, 0);
> +	KUNIT_EXPECT_EQ(test, (int)sock->sk->sk_reuse, SK_CAN_REUSE);

[Severity: Low]
This isn't a bug, but these checks only look at the msk's sk_reuse and
sk_bound_dev_if. The same applies to mptcp_test_bindtodevice() and
mptcp_test_bindtoifindex().

mptcp_setsockopt_sol_socket() already copies those values from the first
subflow:

net/mptcp/sockopt.c:mptcp_setsockopt_sol_socket() {
    ...
		ret = sk_setsockopt(ssk, SOL_SOCKET, optname, optval, optlen);
		if (ret == 0) {
			if (optname == SO_REUSEPORT)
				sk->sk_reuseport = ssk->sk_reuseport;
			else if (optname == SO_REUSEADDR)
				sk->sk_reuse = ssk->sk_reuse;
			else if (optname == SO_BINDTODEVICE)
				sk->sk_bound_dev_if = ssk->sk_bound_dev_if;
			else if (optname == SO_BINDTOIFINDEX)
				sk->sk_bound_dev_if = ssk->sk_bound_dev_if;
    ...
}

The test never creates an MP_JOIN subflow. That means the
sync_socket_options() and __mptcp_subflow_connect() changes from the
previous patch in the series ("mptcp: inherit sk_reuse and fix dev bind
override") are never exercised.

Would it be worth adding an extra subflow and checking sk_reuse and
sk_bound_dev_if on it as well?

[ ... ]

> +	mptcp_test_reuseaddr(test, server_sock);
> +
> +	mptcp_test_bindtodevice(test, server_sock);
> +
> +	err = kernel_bind(server_sock, (struct sockaddr_unsized *)&addr,
> +			  addrlen);
> +	KUNIT_ASSERT_EQ(test, err, 0);

[ ... ]

> +	mptcp_test_bindtoifindex(test, client_sock);
> +
> +	err = kernel_connect(client_sock,
> +			     (struct sockaddr_unsized *)&addr,
> +			     addrlen, 0);
> +	KUNIT_ASSERT_EQ(test, err, 0);

[Severity: Medium]
Can this kernel_connect() succeed when the suite is built in?

mptcp_test_bindtodevice() binds the listener to "lo" and
mptcp_test_bindtoifindex() binds the client to lo's ifindex. Neither one
checks IFF_UP. gen_lo_setup() registers lo with only IFF_LOOPBACK set:

drivers/net/loopback.c:gen_lo_setup() {
    ...
	dev->flags		= IFF_LOOPBACK;
    ...
}

Built-in KUnit suites run from kernel_init_freeable() through
kunit_run_all_tests(), before userspace can bring lo up. The only
in-kernel code that opens lo is ic_open_devs() under CONFIG_IP_PNP, and
tools/testing/kunit/configs/all_tests.config does not enable it.

With an oif bound, the connect path is
mptcp_connect()->tcp_v4_connect()->ip_route_connect(). In that path,
ip_route_output_key_hash_rcu() rejects the down device:

net/ipv4/route.c:ip_route_output_key_hash_rcu() {
    ...
		if (!(dev_out->flags & IFF_UP) || !__in_dev_get_rcu(dev_out)) {
			rth = ERR_PTR(-ENETUNREACH);
			goto out;
		}
    ...
}

This check is in the flowi4_oif branch and runs before the !fl4->daddr
loopback fallback, so using INADDR_ANY does not get around it.

For IPv6, tcp_v6_connect() turns the any-address destination into
in6addr_loopback with oif=lo. ::1 is only configured once lo goes up.

If so, the KUNIT_ASSERT_EQ() after kernel_connect() would abort both
mptcp_sockopt_test_v4 and mptcp_sockopt_test_v6 on every built-in run
(for example kunit.py run --alltests). The accept, data transfer and
lockdep checks would never run.

The commit message says:

  The test uses INADDR_ANY instead of INADDR_LOOPBACK to avoid binding
  failures when running during early boot before loopback device is up.

Is that accurate? INADDR_ANY seems to move the failure from kernel_bind()
to kernel_connect(). Even without the device binding, the down loopback
device would drop the SYN, and connect would block until it timed out.

Could the test bring lo up itself, for example with dev_change_flags()
under RTNL or in a dedicated netns with lo configured? Or could it call
kunit_skip() when lo is not IFF_UP?

[ ... ]

> +#ifdef CONFIG_PROVE_LOCKING
> +	mptcp_check_lockdep_class(test, client_sock->sk);
> +	mptcp_check_lockdep_class(test, accepted_sock->sk);
> +#endif
> +}

[Severity: Medium]
Is accepted_sock->sk guaranteed to be an MPTCP socket here?

On the passive side, subflow_syn_recv_sock() falls back to plain TCP if
mptcp_sk_clone_init() fails its GFP_ATOMIC allocation. It also falls back
if the MPC ACK options are missing:

net/mptcp/subflow.c:subflow_syn_recv_sock() {
    ...
			ctx->conn = mptcp_sk_clone_init(listener->conn, &mp_opt, child, req);
			if (!ctx->conn) {
				fallback = true;
				goto fallback;
			}
    ...
}

mptcp_stream_accept() then takes the tcpfallback branch and puts a plain
tcp_sock into newsock:

net/mptcp/protocol.c:mptcp_stream_accept() {
    ...
tcpfallback:
		newsk->sk_kern_sock = arg->kern;
		lock_sock(newsk);
		__inet_accept(sock, newsock, newsk);
		/* we are being invoked after accepting a non-mp-capable
		 * flow: sk is a tcp_sk, not an mptcp one.
    ...
}

kernel_accept() still returns 0. The client falls back too, so the
"MPTCP" payload still arrives and the recvmsg and STREQ assertions pass.

mptcp_check_lockdep_class() then calls mptcp_sk(sk) and
READ_ONCE(msk->first) on a tcp_sock. That reads an unrelated TCP field at
the mptcp_sock offset.

KUNIT_ASSERT_NOT_ERR_OR_NULL() only rejects NULL and ERR values. Could a
non-zero garbage value get dereferenced through ssk->sk_lock.dep_map.key
and oops the kernel instead of failing the test? A local plain TCP client
that connects to the init_net listener first could hit the same branch.

Would checking accepted_sock->sk->sk_protocol == IPPROTO_MPTCP before
calling mptcp_sk() avoid this?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1792470313.git.tanggeliang%40kylinos.cn
