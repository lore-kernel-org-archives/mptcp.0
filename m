Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD0226F2A1
	for <mptcp@lists.linux.dev>; Thu,  5 Mar 2026 04:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772685726; cv=pass; b=NjUT747D6T8odCyfx1WSnWuNvYYVnrnrkmOW6SZ2qk92ghsUFshrQ8FT4teGbzH1GLGzzpwgJZoXI8zbYh6tXnMH4kXqf5+LErMMWyB8Kd3keffS1fmpYuVYabjTBP3g6WXyhVoZi+wRe+xmn1/y/YpaJGMdLKCTxu3V8nLI++M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772685726; c=relaxed/simple;
	bh=b3Xkd4EKnRyb7vdnRVFaQz5szPGJij4qxH5oDzMhz34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1MOW5AkE/Z786ibnQ0zpNMr7EmhCxNRYnTvsgUUs16Zho9lu18ojqzzxLtkmPSOzq/pGUmia3zIEp0uBC6LYF2u3xEjVUK3s/94kmbbvqPBpDB8ih5mLCBsa46XNVpRsHlRan4GC6OSA/rfqpgZ+4QgaAxFJDYMuebGTJjyDBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S/7WvcAx; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S/7WvcAx"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-660d2e4846cso2148159a12.2
        for <mptcp@lists.linux.dev>; Wed, 04 Mar 2026 20:42:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772685724; cv=none;
        d=google.com; s=arc-20240605;
        b=ZlVp5Tx93I08m8oBIh28V54maYAB0Bey5hBTa6FHuQXTtJAF+eRhRpF2D3S3TEf7Vg
         yvP5S/VNI2Vzab5CGZE7Hp4i/I86zlj1o9Jz+tQr8pCzKQqvxRBBDrtKIw6gAY564tBk
         ucwn0f9Nnbw5TZivvVgdjV9y1OD/rraus1+HTsgd8KkkOB8yJ2gp+GRgZDW9c6lrUh9k
         L5GKR8ak//H3P29qzXdbEYbFBAgghcPWHKQrw6PEpjljI3CnmPDWZVC++BJGPG/fxbwX
         MMqNIDMQBVnCkQaCzYl5ftE75SavRpIazkDvJor4PPkFlaOXReFuKQN2t6maewlH9ypX
         PMLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qFs3o4E1Xye81GNOTEaZssjs4l2+yIjCY/hB9HWyfNo=;
        fh=eDzP74dmSEVhC06XX61ThRRkjdvygCHoUnbktjEvIl4=;
        b=XxqksvkUlZF4Oe5lp62cfmhRy9BJL1tDhruQm2kGRlUr8h1hw+qyIn7vVfs5nno4pM
         7rb2YPNDGq1W2YohJlB3cOzDX3/feuYcok9AovUN8Bu0dqVShaEQlcp1/ThIyTXy76ey
         Z36Mv3g2GLNIc3SahJ9BYNGyE7ik6MHUoJDdifYHJAO6DurZU6gjmPm6qH4ZSsTuvsR2
         IHZ2tRTxdE+5yL/gWEi3LtqKpnsn+gIWtPrte6IosoU8gU7n1PLasrDBEikXdC6cA/u+
         iG2tMJJi6u2pgOHTt2OEp7gpt79KzMRAWFvaNufsYqlvYiWh73MR/fh/ib/gFAQ9Hrpc
         Gl6A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772685724; x=1773290524; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFs3o4E1Xye81GNOTEaZssjs4l2+yIjCY/hB9HWyfNo=;
        b=S/7WvcAxiYLGLwu57nJb1lOCc+TscvXpGRNpol3+aQSUznUyQNmN3OT4vuNdCdJFbT
         cPDj4PRjDTjXy/W62zyFVBfJVzd4Hj8eCY0fFySzRPq0cBou8w8gM1x1XiL9bm6yPZ81
         WskC87jZhAi4hVBsOGSgCSb6fxgoVlL67BOkNoSTVLiKcB6r+MN+ihsapbfgU4K/lmXp
         IVQN5KErugtFWLTkVuTIT0uZtperPzsSqcRfNNKaxn2j1gK69L6SINgNTQTndLEQ+A0W
         M1GIpXUk/8PkHITlMTbz4kmCQkli7yw64BX2SEH/syvqU8jY41ldT9MvmSD270zmBosf
         VWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772685724; x=1773290524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qFs3o4E1Xye81GNOTEaZssjs4l2+yIjCY/hB9HWyfNo=;
        b=WsJlMI0pziOwnBCSL0xKd7wShf+gWlbJ3XKJX6y9MQQxSTUGJ3E/JLahZ/FC91c01k
         twPYSF6tAUByXUlRZnoqBE+LQFYAF5EmA6WGcEftuw2naf9z3/2Q5Zk4I3UqNBWX7dX8
         2vVPheuhyBmbsozB4rvoHq06ynsymxh+PWG0oh+F7BTGHhyWE4pyG0ist9BMXIqWr18G
         HIXbXDWF8eXzc5b3E3IJQSywCZcjwBPkyZq76X9GYUdqCxyAVs/Ieid/STu9Onv/5cmV
         pHqwpZjx/xZ29vz03IgikH0XkgdWgB7j/VibO9yKCsT5kh3qDBTN/Kc17Z7j7xX+7Yk8
         /ZyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeJl29PkAiuMqi97/+5GzxC7Qz0v1guDMBuepjPPtn3R2VxGUa1xpbsbY++SEmFw4DXzKpLQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxQgkqxVCfs7L+3NmBRarekqa/EmQOC01AtQpwGeE2vsqH6WZFw
	IZxIBiLRXB8yBVLKS+lRx7U5wyIfaBENfJjRV/FPc+2llXvZYJsBly3y7vRgJs261M0sBbPJABU
	B4ZxVOYp1DBNDvna4JVbVnJn+EvGQyngMJmeB8e3d
