Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795612148;
	b=ciGnUYe1KmHee2zZ9ST4LI9m5X3SxUpJ8IqvcuVScqkgZfgOp3zVnkf+LG5xZpWm86dd
	 SvULQN6dgNXKnn0OtVKzwBha39pkvxVSUUfheUGuNjv4Sr7tCcoHQlyPoN3YbY+MRouYf
	 p8Yqv6UCch0g8E84amxnPQcYGNaunYB/y+AKGASP237HED/s5aef/fNs+Jaw6IcQgjIfn
	 +Fp58qCzzO7Xexufj0AFqAIRAdOMo4Adch0Mbgc1bR4clp6fCtyWwxUTxC3krGcTFt8g6
	 Ci41Ai+qEgyHMVHlPaNfes99RIy/R7br6HJJzFLCFvdic2zDI5/BfnFw1d4wzHkHwPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795612148;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=n+Vb31kCyLFO0i6gl9GYE7pyYhRP0kQ5pPK8kLdNUz8=;
	b=lWGBHTmPuNEnScpUfl2wRjMCT9AWe+jZt50T45gJbadSMYL3nBOmyMpvpg5KyruTqEzC
	 uKgP0Oy95dPNfp/9q/iwraPhNLwjBO56lIbXMMcwtmYGf1cEM/zYNhmZQMCXZ89sg81pE
	 fxmjAGCZYL3wKcUnvzDSJNsVh42DzDMAcmx4BARr0HDsqlfOzG/E+fbmHND4gFkFbwwJm
	 fjNdJwcp2rHtPVpLQyv4Dc29gFGC2tI75cwZQq+Qx56ohIPmWaA85/a7Jh4k6wrPIYjfw
	 X5iH2i2aKiLrHACOo9Ik2Y/lP0RTjpPbfWStqd7ZWHxuEXJ3GoIGErvW7dmTDMuJd3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lkHf9/Dd";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA3C606A321;
	Wed, 25 Nov 2026 13:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lkHf9/Dd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07A01F000C4;
	Wed, 25 Nov 2026 13:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795612148;
	bh=n+Vb31kCyLFO0i6gl9GYE7pyYhRP0kQ5pPK8kLdNUz8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lkHf9/DdM5oXbhhSeha53O7cpxG4NPMyvTkcWyT7A4MqBFb5FFOWpBvuthOdwKg2N
	 x26dSAIf//wFqqZzYbA9bxGdTWamO08kptWPELD1+ULrvJqv3M0XIOD4dkepP78Oku
	 yQ/Guk6otch8rXDxBrrM/fxvEmOqfehyTHIFUXjSGVNhuQz6Wk4XJIHhWuOVve9bnb
	 hDIlWFTdEPqgkIuNTCHr85mRQBHSMQSONm/B5AvS98l5V0n4C1xtzfwMf0jDfMnwNy
	 SIEJQ/H+q01aOfqudorV3wPNpms79Cw8GFDeulh//RmTK2ysZWfuUhkxyTBXr8MVMu
	 CCwdWJU9Mcc9Q==
Message-ID: <sashiko-outbox-233459@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v1 2/6] ipv4: avoid a stack canary in
 ip_finish_output2()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xuanqiang Luo" <xuanqiang.luo@linux.dev>
Cc: bpf@vger.kernel.org, mptcp@lists.linux.dev
In-Reply-To: <20261124130631.1886963-3-xuanqiang.luo@linux.dev>
References: <20261124130631.1886963-1-xuanqiang.luo@linux.dev>
 <20261124130631.1886963-3-xuanqiang.luo@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 13:09:07 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] bpf: device mismatch in bpf_out_neigh_v4() on RTN_LOCAL routes
  [1]
--

commit ca3d30f8ff839a5ead3ac3b6137813b8e1486837
Author: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

ipv4: avoid a stack canary in ip_finish_output2()

