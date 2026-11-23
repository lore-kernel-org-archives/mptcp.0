Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795423032;
	b=S0z5sSjaMiWMeJnW7327rx+iAunm3mAvDC4Nc9bty/W12ERd/NUrfMaJvplTgaZU2JAQ
	 zmvdsodmE3gYVis/JQ8dKFc4Bo/KU09cteS/hXY13S9Thm1PhjumvHswZYUSzr8uE3O0J
	 MjH8/zasnPXSGzmv0Ndv/jyQOME53l8wWpssZ/1+taIZWQffT2LgcF+1X4kUrOqgBD757
	 A56r+/5GdFAEZZPm4Cs7TtB0jAgZ43v7+nM9Q2EYLNOIy6DaembvZxecZYSnV4RIVYAGA
	 j8XXOdCL1sWFyUTxADhQPYyXVyw0DGRHD2fgSn/Ry7S+4WUp6VyCfdmKTZ+j4hUENYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795423032;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ND2m7G1Du/dqWvBZRtAxxXZOfwCmlrK1+9f2oWcRVVM=;
	b=vheFMdgUht8o1TYQ8F7a5tNoQSO86ZelHVlJTt+yZzU3PeswggMfa4yksgvTT8W3zon7
	 YWW5A40nzg2inERFijMPLDy8scLQAQUSXOgNI4zduDBNxcCUv6/4ZsmD0Lfqo/mYEefIR
	 nJL2RaJ/wo9NMvfHLWYgETsiCQ9Dxpb7fmw6l5cFXR2Ak1wA6QbkiIC1JqZqKS8WPb1S4
	 Kqpa1VwrRAIbpQD0LlQXsWhs2swxjHq5mtfp0FQ/oeIu+rsKAkZUfYAXwc8Ovya1VIR65
	 IWTht+j/ZU4LW3mEq+IIm3tLqleUsKZtuojZ4SinvOg5CrPlka2nYL4957iYc61qOrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jfYUXA6b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0BE606A31A
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 08:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jfYUXA6b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5382F1F000CA;
	Mon, 23 Nov 2026 08:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795423032;
	bh=ND2m7G1Du/dqWvBZRtAxxXZOfwCmlrK1+9f2oWcRVVM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=jfYUXA6bXPGRL/A1hpE/Nliqa/WG0GdXEQdU0q2sShqEa+TzvQ1aU6pICiLsHR5GE
	 jP3f6t0rTfwK1tWb4M2q4OgIcmAi/g2xOtrf6eAi40er4GMvrsdCBrrVuRkwM7izMD
	 MkZTrkvhE3UqMkwSUaUacpwcxcJfBRMpgiaQE2yPq1Z/7hN/+s+WFF4P5Q6InlyiuC
	 3+p1wpjTT/k4WXOLXHpbZm4ZDDzfIfcYXRMvmlQu/TN8i/V6TjcAwVNF/40yOr9PtL
	 Tfof98nxVXtAMhuNlR9D+/CJKk270RGdJgP75SiufaKIooQLZh6CRkuZAFciHuiDSO
	 UXaC7IcBZUiwA==
Message-ID: <sashiko-outbox-228907@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v8 1/7] ipv4: fix uninitialized memory in
 zerocopy cmsg
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <2819758329599addb172d144f078727112ecf17c.1795421388.git.tanggeliang@kylinos.cn>
References: <cover.1795421388.git.tanggeliang@kylinos.cn>
 <2819758329599addb172d144f078727112ecf17c.1795421388.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 08:37:11 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] ipv4: non-existent bug claimed in
  ipv4_datagram_support_cmsg()
- [Low] ipv4: inaccurate Fixes trailer in ipv4_datagram_support_cmsg()
  commit
--

commit 700237f41e9bcbea5b22f49b39d9b8d4e38cf887
Author: Geliang Tang <geliang@kernel.org>

> ipv4: fix uninitialized memory in zerocopy cmsg
>
> When SOF_TIMESTAMPING_OPT_CMSG is enabled and applications read
> MSG_ZEROCOPY completion notifications from the error queue, the
> ipv4_datagram_support_cmsg() function attempts to read ip_hdr(skb)->saddr
> to populate IP_PKTINFO cmsg data. However, zerocopy completion notificati=
on
> skbs don't have IP headers, causing this read to access uninitialized
> memory which is then leaked to userspace via put_cmsg().
>
> This is because the function checks PKTINFO_SKB_CB(skb)->ipi_ifindex (whi=
ch
> aliases the ops pointer in ubuf_info_msgzc stored in skb->cb), and if
> non-NULL, proceeds to read ip_hdr(skb)->saddr without verifying that the
> skb actually has an IP header.
>
> Fix this by adding an early check for SO_EE_ORIGIN_ZEROCOPY and returning
> false, since zerocopy completion notifications don't have IP headers and
> IP_PKTINFO cmsg is not applicable to them.
>
> Fixes: 829ae9d61165 ("net-timestamp: allow reading recv cmsg on errqueue =
with origin tstamp")
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
Is this Fixes: tag accurate?

Commit 829ae9d61165 ("net-timestamp: allow reading recv cmsg on errqueue wi=
th
origin tstamp") explicitly required ee_origin =3D=3D SO_EE_ORIGIN_TIMESTAMP=
ING and
predated SO_EE_ORIGIN_ZEROCOPY, which was added later in commit 52267790ef52
("sock: add MSG_ZEROCOPY").

> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index 90d0b5bee68b5..8d1a9db54f839 100644
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c
> @@ -504,6 +504,12 @@ static bool ipv4_datagram_support_cmsg(const struct =
sock *sk,
>  	if (ee_origin =3D=3D SO_EE_ORIGIN_LOCAL)
>  		return false;
> =20
> +	/* Zerocopy completion notifications don't have IP headers,
> +	 * so IP_PKTINFO cmsg is not applicable.
> +	 */
> +	if (ee_origin =3D=3D SO_EE_ORIGIN_ZEROCOPY)
> +		return false;

[Severity: Medium]
Can ipv4_datagram_support_cmsg() actually reach ip_hdr(skb)->saddr for a
SO_EE_ORIGIN_ZEROCOPY notification skb?

Before queueing a zerocopy completion notification onto sk_error_queue,
__msg_zerocopy_callback() overwrites ubuf_info_msgzc in skb->cb (and note t=
hat
struct ubuf_info has not had an ops pointer since commit ecca9bb2c855 ("net:
replace Callbacks inside ubuf_info with single function")):

net/core/skbuff.c:__msg_zerocopy_callback() {
	...
	serr =3D SKB_EXT_ERR(skb);
	memset(serr, 0, sizeof(*serr));
	serr->ee.ee_errno =3D 0;
	serr->ee.ee_origin =3D SO_EE_ORIGIN_ZEROCOPY;
	...
}

Because SKB_EXT_ERR(skb) and PKTINFO_SKB_CB(skb) both sit at the start of
skb->cb, memset(serr, 0, sizeof(*serr)) zeroes PKTINFO_SKB_CB(skb)->ipi_ifi=
ndex
(which aliases serr->header.h4.iif).  The existing !info->ipi_ifindex check=
 in
ipv4_datagram_support_cmsg() therefore already returns false for every
SO_EE_ORIGIN_ZEROCOPY skb before ip_hdr(skb)->saddr is read.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795421388.gi=
t.tanggeliang@kylinos.cn?part=3D1