X-Gm-Gg: ATEYQzy4RyQ6D81JWYT0OIx1ksKwx27OhdXUMse6sVsK/7bOFa2pVvuVv/O7VwNa0wO
	u1B31vUDkD1kDegfzn5D6ZDdrpsGfWCuI6uym3NseSP0ZjEvMXImZZoBdTKTJxBLJLDsRZYTuC8
	g9pITgzWgpWSX5w0HRh0AHUZbGLKNNB2MaoKzIAhD9pDDeAH9JbBwxm2wRLPLFynLAO8lRhuXKN
	A1l+31vNfpBx+ZGxfkNZYqQYdMEKnKKXo0JoybwHsUntY53CMng6AJ8yCki3x7TCLEUPr1mprUn
	6KgPqHmP6DTjZdIWPxKGC0SyCXwQPJgCHqnKBtJXkdCLPY4MrctAnJdzhUUP3z6KRviTqBFa
X-Received: by 2002:a17:906:6a1a:b0:b8f:bb98:b8f6 with SMTP id
 a640c23a62f3a-b93f11c5ad3mr265537366b.19.1772685723621; Wed, 04 Mar 2026
 20:42:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260304111517.2088694-1-kmta1236@gmail.com>
In-Reply-To: <20260304111517.2088694-1-kmta1236@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 4 Mar 2026 20:41:50 -0800
X-Gm-Features: AaiRm51le4VIOnY5bCLbPnwrxhsRbSgcv1k1w5UJIrgYGqVkL7f7CO9wRGze_zY
Message-ID: <CAAVpQUD0gfpzZaMDBNuK2RQ1U5=3=5u-gb-jpLMxFvYPYQ+-Ow@mail.gmail.com>
Subject: Re: [PATCH net-next V2 RESEND] tcp: shrink per-packet memset in __tcp_transmit_skb()
To: Keita Morisaki <kmta1236@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 3:15=E2=80=AFAM Keita Morisaki <kmta1236@gmail.com> =
wrote:
>
> Use struct_group() to group the three fields in tcp_out_options that are
> read unconditionally by tcp_options_write() and bpf_skops_write_hdr_opt()
> (mss, bpf_opt_len, num_sack_blocks), then replace the full-struct memset
> with a targeted memset of only that group.
>
> struct tcp_out_options is 40 bytes without MPTCP and 96 bytes with
> CONFIG_MPTCP=3Dy (typical distro config). Every remaining field is either
> assigned before first use by tcp_established_options()/tcp_syn_options(),
> or gated behind its OPTION_* flag in tcp_options_write(). This memset
> runs on every transmitted TCP packet, so shrinking it from 96 (or 40)
> bytes to 4 bytes reduces per-packet overhead on the hot path.
>
> Assembly comparison (x86-64, GCC 13, CONFIG_MPTCP=3Dy):
>
>   Before: rep stos zeroing 96 bytes (5 instructions, 12 8-byte stores)
>   After:  movl $0x0 zeroing 4 bytes (1 instruction, 1 store)
>
> Also add opts->options =3D 0 at the top of tcp_syn_options(), which
> already used |=3D without a prior clear. tcp_established_options() alread=
y
> clears opts->options at its top.
>
> Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Keita Morisaki <kmta1236@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
