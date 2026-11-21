Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795255884;
	b=OF0GVX2ajrbpsBMJufWKjoI0h5BrzJpnN/gUiZ9pMRUvCI+bUHfDEtwQM4IMOMVo5A9c
	 rRK26KOOaUXP/sAMyC0GFu4AvJPBPfaaN9ytVcXfL9IeuBIK1KLezTXgK63yeFU9USorc
	 UTATFXGk2p2ydN5HyXzM2CRq2ale9RVwmNVM9AAcnKSP8mOqnNPeF5HqCfBIcnqeJMsxY
	 u7j0gjtOuUJJFXHrB/SLRqODPBYGBx8lzrXtVpGbBQT9fLo59LQsw5EumGm/mVMF8UnhQ
	 AIBr7EnpBfu+KFeNT+h3fip2ryhzw/i5EXF0pRPbEvzA93/Cjp7tBq+l3iPPnhLqPTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795255884;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FGOVDIZzMN0wPktPRlomAAORUNhLvpufdpdzv5db5fM=;
	b=SUy7yGLRg07z2NdaxrS4uHIpbu5slISknDjGG1lZKdfy1dY+1fzb45TvY/RZ7k7m6aoT
	 smtextwiefm9edZ9UgiKOwaE9AOS73sSwjSzQ77XV0BvxhAwRCEfbnHeDhoerbwOXeKyF
	 ANNuUfHOC7sSR4CdYPwyPI0E8DywA31Giil9fWuc0xtGNQDlbfArL9zn19QpiB+cFgsQe
	 YmkGsdeTU9zBvgd3uZnK7J04WM+gaf7aCCEvx9o8heMwnJbDTBlkYvn1KJZQWYVjMzVYX
	 X0xThCM7laxcZK4CWs8YDMWqDNOy+R6GJz4TB5FH2131v88g+p0j1aa6VFuY1F5HjJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gyyPCF88;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFAD606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 10:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gyyPCF88
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7BF1F000C0;
	Sat, 21 Nov 2026 10:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795255884;
	bh=FGOVDIZzMN0wPktPRlomAAORUNhLvpufdpdzv5db5fM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=gyyPCF88nyP2iZgookjGQfMeSw52l78oiuNsYOZT4lDEPGnWzMFjYhvM11vqq80w0
	 E4EJUMX4KovC2GcfLpsIWaW3XdWNeYDVyYdFw/bSE7zhl9lvQKzqucof2qdUu/Otwa
	 HdUVLEfzbLNuE2Qa4itU7g/+TroJ807BZVPhzoVMyG63iNQtwY363pSw+mT7Xu7B+I
	 MyPcE2t6oy4yo+iW1z76O9nsyqrkmf6H31U9YckhhwcTwBMh6RsfZNKlNkldZF2uOs
	 jv35WfMpA07QiBzYUabYlAqBrpU+8ltJB2lFpSqmqWPLJnFqteT/eY+bS7Gae1+x2Q
	 2AQHEZJBla/Qw==
Message-ID: <sashiko-outbox-226918@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net v2 28/62] mptcp: no fastclose reset from
 SYN_SENT subflows
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>, "MPTCP
 Linux" <mptcp@lists.linux.dev>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-28-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
 <20261121-mptcp-cmason-fixes-v2-28-00327fd1de1f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 10:11:23 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] mptcp: race on TCP_SYN_SENT subflow in mptcp_do_fastclose()
  after unlock
--

commit 7e20c0b8af4ba4b67481ee3130ee19f18fec3566
Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>

mptcp: no fastclose reset from SYN_SENT subflows

This commit skips calling tcp_send_active_reset() in mptcp_do_fastclose()
when a subflow socket is in TCP_SYN_SENT.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index f80fac0c22c06..55ff0298e5dd2 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3297,6 +3297,10 @@ static void mptcp_do_fastclose(struct sock *sk)
> =20
>  		subflow->send_fastclose =3D 1;
> =20
> +		/* no reset in SYN_SENT, as TCP does */
> +		if (ssk->sk_state =3D=3D TCP_SYN_SENT)
> +			goto unlock;

[Severity: Medium]
Can an incoming SYN-ACK race with release_sock(ssk) here because ssk is
left in TCP_SYN_SENT with subflow->send_fastclose =3D 1 until the caller
invokes __mptcp_close_ssk()?

CPU0                                  CPU1 (softirq)
mptcp_do_fastclose()
  lock_sock(ssk)
  subflow->send_fastclose =3D 1
  if (ssk->sk_state =3D=3D TCP_SYN_SENT)
    goto unlock;
                                      tcp_v4_rcv() (SYN-ACK arrives)
                                        sk_add_backlog(ssk, skb, ...)
  release_sock(ssk)
    __release_sock(ssk)
      tcp_v4_do_rcv()
        tcp_rcv_state_process()
          tcp_rcv_synsent_state_process()
            tcp_set_state(ssk, TCP_ESTABLISHED)
            tcp_send_ack(ssk)
__mptcp_close_ssk()
  lock_sock_nested(ssk, ...)
  if (subflow->send_fastclose &&
      ssk->sk_state !=3D TCP_CLOSE)
    tcp_set_state(ssk, TCP_CLOSE)     <-- silently closes without RST/FIN

If the SYN-ACK completes the handshake in that window, __mptcp_close_ssk()
 sees subflow->send_fastclose =3D=3D 1 and forces ssk to TCP_CLOSE before
__mptcp_subflow_disconnect() or __tcp_close(), leaving the peer in
ESTABLISHED without sending a RST or FIN.  Conversely, if
subflow_finish_connect() rejects the SYN-ACK (for example on an MP_JOIN
subflow because the parent msk is already in TCP_CLOSE) and calls
mptcp_subflow_reset(), having subflow->send_fastclose =3D=3D 1 still attach=
es
MP_FASTCLOSE to that reset.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121-mptcp-cmas=
on-fixes-v2-0-00327fd1de1f@kernel.org?part=3D28
