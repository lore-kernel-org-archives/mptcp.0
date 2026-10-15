Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC1E34DCCD
	for <mptcp@lists.linux.dev>; Thu, 15 Oct 2026 10:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792061957; cv=none; b=qd+dkGMFZkHXxLo0dQGt63ai/WGCBKaNKED63JueAa/BlhV0uda/ODsuDpgpvTscrvhBPz1jTFi/XXZ9+T7S/7ka427Bme5nMg3Ziocwfv7V6tPTZxZmnC2ugzKcXYftcbyD4I9icfC1SCgAb6U7/ybMay9I3zAMno7VB13r/8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792061957; c=relaxed/simple;
	bh=n1cNcAZleuW4/J7hEBFK8xRdeoszBZX7FH6bZdMry9c=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=srzsQdCpT9pahGriU/7USdCvU7867/3CPfW//+newLeN0wQw75F5Z5KOs7+rhkq5dQhmkpKf0F5pqbXG/VyrZ6u31mSYBcNBRYz1ZfraUrZEoylU5Qes2pSgtwYXMJCzhyBljw3PAy7+44ZLFECwpVi+4GFTcuXwRWZkpQcj1+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXe7rysD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXe7rysD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F751F000C4;
	Thu, 15 Oct 2026 10:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792061956;
	bh=MSkn9IU7lRzF+kRnMq//1NhcIQwxnIR/Y9PMld3wN/c=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=HXe7rysDTeGNwP41d6KRZf9U2uG4ID9T7ASzcTp1fFmw3hknqp0qTUwRlTi7egDCu
	 O12H5ArNnHCw5pFQIoWRnyppgP5uNxq4nUO1+VeCBFIkf6Q+2f9DFAUQbLDXcQYsKB
	 w0n9GB55Ka0jx09+J1z/frMbxLEhnc7tDe3bSxQoboasF44zuzYHk/mqnENrEPLAm1
	 31aUcBCrFW6IZZI9FXdLNjztrqc5nTUmSeOub5S8zjAKD+mV+L7MCHMfGlhOtbzXgv
	 aXP9YaFl2qyg/LspEnNb66C17ksXZQpiTwqzqAm6Iw4W24ep63wdJGsrT6Cg7hlFX+
	 mPyQfKPQy45Fw==
Message-ID: <sashiko-outbox-172701@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next 1/2] mptcp: give MPTCP sockets a distinct
 lockdep class
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <23c5f34fa80bff87b4c49981b1ab19d13bf7f136.1792060837.git.tanggeliang@kylinos.cn>
References: <cover.1792060837.git.tanggeliang@kylinos.cn>
 <23c5f34fa80bff87b4c49981b1ab19d13bf7f136.1792060837.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 10:59:16 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mptcp: passive sockets miss lockdep reclassification causing war=
nings
--

commit c0431dba7b7ab62b7e71ad2f4ff94fb4913cc837
Author: Geliang Tang <geliang@kernel.org>

mptcp: give MPTCP sockets a distinct lockdep class

MPTCP sockets and their subflows share the same k-sk_lock-AF_INET
lockdep class. When both are kernel sockets, lockdep flags every path
that holds the MPTCP socket lock and then locks a subflow (setsockopt,
connect, bind, worker send-ack) as "possible recursive locking".

Reclassify the MPTCP socket lock in mptcp_init_sock() to use a distinct
lock class (sk_lock-AF_INET-MPTCP for IPv4, sk_lock-AF_INET6-MPTCP for
IPv6). This approach is similar to nvme-tcp and avoids the need to
reclassify each subflow socket individually.

The implementation is based on nvme_tcp_reclassify_socket() from
drivers/nvme/host/tcp.c.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 60cbd91be6320..e63896a605953 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
[ ... ]
> @@ -3292,6 +3327,8 @@ static int mptcp_init_sock(struct sock *sk)
>  	sk->sk_sndbuf =3D READ_ONCE(net->ipv4.sysctl_tcp_wmem[1]);
>  	sk->sk_write_space =3D sk_stream_write_space;
> =20
> +	mptcp_reclassify_socket(sk->sk_socket);
> +
>  	return 0;
>  }

[Severity: Medium]
Since mptcp_init_sock() is only used for active socket creation, are cloned
(passive) connections missing this lockdep reclassification?

When an incoming MPTCP connection is accepted, the socket is cloned:

net/mptcp/protocol.c:mptcp_sk_clone_init() {
	...
	struct sock *nsk =3D sk_clone_lock(sk, GFP_ATOMIC);
	...
	__mptcp_init_sock(nsk);
	...
}

sk_clone_lock() initializes the lockdep class back to the generic AF_INET
default. Because mptcp_reclassify_socket() is never called for these cloned
sockets, will lockdep continue to falsely report recursive locking when an
accepted MPTCP socket and its subflow are locked simultaneously?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792060837.gi=
t.tanggeliang@kylinos.cn?part=3D1