This commit changes ip_neigh_gw4() to take a pointer to the IPv4 address
instead of passing it by value, avoiding a stack canary in callers such as
ip_finish_output2() and deduplicating inlined calls in ip_neigh_for_gw()
and ipv4_dst_neigh_lookup().

[ ... ]

> diff --git a/include/net/route.h b/include/net/route.h
> index 3fccd31eb74df..1571e1c6082cc 100644
> --- a/include/net/route.h
> +++ b/include/net/route.h

[ ... ]

> @@ -425,17 +425,17 @@ static inline struct neighbour *ip_neigh_for_gw(str=
uct rtable *rt,
>  						bool *is_v6gw)
>  {
>  	struct net_device *dev =3D rt->dst.dev;
> -	struct neighbour *neigh;
> +	const __be32 *daddr;
> =20
>  	if (likely(rt->rt_gw_family =3D=3D AF_INET)) {
> -		neigh =3D ip_neigh_gw4(dev, rt->rt_gw4);
> +		daddr =3D &rt->rt_gw4;
>  	} else if (rt->rt_gw_family =3D=3D AF_INET6) {
> -		neigh =3D ip_neigh_gw6(dev, &rt->rt_gw6);
>  		*is_v6gw =3D true;
> +		return ip_neigh_gw6(dev, &rt->rt_gw6);
>  	} else {
> -		neigh =3D ip_neigh_gw4(dev, ip_hdr(skb)->daddr);
> +		daddr =3D &ip_hdr(skb)->daddr;
>  	}
> -	return neigh;
> +	return ip_neigh_gw4(dev, daddr);
>  }
> =20
>  #endif	/* _ROUTE_H */
> diff --git a/net/core/filter.c b/net/core/filter.c
> index f42ecfb5841f9..8ee023c87c243 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2376,7 +2376,7 @@ static int bpf_out_neigh_v4(struct net *net, struct=
 sk_buff *skb,
>  		neigh =3D ip_neigh_gw6(dev, &nh->ipv6_nh);
>  		is_v6gw =3D true;
>  	} else if (nh->nh_family =3D=3D AF_INET) {
> -		neigh =3D ip_neigh_gw4(dev, nh->ipv4_nh);
> +		neigh =3D ip_neigh_gw4(dev, &nh->ipv4_nh);
>  	} else {
>  		rcu_read_unlock();
>  		goto out_drop;

[Severity: High]
This problem wasn't introduced by this patch, but can bpf_out_neigh_v4()
resolve the neighbour on the wrong device when nh is NULL [1]?

When __bpf_redirect_neigh_v4() resolves an RTN_LOCAL route via
ip_route_output_flow(), rt->dst.dev is set to net->loopback_dev (or the VRF
device) rather than the target redirect device dev:

net/core/filter.c:bpf_out_neigh_v4() {
	...
	skb->dev =3D dev;
	skb_clear_tstamp(skb);

	if (unlikely(skb_headroom(skb) < hh_len && dev->header_ops)) {
		skb =3D skb_expand_head(skb, hh_len);
		if (!skb)
			return -ENOMEM;
	}

	rcu_read_lock();
	if (!nh) {
		struct rtable *rt =3D skb_rtable(skb);

		neigh =3D ip_neigh_for_gw(rt, skb, &is_v6gw);
	...
}

Because ip_neigh_for_gw() uses rt->dst.dev instead of dev, neigh_output()
is invoked with a loopback_dev neighbour (which uses eth_header_ops) while
skb->dev points to dev.  If dev is an L3 device where dev->header_ops is
NULL (such as a tun interface), bpf_out_neigh_v4() skips skb_expand_head(),
and neigh_output() pushes an Ethernet header without sufficient headroom,
triggering skb_under_panic().

[1] https://sashiko.dev/#/bug/linux-26626829-3abf-4baa-b906-b783eeb1b107

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124130631.1886=
963-1-xuanqiang.luo@linux.dev?part=3D2
