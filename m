Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793820008;
	b=TPQreQUiXGLZVfha5RXOWpZA2wbFPRkLDXvCasIe/pJ92oYt39KBWQ0LuceNI5bML/xK
	 fSt0xHpyVyltoEB33W072s/uxHDKlei4uzgV2Z+1ellC2hRBaS6Or4Bi8CZpuHt7o1bGC
	 QcnYM3RHvTG0EMp34pR3CB2+7a6LTspFW1vtNqkmyIx4FhmSI1X2lPCjlXJ0oEoPA5pGX
	 P6g5NlBrUBo6HI5K2ktk4CNN46Kb8/z4E5CKe+CnpKPJV+W7HZtd3p+JFFIF6hqZcif2B
	 Ff8eeutapGTh8o985AeFlFdhUiyelAXMh8t6IEH1WKhTUWL8yfhbYKlI5oSaPUST+JQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793820008;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3pchkY95SlYVMfXzEW7d1/IDKmFrvcEI7YIYQHnUSg4=;
	b=MooM+ZAqC7oiydroC+aV9ylwTs2fxd3BNckZ0TJUWa2awMby+l6EFqiyjqRzo+ESG8N2
	 B5ivFH1DrQcSr771eBRC3sfzmbzSPr4w3X3ThUS3xmwI3Jp1+vwz5I39mdcsZf4SMLaH6
	 LgxHqXkuRILGvvk85bqfl+ZNhln6nMqg7USMcc9Kcd6xzRldKM00TJeavBLhJ09wERSWx
	 AmQrJgeaedTehb3RMIv2Tpyb1y55yaJtXMnnD6q2GVUnLYNTRzpTDdP8evoT2IsxIxenp
	 BWROorKBHW3wTXPs2OrIoRe0Uj+keHcCr7Hbrtt6Kcxf6ZCEfu3dXRcE89ssMvrtxyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ydZ3RXNH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.47
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C33A60A5BE0
	for <mptcp@lists.linux.dev>; Wed,  4 Nov 2026 19:20:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C33A60A5BE0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ydZ3RXNH
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6f8a519e215so942372eaf.1
        for <mptcp@lists.linux.dev>; Wed, 04 Nov 2026 11:20:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793820007; cv=none;
        d=google.com; s=arc-20260327;
        b=ZhGeeuJkNux2QdO0+kE8B/dXABZabH3XsBBkpBLscGDndYE42cUBIsy3iKCm02xTRw
         yzHMfiOQSpTdihuGFv01c68HIQGWPaho5R3b0RdxsYPSurd1xvjmuUEXD/KTq5VXwpQR
         NydN4lRbCn/ClL9YyA5U6qSDB21Zg1SbvztJAYnj5ptGyWLy0N0YbwluYFETPbJRLr47
         0q9l7GB+Us6LYUrC4+tWv+TTUDleJIxLtHglb/ZAyKMKgw93W014lCOJLYCgbIGs5zXE
         01XV0WHQgOlKIhNy54pvWGrG+DNTRYfNJfV8ZSgdyhRpUd3obrRAm6EieJVXClwMqPwj
         C12g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3pchkY95SlYVMfXzEW7d1/IDKmFrvcEI7YIYQHnUSg4=;
        fh=yV5d+VrMl8sLBnCABms29gVnZkXQYDDw08/9CyJblSo=;
        b=TUln7tMznVSB9xS4m2kiqbFAIUreY3nqPGdfPKIi78RCG1YpRVixa9rSDZ4z6iScRW
         /OS8A6jCHkERjF7KsPDwaaCQaCW92phAmB+siGzbrG2atwRkbZXr2ScwKjXc5mFhfY2H
         2e38D+UEMwLTWBftuD4F2ugjF+5qHSkuJvAxDC0IM5sWQEL22ISPr+zkgWEk466EEzds
         XbEdlgsgGHi0tUux3U/Js3yqOqxq/wM3w+miJ4sLPlKcQpJgf76ZmLpPFoQLmU8ZIx3x
         DtFIXcfji39KAIBP8igP/odFXr6miRiBy8T4v4NtvBMuLV/sSQaYNcZelJhtmAQ3TAQp
         682w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793820007; x=1794424807; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3pchkY95SlYVMfXzEW7d1/IDKmFrvcEI7YIYQHnUSg4=;
        b=ydZ3RXNHpxWbwZGMmXfBsgbwQAf2+sviGrE2U/QXjFyOIYacqsDU0D34LFAmcpb5IA
         ++WIt7gR2DdzGXnMzdaezFS+eBXjsm1p8YyRVXkGR16AkBcLJK3qWDYnNzPvNMBCXBtt
         tlyys4WX/CdGvidfzwVGzdpPiFliIaNvNvfEJzqvrs2Zihut3RMEFtpexRkDkqW2cxx+
         7moXX0bIv/rInfe6OKfK+hk4JIA6KA9wOn9+NLUqLSbtCGksurNV7rmt3WofPjkBGlUg
         /3yddj6LkzXQMZDk8ATT6OQpMqNzLnFZD6hKbJmTyrmZn6CNyTw6Z282HSWZzYdRvpJV
         Rg/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793820007; x=1794424807;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3pchkY95SlYVMfXzEW7d1/IDKmFrvcEI7YIYQHnUSg4=;
        b=zAGjqtfWGELuj9a8NXSJDo6rwJdwxrf9hn6FbME+qer06z79rr0uRlebmV9wYZPpxZ
         PYG0Zq6KHUoj89FxSyN2E2jDFMKUFihwoXX6AN5scM0w4hcXIDQh/2Uayi1uA0SW1vp1
         I2JFEQuGGnkPGDluqqXhP+U9gMaZEZ1jS/FN76rHE8WqgY7aeIB9EvYHtHbk0/udCLPp
         VKllAHUs4+5IvonVdxh3gRJ99Nesn77PSaq3fZnRxVtLbk903kUszImFNKXoU7MlAIWs
         dGcBfxhsjORE0VRRKofZSDnhmiJhF024aI0NUWenQZNANLmS26M5kAd6vUp7hcnvae+u
         l2oQ==
