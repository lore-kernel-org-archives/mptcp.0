Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AB9413791
	for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 03:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792379777; cv=none; b=D4pTGXoDUG4wwf+8x3TRIK6FUn/Lf2VUVFDLIySOqmZcj4wCPKQ7xqbvzw+DCoNRQidLohhueWwliv2vC1VjlRPbWhOFkXVYiG6DBLVb2pRr/bb5+ADlSMoW/ELVAfxX2STCBvCbmbPGgqfRVip1s/DNxOnJpUA2BSdtYGz5QJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792379777; c=relaxed/simple;
	bh=Ap3rUQBJxfJmoJj9WLZxXWNibPCtgV7oxi2WyVXb1YY=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=Rq4NfNbFSNs321W9VlTAhzkGHztsQHAF2O1YP9YbPXNGq88ijqV2F9GrTs5Qj2hkdS/KQmBzMxAW2uxFHEzc27Y4nSBjy8xmIi8mS7LCsSnnomWVuTMFBKtpwiJxY5U1PYf839y88z4qNdc5OYwUVgoCiLKrH2+mNFP1SmPjVyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSs6wOhI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSs6wOhI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF77E1F000C4;
	Mon, 19 Oct 2026 03:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792379768;
	bh=xoN1ZhiMEHlDAe7Hx+5mrPHzBRHRyIFyyX9BOxJFLjk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=hSs6wOhID2wWFTe5RfrDu9I5Ubhnsr32JLrsjWgVdmm4MNEGmgXLgapHwhnzAHLzw
	 u5az0LH/ICsqu1vvm573gIC6SxrhvEEfyVAuumaAOlrp86zVAcSP1PM7li8L7wvkiQ
	 Uz/2aPu1ofP82CiZZmOymzFT5frxurIo8qbOPTx5wcRn4EaDm1XYr9UbyVWXbnyT1K
	 mbFbMcIJHVzWrUkKW9x89eUctjsTBPohTSjdg+hxzlSSVaDBln4xG+Zq8PieHjZOq7
	 ijRzCH8UMpszuS8yPtkV4e3Nlo/T06K47isKxwZNdNsvPiYGVsQX+S8qW9OcaFbItY
	 V37F1rYqlYbVw==
Message-ID: <sashiko-outbox-176559@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v3 2/2] mptcp: kunit: add sockopt test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <398dbbf2562050831dae08e0a9058df6b91e575e.1792378794.git.tanggeliang@kylinos.cn>
References: <cover.1792378794.git.tanggeliang@kylinos.cn>
 <398dbbf2562050831dae08e0a9058df6b91e575e.1792378794.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 03:16:07 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] mptcp: kunit: kernel_bind() fails in mptcp_sockopt_test() when l=
o is down
- [Medium] mptcp: kunit: socket leak in mptcp_sockopt_test() on assertion f=
ailure
--

commit c3d92563f22262cac1e4a01a4a2c7de7fc36eb03
Author: Geliang Tang <geliang@kernel.org>

mptcp: kunit: add sockopt test

This commit adds a KUnit test suite for MPTCP socket options and lockdep
class separation across IPv4 and IPv6 sockets.

