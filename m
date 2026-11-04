Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793769899;
	b=lVFrwXcj6dG241/oBckLY3eBn/XQ/P+y2Ilk5FcbwcB4b3KFJLoAdFIWOqitEKgTsmIt
	 6XSao05k++FRv6RIwJcX0DXPjsrfjMJrOK1AiTJNCsUnwx19neYZuI+HXlVgwaYgz23f2
	 T6Pt5w6eFl0ueOCXMCVo9Dp2+2XQOQg8ybvFWOIfNO0PbmPaf2mAbee9y/gywIxlnrxos
	 Hv4oDe0NqxtY0eNStZziV2Zs+9UFePKG+ACBDw0UzboTa7d9ic3yqO5AiQ3gmRq5R87Xi
	 orGnXeSUIZ/gWSDh87QzWAh6Cr785MxuBcj0mZw7NX+8tOshFTTliEncYpXbbznXDPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793769899;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=eoBDVmnVXuE8Yo+S60hLCqU6/yj3dqT4h3cmEdolbz0=;
	b=DQtIYTYfZldiqDnUngsjjiQmeM9wO7SwTQDnjOnEZlORVo4vu1dqiy9Y5XdQIZgpC1L5
	 FENmjj7N/HKgUTpjRS/WqplvCSPIktyhGBxDYKtAbeg39vqgOmRMU57MlKgW71xZAJ5Ow
	 gSGB+NdEas1BVOqzubrTAs74dUZ6k3RiOpKu/qem7tIZ+qkhjEqQ8s1uCCdNfBqaWn11n
	 BQplFi0o56yQV9k7EFdEb1oIyascD2U4Wsuxo0Eo3ecd7QX1Ap+a8ZSy4fSlStReQT6L/
	 YxH4ElqNgIBVM3bzLTEpaW3M02zDxoUSVOeaDkbyzvU40m1K/wW0JQbYtV2TXLZI6Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HKex3rK3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FDF606A326
	for <mptcp@lists.linux.dev>; Wed,  4 Nov 2026 05:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HKex3rK3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B941F00A1D
	for <mptcp@lists.linux.dev>; Wed,  4 Nov 2026 05:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793769898;
	bh=eoBDVmnVXuE8Yo+S60hLCqU6/yj3dqT4h3cmEdolbz0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HKex3rK3eL7Rp+GBrver63QLhTNWwbrojE6jrALo/bgcnVPFsgJw69EDdGp9yf0At
	 UJCYzMiHiMm8mro3z0bORkKypfRCvYuyw0KZIgXNsbPwDTpnsKi3VWl75HxnPBSnfN
	 vwWQj0xjj7wdxmwhl5W9vaEBE01eD74N08NnyBkn/yH7yDjlOubDBt4cJLgWHi8vVU
	 ypkweTk0bpKGBm/+6ZHfgln3QvR3vhFeAfACoYkq48/lm3pZSZyiIJhhjjkTqzW9+k
	 frv64kta+N44II0PcjIjZNMJqd/uICDBJayXP4ZnG4FWNvlhm5L51ZJXf/QlPIp3Dd
	 /r/NgnopgPFHQ==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-48e2d5a69c4so201320fac.3
        for <mptcp@lists.linux.dev>; Tue, 03 Nov 2026 21:24:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBz1opaR/sgIr2p/d26OT3UIldaenRASQwL8hjJ7ewFXUQ2OBoWVTWtzwIm4TfkGCCRl7J+e+Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z9I30f8JGW5IA7s5zRo1l+RiZgEuHUR4otLOycCHs4xtSd06x4h
	7nVUtebFd3jW5W8NpytTOgiBegs8xkZODedLk/cldQNFLtwDISnM0gMm2A4OONr+v6LKGrcF97g
	xBj6sd/XOy/qALKh+0lOvqBwgmnLJQK4=
X-Received: by 2002:a05:6870:960e:b0:4a6:fa51:3c89 with SMTP id
 586e51a60fabf-4a9077ef1a1mr9007007fac.51.1793769897717; Tue, 03 Nov 2026
 21:24:57 -0800 (PST)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com> <aujuOJCs5zZyon2k@john-p8>
In-Reply-To: <aujuOJCs5zZyon2k@john-p8>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 4 Nov 2026 06:24:46 +0100
X-Gmail-Original-Message-ID: <CAL4WiirLdpvLGKDrfM3s1Gx_JsUuA+QVQS_3TY28gttdQnEF6g@mail.gmail.com>
X-Gm-Features: AclHuK-kl3984ixA3XfcRldmIqqk9PcGSyvzJ0kBvOxBMRAIApqefCIEr1A6YD0
Message-ID: <CAL4WiirLdpvLGKDrfM3s1Gx_JsUuA+QVQS_3TY28gttdQnEF6g@mail.gmail.com>
Subject: Re: [PATCH bpf v2 00/15] bpf, sockmap: Fixes for verdicts, redirects,
 corks and recvmsg()
To: John Fastabend <john.fastabend@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, jakub@cloudflare.com, 
	jiayuan.chen@linux.dev, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com, 
	matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org, 
	josef@toxicpanda.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 2 nov. 2026 =C3=A0 21:11, John Fastabend <john.fastabend@gmail.com>=
 a =C3=A9crit :
>
> On Mon, Nov 02, 2026 at 07:20:57AM +0000, Alexei Starovoitov wrote:
> >From: Alexei Starovoitov <ast@kernel.org>
> >
> >These patches fix bugs in sockmap:
> >
> >  patches  area
> >  -------  -------------------------------------------------------------=
---
> >  01       recvmsg() after a fault
> >  02-04    the verdict of an sk_msg prog and the return value of sendmsg=
()
> >  05       the backlog of a stopped psock
> >  06       TCP listeners
> >  07-08    the target of an egress redirect
> >  09       the TCP state in recvmsg()
> >  10-14    corks and the redirect target
> >  15       bpf_msg_push_data() and bpf_msg_pop_data()
> >
> >8 of the patches are from Chris Mason and Josef Bacik.
>
> Thanks everyone lgtm. For the series.
>
> Reviewed-by: John Fastabend <john.fastabend@gmail.com>

For the series:

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