X-Forwarded-Encrypted: i=1; AKwUvBxGYeVs7EBP+PDEubysXnzlhwCdkd/7xa2s8r0dSAiNqaxJZFvjag6+uu4S+Pu3koO6dJdo8g==@lists.linux.dev
X-Gm-Message-State: APuU4Z+TEWEr6nKLjrItVlyUc2pcdbEfKK/zTsCp4LbF2gUeliXBCZ2P
	HlfOjbqaaNMIeKZPr+MmFoe8jqYGOC6hfYBdmywK4Xrcj6jupEZe/XZHtgWf+BtWCCYutqPiTRs
	7iEhGhhilSIPnt4SVwUswn69CbsSfvMg=
X-Gm-Gg: AYBFou0Ddug54bITUoVe3I6YErR1DNhOtkaSBXRGmkLMmltCs//SMrV8qEZXP/+EAEI
	E5PKDMdsA2szbf3zei2p1i5hr6s+Cm3Ijy0xnHbEWfm+HPVeL/cunIOr8rEIyjgW+YQR+ZNcw1W
	49AcXzUTR7FTWjlmPjL6BHZX/B0Eopn/F6d8EE4BOM0rX03Dp6Gwg/JG4CP+P2cGritsx+KekUi
	VPIhyOSdoX1ZO0EbjKGj2v48GNKXHgb+eplX8ArL8D5AnsTA97TZWqpYgDu2r82+7tW88EJNVki
	l5B7lVwLUw+S1XRCV3IUD+wqrdqL8P/yYjZViDvrirqOIJbmMDjIWuGnuwc2wII7tfYkegD9H79
	zsiUdyzcBvk6Ei24CceTa3vt4mgfxiiPFRRDLdCpMCkbI256sNWEogWzNFY/u