> diff --git a/net/mptcp/sockopt_test.c b/net/mptcp/sockopt_test.c
> new file mode 100644
> index 0000000000000..b4b9c40be92fe
> --- /dev/null
> +++ b/net/mptcp/sockopt_test.c
> @@ -0,0 +1,145 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <kunit/test.h>
> +
> +#include "protocol.h"
> +
> +#ifdef CONFIG_PROVE_LOCKING
> +static void mptcp_check_lockdep_class(struct kunit *test, struct sock *s=
k)
> +{
> +	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +	struct sock *ssk =3D msk->first;
> +
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ssk);
> +	KUNIT_EXPECT_PTR_NE(test,
> +			    sk->sk_lock.dep_map.key,
> +			    ssk->sk_lock.dep_map.key);
> +}
> +#endif
> +
> +static void mptcp_sockopt_test(struct kunit *test, sa_family_t family)
> +{
> +	struct socket *server_sock, *client_sock, *accepted_sock;
> +	struct msghdr send_msg =3D { 0 }, recv_msg =3D { 0 };
> +	struct sockaddr_storage server_addr;
> +	struct kvec send_vec, recv_vec;
> +	struct sockaddr_storage addr;
> +	char send_buf[] =3D "MPTCP";
> +	char recv_buf[32] =3D { 0 };
> +	int err, reuse =3D 1;
> +	int addrlen;
> +
> +	/* Initialize server address */
> +	memset(&addr, 0, sizeof(addr));
> +	if (family =3D=3D AF_INET6) {
> +		struct sockaddr_in6 *addr6 =3D (struct sockaddr_in6 *)&addr;
> +
> +		addr6->sin6_family =3D AF_INET6;
> +		addr6->sin6_port =3D htons(0);
> +		addr6->sin6_addr =3D in6addr_loopback;
> +		addrlen =3D sizeof(struct sockaddr_in6);
> +	} else {
> +		struct sockaddr_in *addr4 =3D (struct sockaddr_in *)&addr;
> +
> +		addr4->sin_family =3D AF_INET;
> +		addr4->sin_port =3D htons(0);
> +		addr4->sin_addr.s_addr =3D htonl(INADDR_LOOPBACK);
> +		addrlen =3D sizeof(struct sockaddr_in);
> +	}
> +
> +	/* Create server socket and test SO_REUSEADDR */
> +	err =3D sock_create_kern(&init_net, family, SOCK_STREAM, IPPROTO_MPTCP,
> +			       &server_sock);
> +	KUNIT_ASSERT_EQ(test, err, 0);
> +
> +	err =3D sock_common_setsockopt(server_sock, SOL_SOCKET, SO_REUSEADDR,
> +				     KERNEL_SOCKPTR(&reuse), sizeof(reuse));
> +	KUNIT_EXPECT_EQ(test, err, 0);
> +	KUNIT_EXPECT_EQ(test, (int)server_sock->sk->sk_reuse, SK_CAN_REUSE);
> +
> +	err =3D kernel_bind(server_sock, (struct sockaddr_unsized *)&addr,
> +			  addrlen);
> +	KUNIT_ASSERT_EQ(test, err, 0);

[Severity: Medium]
Will kernel_bind() fail with -EADDRNOTAVAIL when CONFIG_MPTCP_KUNIT_TEST=3Dy
runs at boot time?

When built-in, kunit_run_all_tests() runs during kernel_init_freeable()
before userspace starts. During do_initcalls(), loopback_net_init()
registers init_net.loopback_dev via gen_lo_setup() with only IFF_LOOPBACK
set (not IFF_UP).

Because 127.0.0.1 (via inetdev_event()) and ::1 (via addrconf_notify() ->
addrconf_init_auto_addrs() -> init_loopback()) are only configured when the
loopback device transitions to NETDEV_UP, binding server_sock to
INADDR_LOOPBACK or in6addr_loopback in init_net will fail in __inet_bind()
or __inet6_bind() if init_net.loopback_dev is still down.

> +
> +	/* Get the assigned port */
> +	err =3D kernel_getsockname(server_sock, (struct sockaddr *)&server_addr=
);
> +	KUNIT_ASSERT_EQ(test, err, addrlen);
> +
> +	err =3D kernel_listen(server_sock, 5);
> +	KUNIT_ASSERT_EQ(test, err, 0);
> +
> +	/* Create client socket and test SO_REUSEADDR */
> +	err =3D sock_create_kern(&init_net, family, SOCK_STREAM, IPPROTO_MPTCP,
> +			       &client_sock);
> +	KUNIT_ASSERT_EQ(test, err, 0);
> +
> +	err =3D sock_common_setsockopt(client_sock, SOL_SOCKET, SO_REUSEADDR,
> +				     KERNEL_SOCKPTR(&reuse), sizeof(reuse));
> +	KUNIT_EXPECT_EQ(test, err, 0);
> +	KUNIT_EXPECT_EQ(test, (int)client_sock->sk->sk_reuse, SK_CAN_REUSE);
> +
> +	/* Connect to server */
> +	err =3D kernel_connect(client_sock,
> +			     (struct sockaddr_unsized *)&server_addr,
> +			     addrlen, 0);
> +	KUNIT_ASSERT_EQ(test, err, 0);
> +
> +	/* Accept connection on server */
> +	err =3D kernel_accept(server_sock, &accepted_sock, 0);
> +	KUNIT_ASSERT_EQ(test, err, 0);
> +
> +	/* Send data from client */
> +	send_vec.iov_base =3D send_buf;
> +	send_vec.iov_len =3D strlen(send_buf);
> +	err =3D kernel_sendmsg(client_sock, &send_msg, &send_vec, 1,
> +			     strlen(send_buf));
> +	KUNIT_ASSERT_EQ(test, err, strlen(send_buf));
> +
> +	/* Receive data on server */
> +	recv_vec.iov_base =3D recv_buf;
> +	recv_vec.iov_len =3D sizeof(recv_buf);
> +	err =3D kernel_recvmsg(accepted_sock, &recv_msg, &recv_vec, 1,
> +			     sizeof(recv_buf), 0);
> +	KUNIT_ASSERT_EQ(test, err, strlen(send_buf));
> +
> +	/* Verify data */
> +	KUNIT_EXPECT_STREQ(test, recv_buf, send_buf);
> +
> +#ifdef CONFIG_PROVE_LOCKING
> +	mptcp_check_lockdep_class(test, client_sock->sk);
> +	mptcp_check_lockdep_class(test, accepted_sock->sk);
> +#endif
> +
> +	sock_release(accepted_sock);
> +	sock_release(client_sock);
> +	sock_release(server_sock);
> +}

[Severity: Medium]
Can mptcp_sockopt_test() leak server_sock, client_sock, or accepted_sock if
any of the preceding KUNIT_ASSERT_EQ() checks in mptcp_sockopt_test() or
KUNIT_ASSERT_NOT_ERR_OR_NULL() in mptcp_check_lockdep_class() fail?

When a KUNIT_ASSERT_* macro fails, it invokes __kunit_abort() ->
kunit_try_catch_throw() and terminates the test thread immediately before
reaching the sock_release() calls at the end of mptcp_sockopt_test(),
leaving the allocated kernel sockets open in init_net. Should these sockets
be registered with kunit_add_action_or_reset() or cleaned up via
KUNIT_EXPECT_* error paths?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792378794.gi=
t.tanggeliang@kylinos.cn?part=3D2
