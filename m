Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792486532;
	b=G2mCHaULPTpvalk/D+wBIl4j18NqfxhMhxcB+FhzhHTaFid9XV+zJEUf71FCuyVfoa9C
	 1B760z9HxOP0wWPcin5SU5OBfOVVaWHDBDPAkxNZqx46gkUaPDDISTJ/RpAFUM6jiWWfD
	 XuhhPgTpqxF3TKL7tu8J0KMhrs4oQjwcfo35VSaO1MoBOLkcyw9DT0/DI/RJfCgc3XAKO
	 p6a4VbiWG91rBd3/DvZh1WeIxurmAVoby85tEB+8KqC5qHIdnlzU3pRs0UQs5ij0Ms2x1
	 yzaH935LReaGNtt8G3IKhj4eQ8ufm7Zj2iNtj0jH9gcH4JRG2w2fW62X6mWtk6BloPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792486532;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1cdF8aZXwCWWm3srLGnn3f/gNyq5KhqCbV0jj6pfj78=;
	b=mYs+vObiRrxU3i+hvJ2phlHGJuMGTawk6r7hApfGd7nnGCIDqag+Vn6futafNlUa2bMS
	 yf/oegAUzXkTkZOqNXkg4iWQDo6CEbSdHHYpnnQU9gFeBICNRBMG0XJodZAdLjZEMldPr
	 KTzTT4EGxgSbtl0AxCz+BaLR3flLov4BknNcK4ev2OM/1JuO+iKNKMmnV2SQrHOqn2Sdy
	 7imsU0KN8vxodWlylSoD11yuOCuRsTR2w/8VcTFTNLwrBUJAuAflyK6BoWZOhHbY6I9Lm
	 EGNrp0PA6WpMngPxGQWGlN33qjUa4VY1XjR7PKJXpdHKnIsv/u+FPN1uPqY/6UC1qBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mXiRhNXN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511B3606A319
	for <mptcp@lists.linux.dev>; Tue, 20 Oct 2026 08:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mXiRhNXN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCDA91F000C4;
	Tue, 20 Oct 2026 08:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792486532;
	bh=1cdF8aZXwCWWm3srLGnn3f/gNyq5KhqCbV0jj6pfj78=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=mXiRhNXNLJN/ZWLS9hl12mryQ2GDzYw5pFqlxZdfHyHX/jTqITqpxIv2bKm6V++Q8
	 1YufWD2s2BvjInTZX4K2w6R0Iv1QsfXV0f5Efmek7G4SktrhaO89tkXeD1HGmL5XFF
	 /P7x8/M2tVd6KqVyaBKa9bt+w4W+V5URyrU9VhMun6x/ikxCsWkrzGk5Ub8sEQl4fi
	 6VT9zepdYsZihHYn508402DY5/TNn73bEj2d29j0FJyNXuwIl6oQ1TqBlPSGvI4tjF
	 v31zmgMLcgPkpnOQu9vaHG/DJf6g7SQ6J4e6tb9freq/bwgintbg5tuGshfh9QE9tx
	 KhT57/Vfyy/zg==
Message-ID: <sashiko-outbox-178653@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v4 3/3] mptcp: kunit: add sockopt test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <fdd33ceda25e9c54bf9c38c999034af7d6a6f08e.1792470313.git.tanggeliang@kylinos.cn>
References: <cover.1792470313.git.tanggeliang@kylinos.cn>
 <fdd33ceda25e9c54bf9c38c999034af7d6a6f08e.1792470313.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 08:55:31 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mptcp: kunit: mptcp_sockopt_test() fails in kernel_connect() whe=
n lo is down
--

commit d196ed613cae4d93a15c8207b2a196e0356c9e7d
Author: Geliang Tang <geliang@kernel.org>

mptcp: kunit: add sockopt test

This commit adds a KUnit test for MPTCP socket options (SO_REUSEADDR,
SO_BINDTODEVICE, and SO_BINDTOIFINDEX) and lockdep class separation between
MPTCP sockets and their subflows across IPv4 and IPv6.

> diff --git a/net/mptcp/sockopt_test.c b/net/mptcp/sockopt_test.c
> new file mode 100644
> index 0000000000000..f8ce69911cafd
> --- /dev/null
> +++ b/net/mptcp/sockopt_test.c
> @@ -0,0 +1,184 @@

[ ... ]

