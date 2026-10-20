Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792485870;
	b=SrV1LjHwNkn0YuEEm0zrNZIshNDtrZy2yvRDnZMSvp3a7y+AlAIkmM2BPfFq39NhfW6o
	 bkIPwXjiPhNbQuLczR6Z/6ozzqCarwjmz3plZqO1ipROebkAB6WteygMMRUAfuK74deYT
	 NBSJAr3oBn5tdJvEXyMpmk62mGlhxLp2lCrCBm00l6XnWiga+smBv9WS5HN4ULP/c1RM9
	 61dEi56QJhSk4GDNTOmUEtcoi3/PXE9NSsv2Lw53Onniu4ukEoETWbWRvfag/1tjvoP4e
	 uWLqpAJHct4GQft1sPNZQw/ymY0iOp18ymLfO96SH2mxIMWC5XWa4lMfK76kmM62yZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792485870;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qdZiXzT4CJkHQlqb7iSDmu1qfmRJcpjD97jm3kVH3Cc=;
	b=AlKqSo5ZjPlxu3nOYTlImAA7ln7c3n9icJPWIDwXeBNcdZrtpGx+EYHUiHQ5Hpr3l1Ng
	 CBwrXwbmhEba2YAhszzEOohOVNCwv/pOXJAL43TeH5xVcWi9m1J1KBjVziiB8KmwbEKcC
	 vW+vTSFEs85C3RiqzG1FlF9y6y8tyCje9sdlEUjwndr+nSDfFwRIwt/y4n30NBNyNBTSz
	 zijGw0sCaQHeXFxUpsV5SN9geLzDP4PJZFP/+7U1oiBDuZt3MuAyUIS56sI772DZX/1oo
	 LjwItRAw3MP7ZfwkS0elVOlag/E5ud5KkRU3GRxN5HOfLe6SPrTyHC6xJxq4HRbXLiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B6op7VOM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FC1606A31B
	for <mptcp@lists.linux.dev>; Tue, 20 Oct 2026 08:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B6op7VOM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A50C1F000C6;
	Tue, 20 Oct 2026 08:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792485869;
	bh=qdZiXzT4CJkHQlqb7iSDmu1qfmRJcpjD97jm3kVH3Cc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=B6op7VOMEn96LjomorUK0pS6SX6KxbT6X9MjMVSk0KKD7hVY+KS4tcRChAUrrdz1B
	 45gKIkQtgI+5/Lj/7R3cMu8GyLTixe3A9RZx8jCEGq+OTlNIx0lSfNlL/bMBG3YSBv
	 ndK6Z5U3+nOdAblb1doSbsEQytFSyVTW76IC5kNzXvHgjehi6WMJOJfmVFewIhcWEG
	 2TKKAhNALTqxsCwc9MkupkTPTCXGTTzNs2gpaZLhsceY9GLjidJa0gteGPvKF4RWmT
	 c3i/hcr/b5bZXFDco38s8XFB0T9Gghix8YdTjzyv+o06u8BAkFZGN2vS/G5f0iLizR
	 bNW40ZbE6OJtg==
Message-ID: <sashiko-outbox-178606@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v4 2/3] mptcp: inherit sk_reuse and fix dev
 bind override
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <4adf96455e63a35be3228434cfe2ba79ea99bcb0.1792470313.git.tanggeliang@kylinos.cn>
References: <cover.1792470313.git.tanggeliang@kylinos.cn>
 <4adf96455e63a35be3228434cfe2ba79ea99bcb0.1792470313.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 08:44:28 +0000
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
- [High] mptcp: wrong sk_uid during subflow bind when syncing sk_reuseport
--

commit 1d41a74d8cd4f5351a1f4186bfb92fe0ffeada01
Author: Geliang Tang <geliang@kernel.org>

mptcp: inherit sk_reuse and fix dev bind override

This commit propagates sk_reuse and sk_reuseport from the master socket to
subflows, increments setsockopt_seq when SOL_SOCKET options are set, and
avoids overriding sk_bound_dev_if in __mptcp_subflow_connect() when
local->ifindex is zero.

> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 922f6ae5c80cb..952bc015eee87 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c

[ ... ]

> @@ -1706,6 +1708,9 @@ static void sync_socket_options(struct mptcp_sock *=
msk, struct sock *ssk)
>  		assign_bit(b, &inet_sk(ssk)->inet_flags, src & BIT(b));
> =20
>  	WRITE_ONCE(inet_sk(ssk)->local_port_range, READ_ONCE(inet_sk(sk)->local=
_port_range));
> +
> +	ssk->sk_reuse =3D sk->sk_reuse;
> +	ssk->sk_reuseport =3D sk->sk_reuseport;
>  }
> =20
>  void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)

[Severity: High]
When syncing sk_reuseport to ssk here in sync_socket_options(), does ssk
have the right sk_uid before kernel_bind() runs in
__mptcp_subflow_connect()?

In mptcp_subflow_create_socket(), sock_create_kern() initializes
SOCK_INODE(sf)->i_uid to current_fsuid(), and sock_init_data() copies that
into sf->sk->sk_uid. Although mptcp_subflow_create_socket() then updates
SOCK_INODE(sf)->i_uid to the master socket's UID:

net/mptcp/subflow.c:mptcp_subflow_create_socket() {
	...
	SOCK_INODE(sf)->i_ino =3D SOCK_INODE(sk->sk_socket)->i_ino;
	SOCK_INODE(sf)->i_uid =3D SOCK_INODE(sk->sk_socket)->i_uid;
	SOCK_INODE(sf)->i_gid =3D SOCK_INODE(sk->sk_socket)->i_gid;
	...
}

ssk->sk_uid is not updated until mptcp_sock_graft() calls sk_set_socket()
at the end of __mptcp_subflow_connect(), after kernel_bind() and
kernel_connect():

net/mptcp/subflow.c:__mptcp_subflow_connect() {
	...
	err =3D mptcp_subflow_create_socket(sk, local->addr.family, &sf);
	...
	err =3D kernel_bind(sf, (struct sockaddr_unsized *)&addr, addrlen);
	...
	err =3D kernel_connect(sf, (struct sockaddr_unsized *)&addr, addrlen, O_NO=
NBLOCK);
	...
	mptcp_sock_graft(ssk, sk->sk_socket);
}

When additional subflows are created asynchronously via mptcp_worker or a
privileged path manager daemon, current_fsuid() is 0 (root) rather than the
UID of the owning MPTCP socket.

During kernel_bind() -> inet_csk_get_port(), the SO_REUSEPORT checks in
sk_reuseport_match(), inet_csk_bind_conflict() -> inet_bind_conflict(), and
inet_csk_update_fastreuse() all read sk_uid(ssk):

net/ipv4/inet_connection_sock.c:inet_bind_conflict() {
	...
		} else if (!reuseport_ok || !sk->sk_reuseport ||
			   !sk2->sk_reuseport || !reuseport_cb_ok ||
			   (sk2->sk_state !=3D TCP_TIME_WAIT &&
			    !uid_eq(uid, sk_uid(sk2)))) {
			return true;
		}
	...
}

Because sk_uid(ssk) is still 0 during kernel_bind(), won't an unprivileged
user's subflow fail with -EADDRINUSE when binding to the same port as the
initial subflow or another SO_REUSEPORT socket owned by that user, while
also matching against root-owned SO_REUSEPORT sockets and recording
tb->fastuid as 0 in inet_csk_update_fastreuse()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792470313.gi=
t.tanggeliang@kylinos.cn?part=3D2