X-Received: by 2002:a05:6820:60a:b0:716:c870:7eb9 with SMTP id
 006d021491bc7-716d1ed0d87mr313916eaf.17.1793820007417; Wed, 04 Nov 2026
 11:20:07 -0800 (PST)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261103103633.2707416-1-zhiyuzhang999@gmail.com> <CAL4Wiip0RPZkfrwHeuNp6ntVWarpkL=wJ-wW6sUvNzYWS68s3Q@mail.gmail.com>
In-Reply-To: <CAL4Wiip0RPZkfrwHeuNp6ntVWarpkL=wJ-wW6sUvNzYWS68s3Q@mail.gmail.com>
From: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Date: Thu, 5 Nov 2026 03:19:55 +0800
X-Gm-Features: AclHuK_BR4-6TIohRJS_zawjA7_IVa0Ao4YBLhd308J7rBy_Y8iFzOZsQJyitaI
Message-ID: <CALf2hKvGy9_wFYcmhdegEHW3OrDovJQ_t7_B98ZwE8erwyykWg@mail.gmail.com>
Subject: Re: [PATCH net v3] tcp: prevent cross-family skb processing after disconnect
To: Eric Dumazet <edumazet@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Tong Liu <lyutoon@gmail.com>, Qi Tang <tpluszz77@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Eric Dumazet <edumazet@kernel.org> =E4=BA=8E2026=E5=B9=B411=E6=9C=883=E6=97=
=A5=E5=91=A8=E4=BA=8C 19:03=E5=86=99=E9=81=93=EF=BC=9A
>
> We do not want to add yet another check in TCP IPv4 fast path,
> for a problem that only exists for IPv6 sockets.
>
> tcp_v6_do_rcv() already dispatches IPv4 skbs to tcp_v4_do_rcv().
>
> Simply stop changing sk->sk_backlog_rcv for v4-mapped sockets
> (tcp_v6_connect() and tcp_v6_mapped_child_init()),
> so that skbs found in the backlog are always handled by the correct path.
>
> tcp_v6_disconnect() can then test
> inet_csk(sk)->icsk_af_ops->net_header_len =3D=3D sizeof(struct iphdr)
> (this also covers subflow_v6m_specific).
>
> Thanks.
>
> Untested patch:

Hi Eric,

Thanks. I applied your untested patch as-is on top of 5838f10563d5.

I agree that keeping tcp_v6_do_rcv() as the backlog handler for
AF_INET6 sockets is cleaner than adding another check to the IPv4 fast
path.

The patch fixes the reported bug in my tests. In the native IPv6 to
v4-mapped race, the stale IPv6 skb no longer reaches
tcp_v4_send_reset(). The disconnect/reconnect tests also pass for both
TCP and MPTCP.

I also checked the two races reported by Sashiko. On one v3 run with
400 reconnects in each direction, both races were hit four times.

For a native IPv6 to v4-mapped reconnect, I observed:

  tcp_v6_rcv()
    tcp_v6_do_rcv()
      tcp_rcv_established()
        inet_sk_rx_dst_set()          /* IPv6 skb */

For the reverse reconnect, I observed:

  tcp_v4_rcv()
    tcp_v4_do_rcv()
      tcp_rcv_established()
        inet6_sk_rx_dst_set()         /* IPv4 skb */

I added probes after the rcu_assign_pointer(sk->sk_rx_dst, dst)
instructions and confirmed that the mismatched dst was actually stored.
Both cases can also be reproduced with your patch.

So the receive paths and the cross-family dst assignments are real.
However, I have not reproduced the Critical outcome suggested by the
review. I saw no warning, oops or panic, and did not observe an IPv6
skb reaching ip_local_deliver() or an IPv4 skb reaching ip6_input().
For the local IPv4 input route in this test, the bytes overlapping
rt6_info::sernum are non-zero due to rtable::rt_type/rt_is_input, so
the invalid rt->from dereference did not occur.

Given that, I think your patch is still the right fix for the reported
header.h6/header.h4 bug. I would post it as v4 with that scope, and
handle the stale skb/sk_rx_dst race separately instead of adding the
IPv4 fast-path check back.

Does that sound like the right split, or do you think the sk_rx_dst
race should be addressed before v4 or should not even take care?

Thanks,
Zhiyu