> +static void mptcp_sockopt_test(struct kunit *test, sa_family_t family)
> +{
> +	struct socket *server_sock, *client_sock, *accepted_sock;
> +	struct msghdr send_msg =3D { 0 }, recv_msg =3D { 0 };
> +	struct sockaddr_storage addr =3D { 0 };
> +	struct kvec send_vec, recv_vec;
> +	char send_buf[] =3D "MPTCP";
> +	char recv_buf[32] =3D { 0 };
> +	int err, addrlen;
> +
> +	if (family =3D=3D AF_INET6) {
> +		struct sockaddr_in6 *addr6 =3D (struct sockaddr_in6 *)&addr;
> +
> +		addr6->sin6_family =3D AF_INET6;
> +		addr6->sin6_port =3D htons(0);
> +		addr6->sin6_addr =3D in6addr_any;
> +		addrlen =3D sizeof(struct sockaddr_in6);
> +	} else {
> +		struct sockaddr_in *addr4 =3D (struct sockaddr_in *)&addr;
> +
> +		addr4->sin_family =3D AF_INET;
> +		addr4->sin_port =3D htons(0);
> +		addr4->sin_addr.s_addr =3D htonl(INADDR_ANY);
> +		addrlen =3D sizeof(struct sockaddr_in);
> +	}
> +
> +	err =3D sock_create_kern(&init_net, family, SOCK_STREAM, IPPROTO_MPTCP,
> +			       &server_sock);
> +	KUNIT_ASSERT_EQ(test, err, 0);
> +	err =3D kunit_add_action_or_reset(test, sock_release_wrapper,
> +					server_sock);
> +	KUNIT_ASSERT_EQ(test, err, 0);
> +
> +	mptcp_test_reuseaddr(test, server_sock);
> +
> +	mptcp_test_bindtodevice(test, server_sock);
> +
> +	err =3D kernel_bind(server_sock, (struct sockaddr_unsized *)&addr,
> +			  addrlen);
> +	KUNIT_ASSERT_EQ(test, err, 0);
> +
> +	err =3D kernel_getsockname(server_sock, (struct sockaddr *)&addr);
> +	KUNIT_ASSERT_EQ(test, err, addrlen);
> +
> +	err =3D kernel_listen(server_sock, 5);
> +	KUNIT_ASSERT_EQ(test, err, 0);
> +
> +	err =3D sock_create_kern(&init_net, family, SOCK_STREAM, IPPROTO_MPTCP,
> +			       &client_sock);
> +	KUNIT_ASSERT_EQ(test, err, 0);
> +	err =3D kunit_add_action_or_reset(test, sock_release_wrapper,
> +					client_sock);
> +	KUNIT_ASSERT_EQ(test, err, 0);
> +
> +	mptcp_test_bindtoifindex(test, client_sock);
> +
> +	err =3D kernel_connect(client_sock,
> +			     (struct sockaddr_unsized *)&addr,
> +			     addrlen, 0);
> +	KUNIT_ASSERT_EQ(test, err, 0);

[Severity: Medium]
The commit message notes that INADDR_ANY is used instead of INADDR_LOOPBACK
to avoid failures when running during early boot before the loopback device
is up. However, will kernel_connect() in mptcp_sockopt_test() still fail
when CONFIG_MPTCP_KUNIT_TEST=3Dy runs built-in at early boot?

When kunit_run_all_tests() executes from kernel_init_freeable(), the "lo"
device in init_net has been registered by loopback_net_init() without
IFF_UP set, so the NETDEV_UP handlers in inetdev_event() and
addrconf_notify() -> init_loopback() have not yet configured 127.0.0.1/8 or
::1/128.

While binding server_sock to INADDR_ANY or in6addr_any allows kernel_bind()
and kernel_listen() to succeed, client_sock is bound to lo->ifindex via
mptcp_test_bindtoifindex() before calling kernel_connect():

For AF_INET, mptcp_connect() -> tcp_v4_connect() -> ip_route_connect() ->
ip_route_output_key_hash_rcu() checks fl4->flowi4_oif in net/ipv4/route.c:

	if (fl4->flowi4_oif) {
		dev_out =3D dev_get_by_index_rcu(net, fl4->flowi4_oif);
		rth =3D ERR_PTR(-ENODEV);
		if (!dev_out)
			goto out;

		/* RACE: Check return value of inet_select_addr instead. */
		if (!(dev_out->flags & IFF_UP) || !__in_dev_get_rcu(dev_out)) {
			rth =3D ERR_PTR(-ENETUNREACH);
			goto out;
		}

Because "lo" does not have IFF_UP set, route lookup fails with
-ENETUNREACH.

For AF_INET6, mptcp_connect() -> tcp_v6_connect() rewrites in6addr_any to
in6addr_loopback in net/ipv6/tcp_ipv6.c:

	if (ipv6_addr_any(&usin->sin6_addr)) {
		if (ipv6_addr_v4mapped(&sk->sk_v6_rcv_saddr))
			ipv6_addr_set_v4mapped(htonl(INADDR_LOOPBACK),
					       &usin->sin6_addr);
		else
			usin->sin6_addr =3D in6addr_loopback;
	}

Subsequent route and source-address lookup via ip6_dst_lookup_flow() ->
ip6_dst_lookup_tail() -> ip6_route_get_saddr() -> ipv6_dev_get_saddr() then
fails with -EADDRNOTAVAIL or -ENETUNREACH because "lo" has no IPv6 address
or route while down (and __dev_queue_xmit() also drops packets with
-ENETDOWN when !(dev->flags & IFF_UP)).

Should the test run in a dedicated network namespace with its loopback
device brought up, or ensure "lo" is up before connecting?

[ ... ]

> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("KUnit tests for MPTCP sockopt");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792470313.gi=
t.tanggeliang@kylinos.cn?part=3D3
