Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61B1277C9E
	for <mptcp@lists.linux.dev>; Thu, 16 Apr 2026 12:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776342835; cv=none; b=rMFBPpMTPjwKauNazIjrNhHv9NBeKlyroGVgf2ayfYGeR+VJUzLayGDbgVu8lHX4v/PE5aQL7xmEwsSnaTYi2IN3t0SHNc0dE0Fbg/Ta3uTMYF0WW54rMsQTYWMbh6Dc7Z0gFs0fstB0zgOWYMFgnwqUdJ4EmZoEAcn+4FZAhwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776342835; c=relaxed/simple;
	bh=M06yOtAQJlZnog7ZFlL+p4Oq2B/fp1+FQvv+7ylIXWg=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:
	 In-Reply-To:References; b=BhlBsxlushsCTs8mVcIZ6omD/gnrbU9MiKeOlMfQgRQWDUMhhYm4QZT6UGu9EHYQm0sMVhnHSSrNZcXjFWJqj3LW5ZyeSBAM2+U/fOC0q6UWtxq1IKktLg6aWgETrdSbS174r9Nn0aU+o/p4k+0IveKmJPci72BVzATcQGi7A58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GLt6lVB6; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GLt6lVB6"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776342830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=teQrfCy2EsmqU/VR9fkwnYt4hstYgyMPgTLVFTtdtjI=;
	b=GLt6lVB6NnTyfg3GGTyBZXPtLiycmijxLa3wvZ8JoJey2x9ESBSTz4NCa4iBP+KE+djVJV
	ldGgpTIyBMdgLjYjYQ9pzZOs2rm7LRMiu1W6nCP0lrgRHFOLPekLDRqGWMslbEhfTO4dER
	VD8su6MeY1xU7hX980pjLkHh9r+8rPo=
Date: Thu, 16 Apr 2026 12:33:44 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: gang.yan@linux.dev
Message-ID: <b5e178f01d0f9523d48d163a56488756ce20450f@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-net] mptcp: update window_clamp on subflows when
 SO_RCVBUF is set
To: mptcp@lists.linux.dev
In-Reply-To: <20260416122945.324166-1-gang.yan@linux.dev>
References: <20260416122945.324166-1-gang.yan@linux.dev>
X-Migadu-Flow: FLOW_OUT

April 16, 2026 at 8:29 PM, "Gang Yan" <gang.yan@linux.dev mailto:gang.yan=
@linux.dev?to=3D%22Gang%20Yan%22%20%3Cgang.yan%40linux.dev%3E > wrote:


>=20
>=20From: Gang Yan <yangang@kylinos.cn>
>=20
>=20Add __mptcp_subflow_set_rcvbuf() helper that calls the subflow's
> ops->set_rcvbuf to update window_clamp, in addition to writing
> sk_rcvbuf. Use it in both mptcp_sol_socket_sync_intval() (setsockopt
> path) and sync_socket_options() (new subflow creation path).
>=20
Sorry=20for the confusion in my commit message.

I need to clarify that we cannot call ops->set_rcvbuf() on the MPTCP
subflows as mentioned in the commit message. I will fix this mistake
and update the commit message properly in the next version.

Thank you for your understanding.

Thanks
Gang
> Fixes: a2cbb1603943 ("tcp: Update window clamping condition")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/619
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> ---
> Notes:
>=20
>=20Hi Matt:
>=20
>=20Note that I do not implement set_rcvbuf in mptcp_stream_ops for the=
=20
>=20following reasons:
>=20
>=20 - The callback receives the MPTCP meta socket as 'sk', but
>  tcp_set_rcvbuf() must be called on each TCP subflow to update
>  window_clamp. A callback implementation would need to iterate all
>  subflows, duplicating the work already done by
>  mptcp_sol_socket_sync_intval().
>=20
>=20 - Subflows are grafted to the MPTCP socket via mptcp_sock_graft(),
>  so ssk->sk_socket->ops points to mptcp_stream_ops, not
>  inet_stream_ops. This means the TCP set_rcvbuf callback is not
>  reachable through the subflow's ops either.
>=20
>=20 - The existing subflow sync functions cover both the setsockopt path
>  (mptcp_sol_socket_sync_intval) and new subflow creation path
>  (sync_socket_options), making the proto_ops callback unnecessary.
>=20
>=20WDYT=EF=BC=9F
>=20
>=20The packetdrill tests is also implemented:
>  -Link: https://github.com/multipath-tcp/packetdrill/pull/194
>=20
>=20Thanks
> Gang
>=20
>=20---
>  net/mptcp/sockopt.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
>=20diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index de90a2897d2d..abe63392826b 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -67,6 +67,12 @@ static int mptcp_get_int_option(struct mptcp_sock *m=
sk, sockptr_t optval,
>  return 0;
>  }
>=20=20
>=20+static inline void __mptcp_subflow_set_rcvbuf(struct sock *ssk, int =
val)
> +{
> + WRITE_ONCE(ssk->sk_rcvbuf, val);
> + tcp_set_rcvbuf(ssk, val);
> +}
> +
>  static void mptcp_sol_socket_sync_intval(struct mptcp_sock *msk, int o=
ptname, int val)
>  {
>  struct mptcp_subflow_context *subflow;
> @@ -100,7 +106,7 @@ static void mptcp_sol_socket_sync_intval(struct mpt=
cp_sock *msk, int optname, in
>  case SO_RCVBUF:
>  case SO_RCVBUFFORCE:
>  ssk->sk_userlocks |=3D SOCK_RCVBUF_LOCK;
> - WRITE_ONCE(ssk->sk_rcvbuf, sk->sk_rcvbuf);
> + __mptcp_subflow_set_rcvbuf(ssk, sk->sk_rcvbuf);
>  break;
>  case SO_MARK:
>  if (READ_ONCE(ssk->sk_mark) !=3D sk->sk_mark) {
> @@ -1556,7 +1562,7 @@ static void sync_socket_options(struct mptcp_sock=
 *msk, struct sock *ssk)
>  mptcp_subflow_ctx(ssk)->cached_sndbuf =3D sk->sk_sndbuf;
>  }
>  if (sk->sk_userlocks & SOCK_RCVBUF_LOCK)
> - WRITE_ONCE(ssk->sk_rcvbuf, sk->sk_rcvbuf);
> + __mptcp_subflow_set_rcvbuf(ssk, sk->sk_rcvbuf);
>  }
>=20=20
>=20 if (sock_flag(sk, SOCK_LINGER)) {
> --=20
>=202.43.0
>
